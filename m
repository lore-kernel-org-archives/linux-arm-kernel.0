Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331ABC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:28:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA70420834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g9+a1PiL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Wy7u0n8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA70420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=n6rRVIJactp8BGVldJiNUm60hbaLIuxLgtDt7cJyjD0=; b=g9+
	a1PiLKZEoV6XvMvbPUNB1E3hfId/ZuIZjxvaJXPFBhPsrBMSlMZ6VLiln3roVarz1g7PyaI71SwTq
	Qf6VnzOH5S15ppE6idHRraMVPseIADlE5JCJQ03TJOQBXVbSWLjYfnjPmBelLT3c5gNy9LFzIUkQ4
	xszmPibZ+2Cc/WW67gTYcOuzWnxQ0/ThZsh6fG17Yf6pHTjb6sRwSnoIfK9X1lbZXmAm4RfmEC4bq
	IZkvyBf0sY/EbW+AhtG40oDWvoId7VCwEnEQV4CAdCYwhdaTo7Ao7kPFq/E0pKbEr+SvoscB4235D
	rASIBPTEW8JmfrDASDpkxL3QeJ5q7zA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSt8k-0001Yo-G2; Sat, 01 Dec 2018 00:28:10 +0000
Received: from conuserg-08.nifty.com ([210.131.2.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSt8h-0001YF-G1
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:28:09 +0000
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp
 [218.220.227.105]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id wB10RbUH028422;
 Sat, 1 Dec 2018 09:27:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB10RbUH028422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1543624058;
 bh=HRZCOfVhmMCh+LM9JPpkzG1F8H/g9338tefVQ7sAm+U=;
 h=From:To:Cc:Subject:Date:From;
 b=Wy7u0n8xdeJaTVrAA4/BBGWwoDe1omx7m+aWF/Sp4DKlaq8mqSAT/VCHkeQwSfG4z
 UpnKiYHaLWxrufTChqBngIDdI2a62xfr/DGM1UQPLHsmcb1BOiXGDc3YioOoGzYqJb
 ELyDJZJ7B6Gh8BC3BJe3GNcEU9CiFswlndUU/U2OUKUd59NtVoXyi/AnZxhILXhWVe
 tqfUn/yOJ55vFUnYFmIsYfk/ZlluccV/k3E/hD1dsVLputURQeBbG04tx9Rv4eQLgo
 p0QB/dToB/j7uOARF3V5yUOncYlc334eS4TNosHxdcZFugO1hHl948Ty9+jHEw6/qL
 jI2K9Yw6O+/Yg==
X-Nifty-SrcIP: [218.220.227.105]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: move .SECONDARY special target to Kbuild.include
Date: Sat,  1 Dec 2018 09:27:15 +0900
Message-Id: <1543624035-4479-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_162807_882017_871E2682 
X-CRM114-Status: UNSURE (   9.50  )
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michal Marek <michal.lkml@markovi.net>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In commit 54a702f70589 ("kbuild: mark $(targets) as .SECONDARY and
remove .PRECIOUS markers"), I missed one important feature of the
.SECONDARY target:

  .SECONDARY with no prerequisites causes all targets to be treated
   as secondary.

Kbuild's policy is, "Do not delete any intermediate files."
So, just move it to scripts/Kbuild.include, with no prerequisites.

Note:
If an intermediate file is generated by $(call if_changed,...), you
still need to add it to "targets" so its .*.cmd file is included.

The arm/arm64 crypto files are generated by $(call cmd,shipped),
so they do not need to be added to "targets", but need to be added
to "clean-files" so "make clean" can properly clean them away.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/crypto/Makefile   | 2 +-
 arch/arm64/crypto/Makefile | 2 +-
 scripts/Kbuild.include     | 3 +++
 scripts/Makefile.build     | 4 ----
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index bd5bcee..89f88ab 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -65,4 +65,4 @@ $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
 	$(call cmd,perl)
 endif
 
-targets += sha256-core.S sha512-core.S
+clean-files += sha256-core.S sha512-core.S
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index f476fed..860d931 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -75,4 +75,4 @@ $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
 endif
 
-targets += sha256-core.S sha512-core.S
+clean-files += sha256-core.S sha512-core.S
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index bb01555..0454916 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -393,3 +393,6 @@ endef
 
 # delete partially updated (i.e. corrupted) files on error
 .DELETE_ON_ERROR:
+
+# do not delete intermediate files automatically
+.SECONDARY:
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a8e7ba9..604096a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -546,8 +546,4 @@ $(shell mkdir -p $(obj-dirs))
 endif
 endif
 
-# Some files contained in $(targets) are intermediate artifacts.
-# We never want them to be removed automatically.
-.SECONDARY: $(targets)
-
 .PHONY: $(PHONY)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
