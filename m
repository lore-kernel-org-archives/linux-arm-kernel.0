Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:32:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD1621928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZVGiYnE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C3JmNXsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD1621928
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EULNqJt0vHmeOF4hPShVrY6yJ6zcYqu5dCcq6UnPELY=; b=aZVGiYnE0YEhqX
	49wqbH+RKi3b1R7dXbvKAzxUMPiGUfmNUHaEdmJI2ZW5ociqX2UJVNWQN5If5eLT+9fI0ZAfRv8nD
	XBKCzoYX2ElF3Wpi/BHa27HXRyRrhXuABDJ0JT98gU55MT0IeuLDMWWOsCWEKi3Wo05fCz0InIwTX
	HMAlQG+DHyq4SLm4oEkK4c7U6iSDtHXsTocHEmXoaWSObuBQtoPZti2tZ4R2rF9Jz5e+lg9fDjP+Y
	khSMh3bn2Jp874YIFE0wJtK4zwxXUXqrovBdFFcY4MRNzzWX8nAC3caCjnKqjFG1aI7jf5RviYrls
	qlUeyaez08f+CHcPM2+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKsK-0005mA-3C; Thu, 14 Feb 2019 17:32:40 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKsG-0005lo-Ek
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:32:38 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1EHWKZC045763;
 Thu, 14 Feb 2019 11:32:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550165540;
 bh=QdYwA0DkWwGJ/yuFA99S7Mo6Up/bd1aSPwcCrAJHVAA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=C3JmNXsMbZGjE0BisK3VrxXSDz5S9ppOMvKaWQ3rNQUX4KoeyOG9ICypoIrso7wTL
 Ovo5j/EZ2VDy/vDb6y1TPMf1okf+uCrBl7ll9oU7vvOich8UbcOWAN7G2e5MVKt2rx
 tI6LmQKxGYtWUh4gm5xNs9nYiGMnh1WdSbyH6wqw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1EHWK7v059356
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Feb 2019 11:32:20 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 11:32:19 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 11:32:19 -0600
Received: from [172.22.218.10] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1EHWF0k003978;
 Thu, 14 Feb 2019 11:32:16 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To: Tony Lindgren <tony@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
 <20190213152620.GS5720@atomide.com>
 <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
Date: Thu, 14 Feb 2019 23:02:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214154100.GB5720@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_093236_575649_CED70B44 
X-CRM114-Status: GOOD (  18.40  )
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

Hi Tony,
	Please do not snip the on going discussion.

On 2/14/2019 9:11 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [190214 08:39]:
>> IMHO, device ids are something which can be used in DT. There are many other
>> things like the interrupt ranges etc.. which are discoverable from sysfw and we
>> are implementing it.
> 
> We need to describe hardware in the device tree, not firmware.
> 
> If you have something discoverable from the firmware, you should
> have the device driver query it from sysfw based on a hardware
> property, not based on some invented enumeration in the firmware.

Yes we are already querying sysfw for all the irq ranges that can be
discoverable. The topic of discussion here is about the parent interrupt
controller id. I am not sure how you are expecting an id be discoverable
from system firmware especially with a name.

> If there is some device to firmware translation needed, hide that
> into the device driver and keep it out of the device tree.

If preferred this can be moved to of_match_data attached to each
compatible property. Then for each SoC a new compatible needs to be created.

> 
> For example, look at the interrupt binding where the interrupt
> is phandle to the controller and the bit offset from the interrupt
> controller instance.
> 
> You need to use device IO address + bit offset (or register
> offset) type indexing for device tree here. Something out of
> the TRM that makes sense to developers.
> 


[1]
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf

Thanks and regards,
Lokesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
