Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E664C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:26:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D324920663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PvwOJ2gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D324920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ID8KcsWeCECrccWA3wkkBFpYXbI3F5OvQyGpPrf+Cfw=; b=Pvw
	OJ2gHHq4olqj+z3xpA180UMkz0ZwE96ZKIFFj6DY9gyXhksDzlR1d5yEUP2hTt8BEU8JN7gq2wmmN
	UuKscv2hOmeET8dg66eCnRw+VwKMgUu6/ZK0cjRkM2kL6W3YztqW+tTsRKOxbSl4UnALfwOLOXDMX
	0wo2x1AUOMp2WvS6wTqECrImzhna8jICmbthe7G+V2foUPUmaFNLMmaqi5wmT4MpWpUAd/0lLYxZa
	qbS7GGf2yOMmdIXartzeSP+9oRhgD5yMsjeBuLKZ8klwVetDmT1XVgErlJ5B7NY5I4VbWW32Um3zD
	ox7+EExtH1zAiW1wpKJs0fQKoulLYJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5F1-0008Cl-DZ; Fri, 08 Feb 2019 12:26:47 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5EZ-0007Ub-6v
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:26:37 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 08 Feb 2019 21:26:18 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id D2CCD60062;
 Fri,  8 Feb 2019 21:26:18 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Fri, 8 Feb 2019 21:26:18 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id AA4EA4036D;
 Fri,  8 Feb 2019 21:26:18 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 874BD1202F1;
 Fri,  8 Feb 2019 21:26:18 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/15] ndings: clock: milbeaut: add Milbeaut clock
 description
Date: Fri,  8 Feb 2019 21:27:03 +0900
Message-Id: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042619_493936_16662964 
X-CRM114-Status: GOOD (  16.31  )
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
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add DT bindings document for Milbeaut clock.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../devicetree/bindings/clock/milbeaut-clock.txt   | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
new file mode 100644
index 0000000..bcfc5df
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
@@ -0,0 +1,49 @@
+Milbeaut SoCs Clock Controller Binding
+----------------------------------------
+Milbeaut SoCs Clock controller is an integrated clock controller, which
+generates and supplies to all modules.
+
+This binding uses common clock bindings
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,milbeaut-m10v-ccu" - for M10V SoC
+- reg: shall contain base address and length of clock registers
+- #clock-cells: shall be 1
+- clocks: shall be an external clock
+
+Example: Clock controller node:
+
+	clk: m10v-clk-ctrl@1d021000 {
+		compatible = "socionext,milbeaut-m10v-clk-ccu";
+		reg = <0x1d021000 0x4000>;
+		#clock-cells = <1>
+		clocks = <&clki40mhz>
+	};
+
+Example: Required an external clock for Clock controller node:
+
+	clocks {
+		clki40mhz: clki40mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <40000000>;
+		};
+
+		/* other clocks */
+	};
+
+The clock consumer shall specify the desired clock-output of the clock
+controller as below by specifying output-id in its "clk" phandle cell.
+2: uart
+4: 32-bit timer
+
+Example: uart1 node:
+	uart1: serial@1e700010 {
+		compatible = "socionext,milbeaut-usio-uart";
+		reg = <0x1e700010 0x10>;
+		interrupts = <0 141 0x4>, <0 149 0x4>;
+		interrupt-names = "rx", "tx";
+		clocks = <&clk 2>;
+	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
