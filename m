Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E9CC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:32:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6BD2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ADLoW9hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6BD2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=T40vpta3qiWNICDZdiBTu5fHedimdE5+PMMD4BZadX0=; b=ADL
	oW9hYQ+zKWJ5KfDle2rgf1S+f2bKVzPsvLCSNnozTgw9/z3hH8JxATVJIOY/p003TE1+d1rfgH/2z
	Gx7mjPmACkW2p6zReZiJQwzjHNZHUfsyTgjCrBe6ZjGcDE59F1kuDuFag9n6Ei1mB5575Q2hKvjHg
	8SrGWRwCIPQ8NtA5dK0CbMNOSoccllPvAS6JTT/5Hvt2H0cHeFrSVgOkjwGCSOoOwZzGFr/SWbaCu
	tuhiVzBDGnOs2UzpaetMqbpgYzcOc9oOB8RMnUBSDynhhs1xioDGHwt6sgSpGqTRMV2j+zDJxqill
	CUfk7dRdaViVzEEJLfoLqLxbBZIRUkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5KV-0004oW-9s; Fri, 08 Feb 2019 12:32:27 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5KR-0004ne-V5
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:32:25 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 08 Feb 2019 21:32:23 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 26F8560062;
 Fri,  8 Feb 2019 21:32:23 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Fri, 8 Feb 2019 21:32:23 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id E6D174036D;
 Fri,  8 Feb 2019 21:32:22 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id CDC701202F1;
 Fri,  8 Feb 2019 21:32:22 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/15] dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V
 pinctrl description
Date: Fri,  8 Feb 2019 21:33:07 +0900
Message-Id: <1549629187-3177-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_043224_126716_D9FFC3FE 
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
 Linus Walleij <linus.walleij@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add DT bindings document for Milbeaut M10V pinctrl.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../pinctrl/socionext,milbeaut-pinctrl.txt         | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
new file mode 100644
index 0000000..6b54191
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
@@ -0,0 +1,35 @@
+Milbeaut SoCs pin controller
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,milbeaut-m10v-pinctrl"  - for m10v SoC
+- reg: offset and length of the register set.
+- reg-names: should be "pinctrl", "exiu".
+- gpio-controller: marks the device node as a gpio controller.
+- gpio-cells: should be 2.
+- interrupt-controller: marks the device node as a interrupt controller.
+- interrupt-cells: should be 2.
+- clocks: phandle to the input clock.
+- interrupts: three interrupts specifer.
+- interrupt-names: corresponds "interrupts" factor.
+
+Example:
+	pinctrl: pinctrl@1d022000 {
+		compatible = "socionext,milbeaut-m10v-pinctrl";
+		reg = <0x1d022000 0x1000>,
+			<0x1c26f000 0x1000>;
+		reg-names = "pinctrl", "exiu";
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&clk 2>;
+		interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
+				<0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
+				<0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
+				<0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
+		interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
+				"pin-52", "pin-53", "pin-54", "pin-55",
+				"pin-56", "pin-57", "pin-58", "pin-59",
+				"pin-60", "pin-61", "pin-62", "pin-63";
+	}
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
