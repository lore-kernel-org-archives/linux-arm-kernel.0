Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F29EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFDC20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JXMahStQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFDC20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xbuaVDwizQrRSlZ7lRV4pPI0NbHrW41JONNlkCq8Ciw=; b=JXM
	ahStQLOurA+QyKuM5kGSE6Y4dlOmxsZFYU67L55bC1AkUtbLMnA6tl9NBLy/GcjPcqjBIGHpvhVtp
	O4avVHNhU9Uum/0IgTDfgqLcbXnwn/KVwrEPEH9rI761DxCMVAyyPAXj3pqxM+yFncy1Nae/lJbA/
	gpgQqM/pg3y1TizwxKO/Bn1fQwzR13j48aAigqC7Va2w9WV18qlXK7j5KKTsa0xjyGjUdxUXlOfXQ
	grkS+uZiU+A3JfPxHr1yUzvcioK+8fMg32y+qeR5zR6Xuxq1dEn/P0P8BBToTjetdAnVakq+L5VRd
	UDFmJjeFwJFxvn5y1/OMVlY0hW6MUkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5DK-0005UW-3W; Fri, 08 Feb 2019 12:25:02 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5DE-0005RO-Go
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:24:58 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 08 Feb 2019 21:24:54 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 09A79180D62;
 Fri,  8 Feb 2019 21:24:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Fri, 8 Feb 2019 21:24:54 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 787901A04E1;
 Fri,  8 Feb 2019 21:24:54 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 640961202F1;
 Fri,  8 Feb 2019 21:24:54 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/15] dt-bindings: sram: milbeaut: Add binding for
 Milbeaut smp-sram
Date: Fri,  8 Feb 2019 21:25:33 +0900
Message-Id: <1549628733-30171-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042456_775931_3A81C68F 
X-CRM114-Status: GOOD (  17.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Milbeaut M10V SoC needs a part of sram for smp, so this adds the
M10V sram compatible and binding.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../devicetree/bindings/sram/milbeaut-smp-sram.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt b/Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
new file mode 100644
index 0000000..194f6a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
@@ -0,0 +1,24 @@
+Milbeaut SRAM for smp bringup
+
+Milbeaut SoCs use a part of the sram for the bringup of the secondary cores.
+Once they get powered up in the bootloader, they stay at the specific part
+of the sram.
+Therefore the part needs to be added as the sub-node of mmio-sram.
+
+Required sub-node properties:
+- compatible : should be "socionext,milbeaut-smp-sram"
+
+Example:
+
+        sram: sram@0 {
+                compatible = "mmio-sram";
+                reg = <0x0 0x10000>;
+                #address-cells = <1>;
+                #size-cells = <1>;
+                ranges = <0 0x0 0x10000>;
+
+                smp-sram@f100 {
+                        compatible = "socionext,milbeaut-smp-sram";
+                        reg = <0xf100 0x20>;
+                };
+        };
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
