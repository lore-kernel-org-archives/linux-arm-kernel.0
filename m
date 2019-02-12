Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3ADC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:47:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FA9222C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ndu+ok+S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WfaLrreB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FA9222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=INbgDxmuPJ8FAMfhROfIgXPANb+Y7GszMVEQmYaV9J8=; b=ndu+ok+S2G83bx
	cb3ewG+cWkdv6/SSlrDDh1cWhwfNB22A1+uFJgeCk5pCDC95g1gFkP/SbN4SvUy+NxrnPerZSw41U
	K1fvGYQ/7Nnhui1DKHKrgS4LsDt8QaPy6WBiL5STVBzKxjIoON2qH7vDlopXgSS5zXX/FfXbel2T0
	RkJ520FXcjQNvXOcYHb5cwryCSe/JVYdkpy1BPIllIJdnkEecdegb42m4sb56DxOQInJjz7uUTRvR
	JoK3UP1SjxHFrd+ZY2n7MrxoYwTdZwOAuP89Jt+eCmwvM4kD1/nJzBkQnffhK/Mf/u+q5HM/c7oF9
	9xfVL7+qPWPc/y7ohUSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gte1D-0005QH-Pa; Tue, 12 Feb 2019 19:46:59 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gte1A-0005Pu-M0
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 19:46:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+t43Pjuo/NHKUrfGXrgu7Cq6cmnYI5b5l+1d1VB/cZU=; b=WfaLrreBm2bQ6xKhoFAzBQhdi
 oyX8fhL1PFdEEPZI8laviquVNcR3HWdvnTsNSg+wOr6h6iqZ+37m5bqmSJZ2PGwN8Dq5X4nnwXjxR
 qvWYGXymb8/P49FbavZrDfLwOqu75Shj5rpWttqZXfUfUd9QhHuJLeN5bL1n8tTUtck1U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gte10-0006aG-El; Tue, 12 Feb 2019 19:46:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 4FB381125B06; Tue, 12 Feb 2019 19:46:45 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64: crypto: Disable xor-neon build when using clang
Date: Tue, 12 Feb 2019 19:46:45 +0000
Message-Id: <20190212194645.32504-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_114656_875401_C130970F 
X-CRM114-Status: GOOD (  14.57  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jackie Liu <liuyun01@kylinos.cn>,
 ndesaulniers@google.com, Mark Brown <broonie@kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently clang is able to build an arm64 defconfig or allmodconfig
using the release branch for clang 8 apart from a series of errors in
xor-neon.c in the form:

  arch/arm64/lib/xor-neon.c:27:28: error: incompatible pointer types assigning to 'const unsigned long *' from 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]

This issue has been extensively discussed between various interested
parties but it is still unclear what if any the best solution is in the
compiler and there are concerns about just disabling the warning with a
pragma in the header due to the potential for masking other serious
issues.  Details of the discussion can be followed here:

   https://github.com/ClangBuiltLinux/linux/issues/283

In order to avoid the issue and facilitate further clang work and
testing for the time being just disable the use of xor-neon.c if we are
building with clang.  Obviously this is not actually resolving the
problem and is not something that should be with us for the long term
but since it only affects clang and enables people working on that to
work directly with upstream it seems like a useful tradeoff.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

It would also be possible to achieve the same effect by using either a
Makefile change or a pragma to disable the warning for this specific
file, I can send a patch for those approaches if that's OK and
preferable.  Disabling the acceleration entirely seemed safer and less
likely to be forgotten to me.

We've got some KernelCI support for clang in the middle of getting
deployed:

   https://staging.kernelci.org/job/next-clang/branch/master/

so being able to build and run upstream kernels directly would be
enormously helpful.

 arch/arm64/include/asm/xor.h | 2 +-
 arch/arm64/lib/Makefile      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
index 856386ad076c..971b8336d2d2 100644
--- a/arch/arm64/include/asm/xor.h
+++ b/arch/arm64/include/asm/xor.h
@@ -14,7 +14,7 @@
 #include <asm/hwcap.h>
 #include <asm/neon.h>
 
-#ifdef CONFIG_KERNEL_MODE_NEON
+#if defined(CONFIG_KERNEL_MODE_NEON) && !defined(CONFIG_CC_IS_CLANG)
 
 extern struct xor_block_template const xor_block_inner_neon;
 
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 5540a1638baf..b2a5b8d56354 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -6,10 +6,12 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   strchr.o strrchr.o tishift.o
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
+ifneq ($(CONFIG_CC_IS_CLANG), y)
 obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
 CFLAGS_xor-neon.o		+= -ffreestanding
 endif
+endif
 
 # Tell the compiler to treat all general purpose registers (with the
 # exception of the IP registers, which are already handled by the caller
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
