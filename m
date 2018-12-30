Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:09:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3047A2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MVQ1azhs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="k/nU8YDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3047A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pwIdW3F1XJMG8cPUsNZNQth4T5bMOM25KE3TmuqAYIQ=; b=MVQ1azhsYXtnGC
	QG8Z5DLDfjK15wVYeoYU25PwnZ5MVXZuivJ3tfQgRsaVh0XnVspq5ryFdk0bvCCs5d4Y253WkIlOa
	Ou9fMVKZnyhZL+xcD4J+JCvol1AvZuGa0sih+MHgGayYi2KJJXUSQt1At3QC1aYg1bN6USw5NsuRp
	bxcbjeile+KpN0CYzHpoarEpFLp5FIvCfmQpWJCFhBqWOeBXuW+qr5XHFwIT7HaZ2HhKbbYFbAzB9
	TIdut3xb27zJAKlWcb90FFgmIxA050QEv0eE/xhFua4uzFEWZ/V5GpNUOmk3mVNy1uwfaR22Jt5Az
	xbaK0kJHJMEIgCvS0FxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gddeH-0007Hm-DI; Sun, 30 Dec 2018 16:09:09 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdddi-0006ly-63
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 16:08:37 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 3C1735C09B9;
 Sun, 30 Dec 2018 17:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546186096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=HaH+ectJntGjYeol3GIRZzeglaAV6+fvFtypLoSDJlo=;
 b=k/nU8YDrqgVgTTht/tKsdyXMqQPlj6oxZyEfAzEI6cjBCJ+jSNWPr3iyvzP0EucyoRcFq4
 oxK25DEUFmdbAEmnPREVKxcF+v72w2QrMcVhNVzbU5vRFsEL4hPKvRNQThS/Mni3cGKAEZ
 Os+jIYJFNaEAv2/7HOa2vYRWslJ6CY0=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH 0/3] ARM: trivial assembly fixes to enable LLVM as
Date: Sun, 30 Dec 2018 17:08:16 +0100
Message-Id: <cover.1546185298.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_080834_431899_4A39CC62 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: nicolas.pitre@linaro.org, mark.rutland@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, peterz@infradead.org, will.deacon@arm.com,
 julien.thierry@arm.com, ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, mingo@redhat.com, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

During the last few days I tried compiling the kernel for ARM32 with
LLVMs integrated assembler. The elephant in the room is definitely the
unified syntax which is required by the LLVM assembler. I converted most
mnemonics using a regex, but it is not perfect and needs some manual fixes.
I am not sure if this is the right approach, feedback welcome. I plan to
send fixes in groups in the next few weeks, if that effort is welcome.

There are a couple of other issues besides unified syntax, e.g. lack of
feature argument parsing (e.g. armv7-a+sec).

This patchset is a starting point to enable LLVM integrated assembler and
contains some trivial changes. With this patchset the LLVM integrated
assembler can be used to assemble almost all C files.

Stefan Agner (3):
  ARM: fix argument count to match macro definition
  ARM: uaccess: use unified assembler language syntax
  ARM: spinlock: use unified assembler language syntax

 arch/arm/include/asm/spinlock.h | 2 +-
 arch/arm/include/asm/uaccess.h  | 2 +-
 arch/arm/lib/copy_template.S    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
