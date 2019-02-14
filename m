Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7ACC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:46:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0C5222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kDP0S9MC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0C5222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DAu/+EhL9Lh+qOEo78qQ5EivMPmjebD/Ifoe3Z4b9tA=; b=kDP0S9MCCsGfL1
	byFT6nwf2v3sSjZoiiHsBfIahPP8bMZ58w5ERQ7dIrdehPAJ5LNbYuFa0pzx9KNANeNfUYGZgQ++t
	doez3rc9QLhNJxmx4+fU/AwB0AUYSdUjwwxHTWRUrrBcTLFgM92zv+MWmKLLeYNiFacyFuM80BRvU
	lT6qavLi4UG47q0i5ZDsSuZ8eyr9JRxnCBg5GXmFH89NS06lqoWCUHJxgJMxJP2ymEZaXR1Op47lo
	CKf/jbYsuPqIrHf3lCDqX9TaFH0XeplHu2fTmIybp8/3TziaSWvmOJsUTZps96HudIEMR2v6xPbDe
	uiGjBZErwBfo8er5tdIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guL5Y-000456-7r; Thu, 14 Feb 2019 17:46:20 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guL5V-00044f-Dj
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:46:18 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 4E2E680EA;
 Thu, 14 Feb 2019 17:46:25 +0000 (UTC)
Date: Thu, 14 Feb 2019 09:46:12 -0800
From: Tony Lindgren <tony@atomide.com>
To: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190214174612.GF5720@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
 <20190213152620.GS5720@atomide.com>
 <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_094617_503579_AC07E75D 
X-CRM114-Status: GOOD (  16.60  )
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

* Lokesh Vutla <lokeshvutla@ti.com> [190214 17:32]:
> Hi Tony,
> 	Please do not snip the on going discussion.
> 
> On 2/14/2019 9:11 PM, Tony Lindgren wrote:
> > * Lokesh Vutla <lokeshvutla@ti.com> [190214 08:39]:
> >> IMHO, device ids are something which can be used in DT. There are many other
> >> things like the interrupt ranges etc.. which are discoverable from sysfw and we
> >> are implementing it.
> > 
> > We need to describe hardware in the device tree, not firmware.
> > 
> > If you have something discoverable from the firmware, you should
> > have the device driver query it from sysfw based on a hardware
> > property, not based on some invented enumeration in the firmware.
> 
> Yes we are already querying sysfw for all the irq ranges that can be
> discoverable. The topic of discussion here is about the parent interrupt
> controller id. I am not sure how you are expecting an id be discoverable
> from system firmware especially with a name.

Well names are quite standard in dts (but should be used with
the phandle + offset). Think for example interrupt-names and
reg-names :)

> > If there is some device to firmware translation needed, hide that
> > into the device driver and keep it out of the device tree.
> 
> If preferred this can be moved to of_match_data attached to each
> compatible property. Then for each SoC a new compatible needs to be created.

Hiding the ID into the device driver and compatible property
makes sense to me if the id is based on SoC + firmware.

But I'd rather have a proper hardware based phandle + index
type mapping in the dts if possible though.

What does this id really consist of?

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
