Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62949C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:35:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F1321736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DqQQNGs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F1321736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mc2Zkz3o9boUm5z7eInc5fV4Tei02+HLvv3CP6l3+D0=; b=DqQQNGs4xRTkwy
	3d5sbJHgGN5BdO6Y7xMU7Y3skCGpmmYXMXqqWh2h6IT+bid7Loe4FeUhXUx36AK9KGAGxRuo+rWYo
	kF464/eGZoqmQFZ81Tshk4RG8KGnc0mjIFdArWdmxgH3T5WG8o1Gfunj0vjyIQ/RuZ5QiPI8AmM9F
	qBjE4nwgg1dEDoWmwVI+9RgkX5C9Ex8gmPiv+xl9tjQ10whZyJJYWU1YwboMH+583OPFRYD2Sl+cQ
	mlZFdcIpOw0pSXItAg8wWbs6joUWEU6TYBZjMPKzG8HInqXwNgV8JiAcauuIDVsbtNMSyBtHwFUT8
	rJvVzG5aUV52LuRUZ4iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvk0p-00079T-Lb; Mon, 18 Feb 2019 14:35:15 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvk0m-000799-9g
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:35:13 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 6230B80E4;
 Mon, 18 Feb 2019 14:35:21 +0000 (UTC)
Date: Mon, 18 Feb 2019 06:35:08 -0800
From: Tony Lindgren <tony@atomide.com>
To: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190218143508.GD15711@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <41a9780b-d971-2b20-1ecb-c55852292563@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41a9780b-d971-2b20-1ecb-c55852292563@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_063512_372125_D1DAB0FF 
X-CRM114-Status: GOOD (  16.39  )
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
 Peter Ujfalusi <peter.ujfalusi@ti.com>, marc.zyngier@arm.com,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [190216 03:30]:
> On 2/12/2019 1:12 PM, Lokesh Vutla wrote:
> > +TISCI Interrupt Router Node:
> > +----------------------------
> > +- compatible:		Must be "ti,sci-intr".
> > +- interrupt-controller:	Identifies the node as an interrupt controller
> > +- #interrupt-cells:	Specifies the number of cells needed to encode an
> > +			interrupt source. The value should be 4.
> > +			First cell should contain the TISCI device ID of source
> > +			Second cell should contain the interrupt source offset
> > +			within the device
> > +			Third cell specifies the trigger type as defined
> > +			in interrupts.txt in this directory.
> > +			Fourth cell should be 1 if the irq is coming from
> > +			interrupt aggregator else 0.
> > +- ti,sci:		Phandle to TI-SCI compatible System controller node.
> > +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>
> Please help me here. As said this is the TISCI device id for the host
> interrupt controller. While sending message to the system co-processor
> this ID needs to be specified so that the irq route gets discovered and
> configured. Atleast with the current design device Ids are not
> discoverable. Can you mention what can be improved here? Is there any
> such example where a firmware supports querying the deivce ids?
> 
> Also do you have any further comments on this patch?

No reg property above. So if the interrupt router is not accessible
by Linux like you're saying, you should not set up a dts node for
it at all.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
