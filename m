Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92412C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6027B21934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sro44q5a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ldiW9XVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6027B21934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Qi4SNoK9msFnvGdjcNOca64sUWeBH8ADvzBqbs1ZSn0=; b=sro44q5a+U6nTLv9i38HszOF6d
	gsBYiGt8WQjSZfbPyREV/hFEVlwcTgB8helMM9ACAJqF+AZjmONEHgX9fSIU+/YVCc5LWOdMltIVt
	0rz4z3WYkoQY5ySCVGyyrl9LjaziMalvZxk3ziOJNecrSdVb6vcBjwZP9UmPOnea9H6H3GRlXYC2S
	EdN25ze/LSwknrK0mQ6NWtJmz0rEC+q+x++DR2uInN47b5pX7kWCJI9ipQyzvm2RwAeSXVi2XwsI/
	e7JvLO8RcbaapBiS8m6goYZeVfYObXc9SOe+IRBn/XOoYkWGgGtgzvg83vcp7x53KT641bDqDdGNb
	RZ04jFYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmwNb-0000L2-Ho; Fri, 25 Jan 2019 07:58:23 +0000
Received: from conuserg-07.nifty.com ([210.131.2.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmwNK-0008Vi-NF
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:58:08 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x0P7vbeQ015362;
 Fri, 25 Jan 2019 16:57:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0P7vbeQ015362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1548403059;
 bh=sQk/Dl7wT+orikM5quGi46hn80YeahxI8cR8k21DNNg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ldiW9XVUC/PtcuxprwPTitYPJcLNuct06cwidyKmc3cWNRozxN49E0CzZyTHjHuEM
 LxEk+58t1/ttcZ0ek4p8twvltL6Eu/rxjoQH2zC9c3Ev7laYbbQMmSi8OFh9so3qaU
 9YOqe1QdnuN1oqqW4NMbIMLcBpbk2kOOt84Zhbjo5iXNzPCBL6ccaP+7ybA35fK3ot
 j9IGhVlAc+LCzgv1Cfu5SIJzwcr1okRmA4QjCxCJlJ/0KRcf4hseJaalozg/3REkve
 Uw2VzNR2D6nwa1AGaCMaEFdG3sxiRRpKimjwdl8KDceMvCJEl1Mkxiw6q2qH8AU6/z
 WtnlUbPBpAt8Q==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH 2/3] KVM: arm/arm64: remove -I. header search paths
Date: Fri, 25 Jan 2019 16:57:29 +0900
Message-Id: <1548403050-6585-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_235806_993044_E2D62B68 
X-CRM114-Status: UNSURE (   8.05  )
X-CRM114-Notice: Please train this message.
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The header search path -I. in kernel Makefiles is very suspicious;
it allows the compiler to search for headers in the top of $(srctree),
where obviously no header file exists.

I was able to build without these extra header search paths.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/kvm/Makefile   | 3 +--
 arch/arm64/kvm/Makefile | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 48de846..bca775e 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -9,8 +9,7 @@ ifeq ($(plus_virt),+virt)
 endif
 
 ccflags-y += -Iarch/arm/kvm -Ivirt/kvm/arm/vgic
-CFLAGS_arm.o := -I. $(plus_virt_def)
-CFLAGS_mmu.o := -I.
+CFLAGS_arm.o := $(plus_virt_def)
 
 AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
 AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 0f2a135..3089b31 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -4,8 +4,6 @@
 #
 
 ccflags-y += -Iarch/arm64/kvm -Ivirt/kvm/arm/vgic
-CFLAGS_arm.o := -I.
-CFLAGS_mmu.o := -I.
 
 KVM=../../../virt/kvm
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
