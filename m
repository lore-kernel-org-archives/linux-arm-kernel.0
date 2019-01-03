Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A589C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:12:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1687620833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EVhy/Q2L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WU55Mw1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1687620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/mfOI5QgrDHheqWB7f4wcRGXjyJzIVtZqFXcRIITg+Y=; b=EVhy/Q2Lx9YT87ODRwo6LwBIj1
	KJ8rJwaDpbpCuNwZ7XQ6ymN4SR6/kIjMyBdjncdDXtSs96+0RREyGqROWTFLVO8fUko5qbz2Ztogk
	ZeZurz4d4nvFjfrkmRc0sv0O/CzszV+FVd6OA9TwwxnEki9X0WS9fH8T5O3PMAjFyh19E7eP4mQ0j
	iQN5m7fw9RiAChKm4DgjpvpqgvMwh/4X+yYMAIBF0w+9brNFsjkBtS5sTYhctqg1ZEad5SX0mFvNi
	5ruj35Vbhkynq/hk5URu1bxyuEgOGIjqktpoZL0nftRuAvAxmFqXuY7Dx5OR2ZQgqcdpzEsditMd4
	f1kHIV9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gerYi-0002mX-SS; Thu, 03 Jan 2019 01:12:29 +0000
Received: from conuserg-10.nifty.com ([210.131.2.77])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gerXc-0001QN-TF; Thu, 03 Jan 2019 01:11:24 +0000
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp
 [218.220.227.105]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id x031Apke032182;
 Thu, 3 Jan 2019 10:10:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x031Apke032182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546477852;
 bh=PNYiwlNe//Pp66hmzWkHePNjw5wOpSMitO1Z5NzpxAI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WU55Mw1ISisUe60a2tbLpCfYFU+MLqYC55KV3NNzYalJTXVSELyzhNEObOm/8hWuA
 +hxqJLsTNHRzcGGejGh9A6r8TsHRO4QyjHzefiJNVJYVVb89DfjnNWEweP7VGcumFp
 9YbRIrq/x3dQHY/br4dgxv+MT4/tiNj69N9AbwursSDQUI32jB5u7FCE25Cyr4gRjQ
 pbAHa6tPQnkaACRDJ44++lcZxDERyK6vZklWYiHtCy1xIRlglDUSOoOSIb1DthsIMv
 fCTxQ/Mx5Nuq+73Kbavk2GneZhJxY04Vc6f4a5ruBaShCA/nAPpwHrwVgSUHl4Mxxp
 6kt2PEc/NbbTw==
X-Nifty-SrcIP: [218.220.227.105]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 2/5] arch: remove stale comments "UAPI Header export list"
Date: Thu,  3 Jan 2019 10:10:37 +0900
Message-Id: <1546477840-14278-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
References: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_171121_337099_563BD78A 
X-CRM114-Status: UNSURE (   5.11  )
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

These comments are leftovers of commit fcc8487d477a ("uapi: export all
headers under uapi directories").

Prior to that commit, exported headers must be explicitly added to
header-y. Now, all headers under the uapi/ directories are exported.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 arch/alpha/include/uapi/asm/Kbuild      | 1 -
 arch/arc/include/uapi/asm/Kbuild        | 1 -
 arch/arm/include/uapi/asm/Kbuild        | 1 -
 arch/arm64/include/uapi/asm/Kbuild      | 1 -
 arch/c6x/include/uapi/asm/Kbuild        | 1 -
 arch/h8300/include/uapi/asm/Kbuild      | 1 -
 arch/hexagon/include/uapi/asm/Kbuild    | 1 -
 arch/ia64/include/uapi/asm/Kbuild       | 1 -
 arch/m68k/include/uapi/asm/Kbuild       | 1 -
 arch/microblaze/include/uapi/asm/Kbuild | 1 -
 arch/mips/include/uapi/asm/Kbuild       | 1 -
 arch/nds32/include/uapi/asm/Kbuild      | 1 -
 arch/nios2/include/uapi/asm/Kbuild      | 1 -
 arch/openrisc/include/uapi/asm/Kbuild   | 1 -
 arch/parisc/include/uapi/asm/Kbuild     | 1 -
 arch/powerpc/include/uapi/asm/Kbuild    | 1 -
 arch/riscv/include/uapi/asm/Kbuild      | 1 -
 arch/s390/include/uapi/asm/Kbuild       | 1 -
 arch/sh/include/uapi/asm/Kbuild         | 1 -
 arch/sparc/include/uapi/asm/Kbuild      | 1 -
 arch/unicore32/include/uapi/asm/Kbuild  | 1 -
 arch/x86/include/uapi/asm/Kbuild        | 1 -
 arch/xtensa/include/uapi/asm/Kbuild     | 1 -
 include/uapi/linux/Kbuild               | 2 --
 24 files changed, 25 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
index 6a3a0ce..50dea7f 100644
--- a/arch/alpha/include/uapi/asm/Kbuild
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 170b5db..42ac23e 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 4d1cc18..393fe32 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd-common.h
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 6c5adf4..eb43543 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += errno.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 26644e1..633f386 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 2f65f78..c1a994e 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index 41a176d..bcc65a2 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index ccce0ea..3536c78 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_64.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index b645291..2d75dbc 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index b6656d9..c95da41 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index ed4bd03..215d808 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_n32.h
diff --git a/arch/nds32/include/uapi/asm/Kbuild b/arch/nds32/include/uapi/asm/Kbuild
index 40be972..ddd2a28 100644
--- a/arch/nds32/include/uapi/asm/Kbuild
+++ b/arch/nds32/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index 13a3d77..37bec5d 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 130c16c..bb850fa 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index d31b426..99c0c73 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 8ab8ba1..6e7574e 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
index 5511b99..5945a59 100644
--- a/arch/riscv/include/uapi/asm/Kbuild
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += setup.h
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index dc38a90..89b4582 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index dcb9354..7ef099e 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index ae72977..7064bfb 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 8611ef9..3620f6a 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 3226816..d15343a 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index f95cad3..3ae1bbd 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index ca2787d..5f24b50 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -1,5 +1,3 @@
-# UAPI Header export list
-
 ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/uapi/asm/a.out.h),)
 no-export-headers += a.out.h
 endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
