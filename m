Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CDCC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:26:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5227C222CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GZa1WBww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5227C222CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6PTkoCOSypm4Y3W2lJkKLZiAgtQcH9Q+yzLzmKo23Xs=; b=GZa1WBwwsjbQ67
	nFeDuTLEY9Dkku7YNN/oF4hq3j3onVYmyZvushIs8j0SegiL1ZLc5cEzzdj8zI5o5s0X0BN4/Z5mS
	KR769SwNY1Rix1Hy63+HPb0LifCjVreTq7SQRXj7+9hF6ErJG4cN0ZkTOyaFMGwyKDN3CXGUyAi8p
	VXSgcbTlkdGXvSOa5PeNCkH63W93S4ED4ww0j26O+Bwl9B1ktbaqHHRaO0PtL2RqSwylIg2Hvf+UG
	C7mP8ExXszuGk4eBCKKig6rP7JzUeI+8UBNoiYCgMcDrWiD2AvDWFvwGrufsVXUWNgzQ7gDZoll7h
	jGUPOMmI8OCn7P8HkHxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwQe-0007mF-Ju; Wed, 13 Feb 2019 15:26:28 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwQb-0007lU-Js
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:26:27 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 4A62480AE;
 Wed, 13 Feb 2019 15:26:33 +0000 (UTC)
Date: Wed, 13 Feb 2019 07:26:20 -0800
From: Tony Lindgren <tony@atomide.com>
To: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190213152620.GS5720@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_072625_686445_F4E2A7E2 
X-CRM114-Status: GOOD (  16.66  )
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

* Lokesh Vutla <lokeshvutla@ti.com> [190213 04:26]:
> Hi Tony,
> 
> On 12/02/19 9:52 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
> >> +Example:
> >> +--------
> >> +The following example demonstrates both interrupt router node and the consumer
> >> +node(main gpio) on the AM654 SoC:
> >> +
> >> +main_intr: interrupt-controller0 {
> >> +	compatible = "ti,sci-intr";
> >> +	interrupt-controller;
> >> +	interrupt-parent = <&gic500>;
> >> +	#interrupt-cells = <4>;
> >> +	ti,sci = <&dmsc>;
> >> +	ti,sci-dst-id = <56>;
> >> +	ti,sci-rm-range-girq = <0x1>;
> >> +};
> > 
> > Can you describe a bit what the "ti,sci-dst-id" is above?
> > 
> > These IDs seem to be listed at at [0] below, but is it really a property
> > of the hardware? Or is it some enumeration of SoC devices in the firmware?
> 
> This is the way that sysfw describes the hardware. In this case it is GIC and it
> is identified by this ID.

If this ID is an enumeration in the sysfw rather than an actual
hardware property it should not be in the device tree. If so,
the device driver should request the id from the sysfw based
on a name. That is, if no struct device or device phandle can
be used.

The problem with using enumeration in the dts is that it
requires maintaining the dts, driver(s) and possibly firmware
in sync. And that might change between SoCs variants when new
devices get added and removed.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
