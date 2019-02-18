Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3081C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:28:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E1021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ik7XCBUz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ktbJ1t5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E1021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JrRsW0bzpxHHphv8POhS6S5SWq0Si+ii0cSmpUNXPrM=; b=ik7XCBUzgIGdTM
	gTQ4V9PVDEv6h1z7HKFNBQKL9st9GEM56yEsgvH6upl9Q6/BhTfvaizG7JLJl2uaX5QmWRY7w/hKr
	wtI+7hQkI4lSswtl/ZaXrqxmsJdGG+XQa99zfRVgKUDqu7MqjhymUj2vtnsEhhSr2CyjQMxU9PFfb
	2NYkltcoDFpjuBLTNRYaFYIUTvlRVINj+f9HEVzsTxEVr6koi5jfkurRVTLa26qWVb9BEPoEqXuP2
	LUIICUpKcje1RMWgCxDrTVYLDuSsDeppI0L29s+ONKBbsqFsA39GdCMa0hsw12A367GjXSvjrMCer
	MPuFl8KJN5XQdt8V8pjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkpy-0006CZ-RM; Mon, 18 Feb 2019 15:28:06 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkpv-0006CE-AQ
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:28:04 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1IFRkm0115387;
 Mon, 18 Feb 2019 09:27:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550503666;
 bh=miwyYbk1jOcC+qDGNn9LiVtca9U6dhXM5Um/z5oRPBM=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=ktbJ1t5QIYcf3iDxJtCWJMAYPZwhVLxB7BLkrYjBbFyGAFY1S8+QKHJycmjOuv0I/
 wbHv0bu8/Kmd52ZSTIfvCTKl1avERrWAGwUU/h5eABKsgvJHAJn2JPCPHdGH8/ryga
 q0lYpQ0ynY7q+fS+qmEu5rFJ0VaV/H4B/2YZGTCs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1IFRk8v049118
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Feb 2019 09:27:46 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 09:27:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 09:27:46 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1IFRfqn029950;
 Mon, 18 Feb 2019 09:27:42 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To: Marc Zyngier <marc.zyngier@arm.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190218150738.527a0507@why.wild-wind.fr.eu.org>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <d67d993a-e2c0-676c-5b83-f6722796e5be@ti.com>
Date: Mon, 18 Feb 2019 20:57:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190218150738.527a0507@why.wild-wind.fr.eu.org>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_072803_436750_F6476B46 
X-CRM114-Status: GOOD (  24.11  )
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
Cc: Nishanth Menon <nm@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>, jason@lakedaemon.net,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On 18/02/19 8:42 PM, Marc Zyngier wrote:
> On Tue, 12 Feb 2019 13:12:32 +0530
> Lokesh Vutla <lokeshvutla@ti.com> wrote:
> 
>> Add the DT binding documentation for Interrupt router driver.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> Changes since v4:
>> - None
>>
>>  .../interrupt-controller/ti,sci-intr.txt      | 85 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 86 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> new file mode 100644
>> index 000000000000..4b0ca797fda1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> @@ -0,0 +1,85 @@
>> +Texas Instruments K3 Interrupt Router
>> +=====================================
>> +
>> +The Interrupt Router (INTR) module provides a mechanism to route M
>> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
>> +to be driven per N output. There is one register per output (MUXCNTL_N) that
>> +controls the selection.
>> +
>> +
>> +                                 Interrupt Router
>> +                             +----------------------+
>> +                             |  Inputs     Outputs  |
>> +        +-------+            | +------+             |
>> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
>> +        +-------+            | +------+             |      controller
>> +                             |    .        +-----+  |      +-------+
>> +        +-------+            |    .        |  0  |  |----->|  IRQ  |
>> +        | INTA  |----------->|    .        +-----+  |      +-------+
>> +        +-------+            |    .          .      |
>> +                             | +------+      .      |
>> +                             | | irqM |    +-----+  |
>> +                             | +------+    |  N  |  |
>> +                             |             +-----+  |
>> +                             +----------------------+
>> +
>> +Configuration of these MUXCNTL_N registers is done by a system controller
>> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
>> +controller will keep track of the used and unused registers within the Router.
>> +Driver should request the system controller to get the range of GIC IRQs
>> +assigned to the requesting hosts. It is the drivers responsibility to keep
>> +track of Host IRQs.
>> +
>> +Communication between the host processor running an OS and the system
>> +controller happens through a protocol called TI System Control Interface
>> +(TISCI protocol). For more details refer:
>> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> +
>> +TISCI Interrupt Router Node:
>> +----------------------------
>> +- compatible:		Must be "ti,sci-intr".
>> +- interrupt-controller:	Identifies the node as an interrupt controller
>> +- #interrupt-cells:	Specifies the number of cells needed to encode an
>> +			interrupt source. The value should be 4.
>> +			First cell should contain the TISCI device ID of source
>> +			Second cell should contain the interrupt source offset
>> +			within the device
>> +			Third cell specifies the trigger type as defined
>> +			in interrupts.txt in this directory.
>> +			Fourth cell should be 1 if the irq is coming from
>> +			interrupt aggregator else 0.
> 
> This is odd. Doesn't the aggregator have a device ID too, which could
> be used to discriminate between the two?

For that we have to store the list of INTA device IDs connected to the INTR in
the router driver. Again we have to get this list from DT. I felt this is easier
to differentiate the INTA interrupts. If you prefer to get the list of ids and
store it in INTR driver, I can change that by adding an extra DT property.

I guess you assumed that there is a single INTA attached to an INTR. There are
cases where there are more than one INTA connected to INTR. We will have to
handle that as well.

Thanks and regards,
Lokesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
