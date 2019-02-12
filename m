Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C88AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:45:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E4C206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uth2YKi3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FX0z+zhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E4C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6MiACumaWLcqgNlawbb5DVQPZRshIbbvR2JAGq8CVCk=; b=Uth2YKi3+BUe+T
	yOYz8oOcSLcsZPKnOHAGf+O5DLZ43NJi6Ru7Rv8sF0It0K7cySgxmGeuyvlE776cK7DbZmrUjphOg
	qb0B8zw7QBl+jsRYiDx/BxVdoncOJO8Xd1Bta1suzlOlXBUhI1jj6/+Xagyd1oPWh/tSNUpMxrXq7
	f2BP4S3fc7l6zYPHgn6zKUZyc5vZg+0CJTRxjpahKcBVJFuhuy0oIHHh88P6xGgG6HcmSxo8FucyQ
	S+qLm9IN/vyiaLgGYZe2WQZaOtqOGr99PMc1rvodXONma3LrIj/8KhAlJEqf/GHWlRst1AcbYs+ES
	+BG8Xonu7fFn6SktjV9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtSku-0006mh-3y; Tue, 12 Feb 2019 07:45:24 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtSjF-0004Z3-IT
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 07:44:08 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C7hSUa017854;
 Tue, 12 Feb 2019 01:43:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549957409;
 bh=8PkE/JRhVH8yDMxuXQt13A16ub5lTk8UaNSN0j2XZ7k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FX0z+zhwG+iuUPGNWXKoy0oYprEDYTZKiPFdJvyzkLJ5qFW23TwzEf6uwGuI2A5T+
 8z7MG03OtPI53DPaQpSa5rU20Owr6yxAjiBlPhzAF/PSS7v2Hawb1OBKEmymGm27gA
 WJgqVCfZylOPpxjVWElLUPvE9OBsEvXtMDKDAdOU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C7hSfi022681
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Feb 2019 01:43:28 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 01:43:28 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 01:43:28 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C7gss3000385;
 Tue, 12 Feb 2019 01:43:24 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: <marc.zyngier@arm.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon
 <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>
Subject: [PATCH v5 07/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 Aggregator bindings
Date: Tue, 12 Feb 2019 13:12:34 +0530
Message-ID: <20190212074237.2875-8-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190212074237.2875-1-lokeshvutla@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_234342_142710_A0B2EFEA 
X-CRM114-Status: GOOD (  18.21  )
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
Changes sine v4:
- None

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
index 823eeb672cf0..970c732b7158 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15065,6 +15065,7 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
 F:	drivers/irqchip/irq-ti-sci-common.c
 F:	drivers/irqchip/irq-ti-sci-common.h
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
