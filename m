Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A19BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:16:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE033214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cU/hR/v2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T5ACgltF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE033214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bos20PZOCZhpaZjfm8oiWEQm9V8Yjt7bAKZdNzI+Xlc=; b=cU/hR/v2gvLMNG
	nmZZpASgf83lGbhQYy5L4t7TVKsn8Lp6vTc1A/XGsZieIORDZW+iG0hB5P8KSi3GXQAPQu+VhowXG
	5l4+tXzM2cZmAtBBWNg4hffW/1tV67Q+vn/gwaX0Dk4z9irYJrSJYFCD3lQlCCTMrNxCuzetN3cfq
	BvCSlNirShEi2FfiJWN72SKpJ5cMWfBEUQckPKNCZP+hXhRo+HNcUlfEhsMwbL7l2CjtxEEChazMO
	uBsHM0HzAWq4fCJlnyrHoA9Mad+q3WCbcyZO9b4zm4pVvGtVgHU7hIA7rAzo8UfsYmeM5ZWZvBoiH
	y2ZL8hHQjPYD1xuyKamw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcOy7-0000LZ-G2; Thu, 27 Dec 2018 06:16:31 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcOwA-0005T4-Px
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 06:14:37 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBR6E9g9027166;
 Thu, 27 Dec 2018 00:14:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545891249;
 bh=gzY+E3sKw6i5+tTBUwnXblBXrepkdRPhOqL8uKg73WU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=T5ACgltF8jgL/ymiCVIqym0nvSJpk8F50RgG/iMCTEB5IH3r3sEtnKb9xL5SbnBp1
 bGkcNdzLPgqL3mvOBM7t9nzbi8PghFeiosOXLUDVkfUeTXABgJuJJXrSdKlPv89ffh
 8G8ezW9GwHQTawpyTZRfN2PQ+PNfMf+TZbZ5f+j4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBR6E9ZJ125920
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Dec 2018 00:14:09 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 27
 Dec 2018 00:14:09 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 27 Dec 2018 00:14:09 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBR6DRrH026064;
 Thu, 27 Dec 2018 00:14:06 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar
 <ssantosh@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>
Subject: [RFC PATCH v4 11/13] dt-bindings: irqchip: Introduce TISCI Interrupt
 Aggregator bindings
Date: Thu, 27 Dec 2018 11:43:11 +0530
Message-ID: <20181227061313.5451-11-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181227061313.5451-1-lokeshvutla@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_221431_133629_3093B25B 
X-CRM114-Status: GOOD (  18.83  )
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
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the DT binding documentation for Interrupt Aggregator driver.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 .../interrupt-controller/ti,sci-inta.txt      | 74 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
new file mode 100644
index 000000000000..17b1fbd90312
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
@@ -0,0 +1,74 @@
+Texas Instruments K3 Interrupt Aggregator
+=========================================
+
+The Interrupt Aggregator (INTA) provides a centralized machine
+which handles the termination of system events to that they can
+be coherently processed by the host(s) in the system. A maximum
+of 64 events can be mapped to a single interrupt.
+
+
+                              Interrupt Aggregator
+                     +-----------------------------------------+
+                     |      Intmap            VINT             |
+                     | +--------------+  +------------+        |
+            m ------>| | vint  | bit  |  | 0 |.....|63| vint0  |
+               .     | +--------------+  +------------+        |       +------+
+               .     |         .               .               |       | HOST |
+Globalevents  ------>|         .               .               |------>| IRQ  |
+               .     |         .               .               |       | CTRL |
+               .     |         .               .               |       +------+
+            n ------>| +--------------+  +------------+        |
+                     | | vint  | bit  |  | 0 |.....|63| vintx  |
+                     | +--------------+  +------------+        |
+                     |                                         |
+                     +-----------------------------------------+
+
+Configuration of these Intmap registers that maps global events to vint is done
+by a system controller (like the Device Memory and Security Controller on K3
+AM654 SoC). Driver should request the system controller to get the range
+of global events and vints assigned to the requesting host. Management
+of these requested resources should be handled by driver and requests
+system controller to map specific global event to vint, bit pair.
+
+Communication between the host processor running an OS and the system
+controller happens through a protocol called TI System Control Interface
+(TISCI protocol). For more details refer:
+Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+TISCI Interrupt Aggregator Node:
+-------------------------------
+- compatible:		Must be "ti,sci-inta".
+- reg:			Should contain registers location and length.
+- interrupt-controller:	Identifies the node as an interrupt controller
+- #interrupt-cells:	Specifies the number of cells needed to encode an
+			interrupt source. The value should be 4.
+			First cell should contain the TISCI device ID of source
+			Second cell should contain the event source offset
+			within the device
+			Third cell specified the interrupt number(vint)
+			reaching Interrupt aggregator.
+			Fourth cell specifies the trigger type as defined
+			in interrupts.txt in this directory.
+- interrupt-parent:	phandle of irq parent for TISCI intr.
+- ti,sci:		Phandle to TI-SCI compatible System controller node.
+- ti,sci-dev-id:	TISCI device ID of the Interrupt Aggregator.
+- ti,sci-rm-range-vint:	TISCI subtype id representing the virtual interrupts
+			(vints) range within this IA, assigned to the
+			requesting host context.
+- ti,sci-rm-range-global-event:	TISCI subtype id representing the global
+			events range reaching this IA and are assigned
+			to the requesting host context.
+
+Example:
+--------
+main_udmass_inta: interrupt-controller@33d00000 {
+	compatible = "ti,sci-inta";
+	reg = <0x0 0x33d00000 0x0 0x100000>;
+	interrupt-controller;
+	interrupt-parent = <&main_navss_intr>;
+	#interrupt-cells = <4>;
+	ti,sci = <&dmsc>;
+	ti,sci-dev-id = <179>;
+	ti,sci-rm-range-vint = <0x0>;
+	ti,sci-rm-range-global-event = <0x1>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 4480eb2fe851..aebce615151e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15024,6 +15024,7 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
 
 Texas Instruments ASoC drivers
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
