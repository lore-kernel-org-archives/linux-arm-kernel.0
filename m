Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB711C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:52:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D76D2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pZ8Z77OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D76D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sRzURI8cIb3E3DXdlo59j4XJz5XYAAHTzff7Kd8MVRU=; b=pZ8Z77OKStFoby
	7zMXdIWRej7vSvQ99SQ8rTv6G6AHQZiW6zBXQmYDD1c1M+2u1Wy2k5BaM2MOsYCTf3MuvJE6F4++Y
	s2+shKYX+LRHvRErs54x4l4dN0ZOKzJWbv9gKK8zUEapZCTXlu1VqRcB59XCl3ouvAr40F/S29jyd
	Z9ksMsURYSOkA3zZbu4/5adGhJOxd7arG2CapksGvfcZSoCNJYS2kpZemhCMv9W9fbULABZ42IEC5
	3us05WVwRAHeQJ/4m36ztmGFTh1v5oI4MZsKRsIoCFJnrF195EPLEuzbKICdqDIw54C9AGwJeNGt0
	YMCXkyZJfMStcZfZG1jQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXEIu-0000ml-14; Wed, 12 Dec 2018 23:52:36 +0000
Received: from anholt.net ([50.246.234.109])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXEIR-0000IC-UF; Wed, 12 Dec 2018 23:52:10 +0000
Received: from localhost (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id B176910A1DB5;
 Wed, 12 Dec 2018 15:51:55 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
 by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id IVeULlcjD68n; Wed, 12 Dec 2018 15:51:53 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
 by anholt.net (Postfix) with ESMTP id 5203F10A1D70;
 Wed, 12 Dec 2018 15:51:51 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
 id 27B862FE1FF3; Wed, 12 Dec 2018 15:51:50 -0800 (PST)
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Lee Jones <lee.jones@linaro.org>, Stefan Wahren <stefan.wahren@i2se.com>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: soc: Add a new binding for the BCM2835 PM
 node. (v4)
Date: Wed, 12 Dec 2018 15:51:46 -0800
Message-Id: <20181212235150.6491-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181212235150.6491-1-eric@anholt.net>
References: <20181212235150.6491-1-eric@anholt.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_155208_015492_71C0411E 
X-CRM114-Status: GOOD (  13.03  )
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
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
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
Reviewed-by: Rob Herring <robh@kernel.org> (v3)
---

v4: Add the system-power-controller node.

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
new file mode 100644
index 000000000000..3b7d32956391
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
@@ -0,0 +1,46 @@
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
+- timeout-sec:		Contains the watchdog timeout in seconds
+- system-power-controller: Whether the watchdog is controlling the
+    system power.  This node follows the power controller bindings[3].
+
+[1] Documentation/devicetree/bindings/reset/reset.txt
+[2] Documentation/devicetree/bindings/power/power_domain.txt
+[3] Documentation/devicetree/bindings/power/power-controller.txt
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
+	system-power-controller;
+};
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
