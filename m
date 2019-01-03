Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CD2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:12:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D30E20833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j5UmViSy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UurVH6gS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D30E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iTzfLyOc7JZas1uiZBcR/m3h8BEDPpyTqMvSrEtbvPI=; b=j5UmViSyhSyZm4EZNtagvL+nXB
	Fe//0mnaJIZqLcjmhDjURyRpYlBopYXJCb9Z1GzkW1/3xDwwBan9KsuX8b5cYmgrrKv6WMi025XRP
	bb2L2gj/x35Imvob3BrtJaJ+ZjAAjR2zpl9hvxfWNeMZ2DCuyUPNgtumtGsqrWWxn+KdgxxWTsu+E
	dP48uCxDQFxCm3n1hevxahJJejOO0ZoMFLTanplF8LQntwolJ+RACeVCUVeXqyY97roHWCoG6Y0cg
	x+uzGkgd8L9M57acAqN9I2v1sJ0lo6+hCiNGnz13r2gH667hz93oEZL2MR5Fq4mbYSWjziM8uLnr0
	5nlGbxQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gerYV-0002PJ-DU; Thu, 03 Jan 2019 01:12:15 +0000
Received: from conuserg-10.nifty.com ([210.131.2.77])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gerXc-0001QO-TE; Thu, 03 Jan 2019 01:11:24 +0000
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp
 [218.220.227.105]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id x031Apkf032182;
 Thu, 3 Jan 2019 10:10:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x031Apkf032182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546477853;
 bh=5KRWRSHIDRxrnZsMIZJIuc7XWYwM/TDPLNAwLYwx6tY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UurVH6gSAHW0nUkhyjjPP+5FP6S9eZSubbxbmg42BGOGVlzkNVRCevz6gHR5sfEEm
 AeKN/r9Gpf8lj+9ZrmYo7Z400axQmMS39mNJcZDA5aIEaK/QQ1SNe9WOBUrKHptv3e
 sWvjjOWv0mAiZb9qkObkrbVPt0SIMBZIKzdlisIcl+TpLQMr7+oBUCFx2azphXF3Kv
 CYUL5YWsDfax+UXPQWzf8DPiqykc3zKS3yQdQzxlOUTQoSF4pcQXw0syhKUn0QMFJ9
 +GlocK9DKWtXI84geU14jMBNtPs1HloFEfgAPAX1O7nXWHilzy/KVxjOCfF6+tFU18
 PXtUJxGdf+dWA==
X-Nifty-SrcIP: [218.220.227.105]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 3/5] kbuild: generate asm-generic wrappers if mandatory
 headers are missing
Date: Thu,  3 Jan 2019 10:10:38 +0900
Message-Id: <1546477840-14278-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
References: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_171121_259536_1115FC17 
X-CRM114-Status: UNSURE (   9.83  )
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
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some time ago, Sam pointed out a certain degree of overwrap between
generic-y and mandatory-y. (https://lkml.org/lkml/2017/7/10/121)

I tweaked the meaning of mandatory-y a little bit; now it defines the
minimum set of ASM headers that all architectures must have.

If arch does not have specific implementation of a mandatory header,
Kbuild will let it fallback to the asm-generic one by automatically
generating a wrapper. This will allow to drop lots of redundant
generic-y defines.

Previously, "mandatory" was used in the context of UAPI, but I guess
this can be extended to kernel space ASM headers.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
  - Filter-out $(generiated-y) from $(mandatory-y) because
    ARCH may generate mandatory headers by other means

 Documentation/kbuild/makefiles.txt | 9 ++++++---
 scripts/Makefile.asm-generic       | 4 ++++
 scripts/Makefile.headersinst       | 7 -------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 8da26c6..bf28c47 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1296,9 +1296,12 @@ See subsequent chapter for the syntax of the Kbuild file.
 
 --- 7.4 mandatory-y
 
-	mandatory-y is essentially used by include/uapi/asm-generic/Kbuild.asm
-	to define the minimum set of headers that must be exported in
-	include/asm.
+	mandatory-y is essentially used by include/(uapi/)asm-generic/Kbuild.asm
+	to define the minimum set of ASM headers that all architectures must have.
+
+	This works like optional generic-y. If a mandatory header is missing
+	in arch/$(ARCH)/include/(uapi/)/asm, Kbuild will automatically generate
+	a wrapper of the asm-generic one.
 
 	The convention is to list one subdir per line and
 	preferably in alphabetic order.
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index 760323e..a62d282 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -14,6 +14,10 @@ src := $(subst /generated,,$(obj))
 
 include scripts/Kbuild.include
 
+# If arch does not implement mandatory headers, fallback to asm-generic ones.
+mandatory-y := $(filter-out $(generated-y), $(mandatory-y))
+generic-y   += $(foreach f, $(mandatory-y), $(if $(wildcard $(srctree)/$(src)/$(f)),,$(f)))
+
 generic-y   := $(addprefix $(obj)/, $(generic-y))
 generated-y := $(addprefix $(obj)/, $(generated-y))
 
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 45927fc..3d1ebaa 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -56,13 +56,6 @@ check-file    := $(installdir)/.check
 all-files     := $(header-files) $(genhdr-files)
 output-files  := $(addprefix $(installdir)/, $(all-files))
 
-ifneq ($(mandatory-y),)
-missing       := $(filter-out $(all-files),$(mandatory-y))
-ifneq ($(missing),)
-$(error Some mandatory headers ($(missing)) are missing in $(obj))
-endif
-endif
-
 # Work out what needs to be removed
 oldheaders    := $(patsubst $(installdir)/%,%,$(wildcard $(installdir)/*.h))
 unwanted      := $(filter-out $(all-files),$(oldheaders))
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
