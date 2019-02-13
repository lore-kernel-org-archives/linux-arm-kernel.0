Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA9BC0044B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:40:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF88222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VBzKCewq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF88222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J6iGuWPGPSklSf1Xmn9UEPyFpxdr6Bss34qutUshGlI=; b=VBzKCewqOVn+eA
	5/izMWFUrnRqFcrUow4Z/aXlK5n0MOMN9IOrkeDU39qI8h9ZLRWa9h8V2urxX96JStH1Oysg2KdiQ
	cso0pI/FkUJQ2PdlhCRuyorn79eNOW0XSSWx4UHlAa4vQo2p7s8/0/rbOh8Try2Vehv7XbJBH9mms
	jI2LCR+7Xs6iswqi1F5maFvRa/r3WO/k6T7i3A6LJeF1XuBlKfFeUo8+1h7qXGF1xTkYyw/5N6Dy4
	IppwQg5tjiJQ3NOf1F6Im7mhuTTIrYeX9Ohb8A3wYSuxFFn5Vt/D+9GW1CC+mY2UICivujSkFVjXK
	WPBlnyBV2AQCw9ni4YFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu1Kd-0006GR-5c; Wed, 13 Feb 2019 20:40:35 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu1KZ-0006Fv-9P
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 20:40:32 +0000
Received: by mail-ot1-f68.google.com with SMTP id z19so6707785otm.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 12:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TQCmFVh7Tf8A1zsUWhrcyFMJXEj/kwdqYS8gaLBDDSc=;
 b=Y0Z5xn0MtjCKWC3WEijfI6QqANCYMRls20hgwBJrQ8cE7xuJbGG829zUrHtHZr5DO0
 +NzyISiRJSCfmc1+XxgPxh2NFXZYTeVzSy6Ev0scxe8CUMUDY6sB8QY0QoOSeYwZBpvu
 9NNnVa0A5guINQ+5uGkkbsuBX6g0JOY9xYjy1x5w2bck/P0US1TAWFIq0VQTB3GsIOP7
 KNB3wCUmRzLsIvmXcLCFKgoyTIh+JcdwoeUlaRA+bVns03PudKiEiFosImsQFAwQwNlA
 kgBp2nPg1+WI2ML/u5175pv4uipMFnGW0u42KJuEI6H9oJ2b+ZjXjBHAme4Cz63ASFjA
 EI1g==
X-Gm-Message-State: AHQUAuZ/ZgLspJbvyHcBLTHNzaKoq5MwgvQBX5efR3pjhMopT/wBUo4x
 MAbIVcdAmcn17W0mMNkvog==
X-Google-Smtp-Source: AHgI3IZG0LHaxabLDRsEU9UeCQEGHEoY1poG7lMssDJzvqEgLQhT8FNOv5iqsXNv9RhUgSXx3KCPGg==
X-Received: by 2002:a05:6830:1292:: with SMTP id
 z18mr11015otp.161.1550090430244; 
 Wed, 13 Feb 2019 12:40:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x19sm125148otp.10.2019.02.13.12.40.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 12:40:29 -0800 (PST)
Date: Wed, 13 Feb 2019 14:40:23 -0600
From: Rob Herring <robh@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190213204023.GA21941@bogus>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
 <20190213152620.GS5720@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213152620.GS5720@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_124031_324342_B8429039 
X-CRM114-Status: GOOD (  21.93  )
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
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, marc.zyngier@arm.com,
 Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 07:26:20AM -0800, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [190213 04:26]:
> > Hi Tony,
> > 
> > On 12/02/19 9:52 PM, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
> > >> +Example:
> > >> +--------
> > >> +The following example demonstrates both interrupt router node and the consumer
> > >> +node(main gpio) on the AM654 SoC:
> > >> +
> > >> +main_intr: interrupt-controller0 {
> > >> +	compatible = "ti,sci-intr";
> > >> +	interrupt-controller;
> > >> +	interrupt-parent = <&gic500>;
> > >> +	#interrupt-cells = <4>;
> > >> +	ti,sci = <&dmsc>;
> > >> +	ti,sci-dst-id = <56>;
> > >> +	ti,sci-rm-range-girq = <0x1>;
> > >> +};
> > > 
> > > Can you describe a bit what the "ti,sci-dst-id" is above?
> > > 
> > > These IDs seem to be listed at at [0] below, but is it really a property
> > > of the hardware? Or is it some enumeration of SoC devices in the firmware?
> > 
> > This is the way that sysfw describes the hardware. In this case it is GIC and it
> > is identified by this ID.
> 
> If this ID is an enumeration in the sysfw rather than an actual
> hardware property it should not be in the device tree. If so,
> the device driver should request the id from the sysfw based
> on a name. That is, if no struct device or device phandle can
> be used.
> 
> The problem with using enumeration in the dts is that it
> requires maintaining the dts, driver(s) and possibly firmware
> in sync. And that might change between SoCs variants when new
> devices get added and removed.

IOW, don't repeat h/w designers mistakes and make your firmware 
discoverable. We have DT only for what is not discoverable.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
