Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15217C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C92217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SJF7WeVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C92217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I+hgX0gbzy6nvQ6LOVg6zvYeiAMTMwYVmphWSlQngVk=; b=SJF7WeVsnUr/WR
	K3BV3jlQqV79h+s2m9IhFkOdyB+gGSeHwQXrCPxLLWFy7kx0tbHq1iT8zR+s+GtLVxSJIPp+zbp2K
	ncLbSuRVMy6Jxt0XJmADRtixM9i6AGQsrdDMgyDWF9++F81n8+QmExS7nhhnji8v12ktCcYnzuJd+
	ZF+AkAW4XWRhxHNN7LP/zgdwpjzlYnsFGvRdDuK9gESzMmllozxm1oE3knsf4/rOF2zcIz35R5XMe
	3k4Q+6/gJdkbsWkCEy8XaZ9ud4DFIgCJs795oQiF3f1Y+3e+RkAyt66qYqQR+41+P9AA2Lo+MnqvA
	VCcWx+5nD2WOshLzODsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8n1-00016Q-GF; Tue, 19 Feb 2019 17:02:39 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8mb-0000d7-J8
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:02:16 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id CC8FB1BF20D;
 Tue, 19 Feb 2019 17:02:05 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/7] dt-bindings: clock: at91: new sckc bindings
Date: Tue, 19 Feb 2019 18:01:54 +0100
Message-Id: <20190219170200.3608-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_090213_773142_4AFDE46D 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove the need for child nodes in the sckc binding to be able to remove
dtc warnings and have a more modern binding.

Also document optional properties.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/clock/at91-clock.txt  | 30 ++++++++-----------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index e9f70fcdfe80..cb838c1c4bdd 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -8,29 +8,23 @@ Slow Clock controller:
 
 Required properties:
 - compatible : shall be one of the following:
-	"atmel,at91sam9x5-sckc" or
+	"atmel,at91sam9x5-sckc",
+	"atmel,sama5d3-sckc" or
 	"atmel,sama5d4-sckc":
 		at91 SCKC (Slow Clock Controller)
-		This node contains the slow clock definitions.
-
-	"atmel,at91sam9x5-clk-slow-osc":
-		at91 slow oscillator
-
-	"atmel,at91sam9x5-clk-slow-rc-osc":
-		at91 internal slow RC oscillator
-- reg : defines the IO memory reserved for the SCKC.
-- #size-cells : shall be 0 (reg is used to encode clk id).
-- #address-cells : shall be 1 (reg is used to encode clk id).
+- #clock-cells : shall be 0.
+- clocks : shall be the input parent clock phandle for the clock.
 
+Optional properties:
+- atmel,osc-bypass : boolean property. Set this when a clock signal is directly
+  provided on XIN.
 
 For example:
-	sckc: sckc@fffffe50 {
-		compatible = "atmel,sama5d3-pmc";
-		reg = <0xfffffe50 0x4>
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		/* put at91 slow clocks here */
+	sckc@fffffe50 {
+		compatible = "atmel,at91sam9x5-sckc";
+		reg = <0xfffffe50 0x4>;
+		clocks = <&slow_xtal>;
+		#clock-cells = <0>;
 	};
 
 Power Management Controller (PMC):
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
