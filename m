Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFD4C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:30:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFB720C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MYCjlSnt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TxoUSYdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFB720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U9Cr4Ur9rDTIiKsAklEsddciH3FeZVqQPACeDC5DBkA=; b=MYCjlSntsTNx7j
	sbtAVs6EURZesgd8AiBkG8YiaJWk+Zc7GlQlNVltEdNLKHmAqwMouyjFDeXKyZJWOfvwnxf40rUUI
	sq2M5dqN5qn1bNkeWG4hlxeH6exv+tvv1kE2/Ld8kW2VUEQDvSKSTTrglQ7WqZzXcLJxS6Mz+lYqB
	/9kHVyy+er9cm+pYX+Bdx7DShqOIV/SVU+gyi4vtIf/VisEns48MLAjr55KLvS/72L7/5KjnBHImK
	gjLtrw8ljWWoC+c8+HxrTIogMVVv0LbMwHpLOzkF/SA6/IC4mtB4b/9sOtn1/+xbKwVpI+cS06RnR
	gAb8lvR1xuU2w30acUkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guqgM-0000yE-T7; Sat, 16 Feb 2019 03:30:26 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guqgJ-0000xl-Uy
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 03:30:25 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1G3U3aZ066248;
 Fri, 15 Feb 2019 21:30:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550287803;
 bh=106JMjXimU+WPPBqfrwCpGITtJ6kNNDBeFVCsvLZiSA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=TxoUSYdRxyoQqJlkWurK/NV0joRVSvmNdNDO4AVyOvRW7o7buzbLjGkN0vPtNE5nL
 29MZv58ba5i8C2qCecNeoUNBsltaN3/REjk0t1YDtubWyJb+49Ir0VGLRBkeNqKCw9
 wMnoiyuWVqGR5g7XUNrGBSOz1dxFYUzEO2kZSnTo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1G3U29W105079
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 21:30:02 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 21:30:01 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 21:30:01 -0600
Received: from [172.22.218.182] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1G3Tupg002588;
 Fri, 15 Feb 2019 21:29:57 -0600
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
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
Date: Sat, 16 Feb 2019 08:59:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215161629.GK5720@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_193024_161985_9920D5C3 
X-CRM114-Status: GOOD (  18.18  )
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

On 2/15/2019 9:46 PM, Tony Lindgren wrote:
> Hi,
> 
> * Lokesh Vutla <lokeshvutla@ti.com> [190214 18:03]:
>> On 2/14/2019 11:16 PM, Tony Lindgren wrote:
>>> But I'd rather have a proper hardware based phandle + index
>>> type mapping in the dts if possible though.
>>
>> The idea about sysfw here is that Linux is not aware of anything about
>> this device(Interrupt Router). It cannot even access any of its
>> registers. As a user Linux should know who is the parent to which the
>> Interrut router output should be configured. Then query sysfw about the
>> range of gic irqs allocated to it. Now for configuration, Linux should
>> pass the the input to interrupt router, gic irq no, and gic id(by which
>> sysfw uniquely identifies GIC interrupt controller with the SoC).  Based
>> on these parameters Interrupt Router registers gets configured.
> 
> If the interrupt router hardawre is hidden away from Linux,
> just leave it out of the device tree completely and have the
> interrupt controller driver request the routing.

Yes while requesting you should at-least specify which is your
destination interrupt-controller Else how does the sysfw even know to
whom the requester wants the routing to happen to. You do know that we
are dealing with a heterogeneous system where there are more the one
destination interrupt controllers(GIC, R5 VIM  etc etc..). This is what
the DT property is specifying and we cannot query a device based on a name.

> 
> The dts node for the interrupt controller should describe a
> proper Linux device, that is with reg entries and so on.

You are asking to just keep the compatible property :)

I am no where denying that. But the cases where the firmware does the
configuration DT spec[1] clearly mentions about the interface.

Please take a look at arm-psci devicetree binding documentation where
the function ids are represented using which each psci function is invoked.

[1]
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf

Thanks and regards,
Lokesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
