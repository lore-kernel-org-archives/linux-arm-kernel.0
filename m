Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD3C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:28:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF85206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dPDUiZs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF85206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sg0Ws+mdwYbqAUqaO2PgBP27SUWLtkImFhf622d1yQA=; b=dPDUiZs5Oqjbs9
	JgsrTIwfLfkv9fjiq8Lo6tTzdekFw55AzlvOYtxkTl2pfJG8WdMUs2AdiZYGPh9LzaevZp3oPUPhF
	nGSMMPvAPexp7A8ydmu2WLxshnuqVc/IP/WpTkVYGH3Fes70RKjcBoGo6YKrCzFeMAHyDcLwUs/Er
	B6JQpaK8MwwlEbeJa2o+XiykmD7I4MWJImx5oPorNQoTIPYz00UEJOeCJhG2t+XB14a0dcB6SIwQy
	IRGXNQl6nsikD0CYt84fdRuWfFM8v3imXuFXnv6+vKqMO5BHodJOzrL/THWJNG6E06Dt1UbOu3pkE
	1mihAMJA6B95Outds71A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSpOV-0001cg-8v; Fri, 30 Nov 2018 20:28:11 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSpOJ-0001TP-Or; Fri, 30 Nov 2018 20:28:01 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 4AA3610A1521;
 Fri, 30 Nov 2018 12:27:53 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id aZRpao2y7NAo; Fri, 30 Nov 2018 12:27:51 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 7722010A150B;
 Fri, 30 Nov 2018 12:27:44 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 68AF12FE2D5B; Fri, 30 Nov 2018 12:27:43 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: soc: Add a new binding for the BCM2835 PM
 node.
Date: Fri, 30 Nov 2018 12:27:39 -0800
Message-Id: <20181130202743.20585-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181130202743.20585-1-eric@anholt.net>
References: <20181130202743.20585-1-eric@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_122759_858649_C0347181 
X-CRM114-Status: GOOD (  13.13  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This binding supersedes the bcm2835-pm-wdt binding which only covered
enough to provide a watchdog, but the HW block is actually mostly
about power domains.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
new file mode 100644
index 000000000000..7818d33a158f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
@@ -0,0 +1,42 @@
+BCM2835 PM (Power domains, watchdog)
+
+The PM block controls power domains and some reset lines, and includes
+a watchdog timer.  This binding supersedes the brcm,bcm2835-pm-wdt
+binding which covered some of PM's register range and functionality.
+
+Required properties:
+
+- compatible:		Should be "brcm,bcm2835-pm"
+- reg:			Specifies base physical address and size of the two
+			  register ranges ("PM" and "ASYNC_BRIDGE" in that
+			  order)
+- clocks:		a) v3d: The V3D clock from CPRMAN
+			b) peri_image: The PERI_IMAGE clock from CPRMAN
+			c) h264: The H264 clock from CPRMAN
+			d) isp: The ISP clock from CPRMAN
+- #reset-cells: 	Should be 1.  This property follows the reset controller
+			  bindings[1].
+- #power-domain-cells:	Should be 1.  This property follows the power domain
+			  bindings[2].
+
+Optional properties:
+
+- timeout-sec:	Contains the watchdog timeout in seconds
+
+[1] Documentation/devicetree/bindings/reset/reset.txt
+[2] Documentation/devicetree/bindings/power/power_domain.txt
+
+Example:
+
+pm {
+	compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
+	#power-domain-cells = <1>;
+	#reset-cells = <1>;
+	reg = <0x7e100000 0x114>,
+	      <0x7e00a000 0x24>;
+	clocks = <&clocks BCM2835_CLOCK_V3D>,
+		 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
+		 <&clocks BCM2835_CLOCK_H264>,
+		 <&clocks BCM2835_CLOCK_ISP>;
+	clock-names = "v3d", "peri_image", "h264", "isp";
+};
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
