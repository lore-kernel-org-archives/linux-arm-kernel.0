Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBDBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:09:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2592214AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r8sYp74W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rPMGkzPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2592214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Eiq5gN0sCUvdRRS9Y/1l879giKssF5NMSWdXLd6HOf8=; b=r8sYp74WIimG3v
	qJWeMP8i89OuiX5Aa1Ozi+FLDNufBM7qCn+Qy82SusssnDD8cK7SUTWoswiQCncrinUyAZQZD/SP0
	olsDfBoIPQNLRHOC0FPX3NDpDOd1Yn5g4mHGhLH4V/oFVZ2WLpP+4NIMG02NCsqLoJKvEpzBUp46y
	JUbx5PgJ5Bnkkj1bj9QUTZOesiTONlvrCL4V1pcKuGAkJsXdVIifP1YBTPPb0rISzX+sqXr1yOK/G
	Wpz1Bc9YUxDXAHITIlTh9s22UwgL7uuqD9JmTbuuJjyRHmSryw2f8i2Ddfv4H1QiiiAlj3PxyS8U3
	B0/cDSS8oxXsFqmlCFUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcOrG-0003QB-HS; Thu, 27 Dec 2018 06:09:26 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcOrA-0003Eb-CP
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 06:09:24 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBR68n3g041829;
 Thu, 27 Dec 2018 00:08:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545890929;
 bh=iRuUmYWNVYIuUkKMwyMZMj3lnIZfqK26BHn7L/Vwj0M=;
 h=From:To:CC:Subject:Date;
 b=rPMGkzPGvmMN2ynAcjtPrs3l8nWcxURprbPQq3uOQhElf7FE+BlvuNNDElzg4XFds
 Ar3GeuHbn6P2F1qQ0ovLPM3DetjE9Jx6Sy5CGUDhNuO1+UhIFIy88k0giqwPjwy7fz
 rGxLjeEKZk/ENXBcRp0BUCJ4iBW97c1HevzBOT3Y=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBR68nbB103404
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Dec 2018 00:08:49 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 27
 Dec 2018 00:08:49 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 27 Dec 2018 00:08:49 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBR68jsA020948;
 Thu, 27 Dec 2018 00:08:46 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar
 <ssantosh@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>
Subject: [PATCH v4 00/13] Add support for TISCI irqchip drivers
Date: Thu, 27 Dec 2018 11:38:16 +0530
Message-ID: <20181227060829.5080-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_220920_564409_508BD6C3 
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

TI AM65x SoC based on K3 architecture, introduced support for Events
which are message based interrupts with minimal latency. These events
are not compatible with regular interrupts and are valid only through
an event transport lane. An Interrupt Aggregator(INTA) is introduced
to convert these events to interrupts. INTA can also group 64 events
into a single interrupt. Now the SoC has many peripherals and a large
number of event sources (time sync or DMA), the use of events is
completely dependent on a user's specific application, which drives a
need for maximum flexibility in which event sources are used in the
system. It is also completely up to software control as to how the
events are serviced.

Because of the huge flexibility there are certain standard peripherals
(like GPIO etc)where all interrupts cannot be directly corrected to host
interrupt controller. For this purpose, Interrupt Router(INTR) is
introduced in the SoC. INTR just does a classic interrupt redirection.

So the SoC has 3 types of interrupt controllers:
- GIC500
- Interrupt Router
- Interrupt Aggregator

Below is a diagrammatic view of how SoC integration of these interrupt
controllers:(https://pastebin.ubuntu.com/p/9ngV3jdGj2/)

Device Index-x               Device Index-y
           |                         |
           |                         |
                      ....
            \                       /
             \                     /
              \  (global events)  /
          +---------------------------+   +---------+
          |                           |   |         |
          |             INTA          |   |  GPIO   |
          |                           |   |         |
          +---------------------------+   +---------+
                         |   (vint)            |
                         |                     |
                        \|/                    |
          +---------------------------+        |
          |                           |<-------+
          |           INTR            |
          |                           |
          +---------------------------+
                         |
                         |
                        \|/ (gic irq)
          +---------------------------+
          |                           |
          |             GIC           |
          |                           |
          +---------------------------+

While at it, TISCI abstracts the handling of all above IRQ routes where
interrupt sources are not directly connected to host interrupt controller.
That would be configuration of Interrupt Aggregator and Interrupt Router.

This series adds support for:
- TISCI commands needed for IRQ configuration
- Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers

Changes since v3:
- Fix documentation for Interrupt Router driver
- Rebased on top of latest next.
- Fully tested with DMA(using out of tree patches)
- Fixed a build error with allmodconfig

Grygorii Strashko (1):
  firmware: ti_sci: Add support to get TISCI handle using of_phandle

Lokesh Vutla (11):
  firmware: ti_sci: Add support for RM core ops
  firmware: ti_sci: Add support for IRQ management
  firmware: ti_sci: Add helper apis to manage resources
  dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
  irqchip: ti-sci-intr: Add support for Interrupt Router driver
  genirq/msi: Add support for allocating single MSI for a device
  genirq/msi: Add support for .msi_unprepare callback
  soc: ti: Add MSI domain support for K3 Interrupt Aggregator
  dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
  irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
  soc: ti: am6: Enable interrupt controller drivers

Peter Ujfalusi (1):
  firmware: ti_sci: Add RM mapping table for am654

 .../bindings/arm/keystone/ti,sci.txt          |   3 +-
 .../interrupt-controller/ti,sci-inta.txt      |  74 ++
 .../interrupt-controller/ti,sci-intr.txt      |  85 ++
 MAINTAINERS                                   |   4 +
 drivers/firmware/ti_sci.c                     | 848 ++++++++++++++++++
 drivers/firmware/ti_sci.h                     | 102 +++
 drivers/irqchip/Kconfig                       |  23 +
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-ti-sci-inta.c             | 561 ++++++++++++
 drivers/irqchip/irq-ti-sci-intr.c             | 310 +++++++
 drivers/soc/ti/Kconfig                        |  11 +
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/k3_inta_msi.c                  | 193 ++++
 include/linux/irqdomain.h                     |   1 +
 include/linux/msi.h                           |  12 +
 include/linux/soc/ti/k3_inta_msi.h            |  22 +
 include/linux/soc/ti/ti_sci_protocol.h        | 169 ++++
 kernel/irq/msi.c                              |  72 +-
 18 files changed, 2470 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
 create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
 create mode 100644 drivers/soc/ti/k3_inta_msi.c
 create mode 100644 include/linux/soc/ti/k3_inta_msi.h

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
