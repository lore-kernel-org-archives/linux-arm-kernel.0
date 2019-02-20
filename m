Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27461C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:18:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6C72083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="no/uiLrt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FCLmgLr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6C72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D0kuHVTv0YT9tdSS3BOkoX0y8a6mFKJri9zlIl8X4fs=; b=no/uiLrtEacDUO
	D0I5W6KziGV9Hj3kN76pf6obplCHBr9PvoZuiJSwm8OpkV7C9Qa6JF1W9uugmtZO3xKNPYhTw40mv
	FO8/7UBgf8zgZZWAZOSCohC2OtNWsTTfI8mR0rwjJ7xBevBO6ytvtp/VI1Juz7WRZ7RCts0GVMW0Y
	ON2Iz5B/j6EoBBu0X1/81rhhGL+BzrAHMMAtphS+WYDL8r6La5IrF+bTHpeXyLbEZSaxcIP+TEkO1
	x0hbauzUEvwtljbsrhj8oAROxHxOcbj7Ku79iXnAyq4BsZQ+rEBFp8zdqR0IRE4BHhDTyAnQY5Vii
	npL0O6wSvwPzSebd+bWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwVVc-0006zc-Fl; Wed, 20 Feb 2019 17:18:12 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwVVU-0006z3-F5
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 17:18:10 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KHHhto102413;
 Wed, 20 Feb 2019 11:17:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550683063;
 bh=rPoFQSzC+GGsfVyODESrqjeKkCqvKgkYGCLIAc8r0/o=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=FCLmgLr1ny2q2zpCxog2TyXwvlBJFnq9FDAQtHbe3vFB2ErUT1nwMkPqRIYzs8GKz
 JJnWqO+V9Ed3HzgQtWC2IVWvMRFvahZODKEeW/p1pCUF/mSpWREpLmtAp9wL0fJ7m8
 nLs7LupXLUqssk4emT+wPqLKXdmhRb6eeoxT1lCA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KHHhCF123643
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 11:17:43 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 11:17:43 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 11:17:43 -0600
Received: from [172.22.219.123] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KHHc1Q030260;
 Wed, 20 Feb 2019 11:17:39 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To: Tony Lindgren <tony@atomide.com>
References: <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
 <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
 <20190218143245.GC15711@atomide.com>
 <84b3ec21-9ce9-b9a8-80a9-75001db43a90@ti.com>
 <20190219153537.GJ15711@atomide.com> <20190220163651.GS15711@atomide.com>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <ffc39399-a6bc-aabf-b701-d419346f9a71@ti.com>
Date: Wed, 20 Feb 2019 22:47:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190220163651.GS15711@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_091804_605741_92D995AA 
X-CRM114-Status: GOOD (  19.31  )
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
 marc.zyngier@arm.com, Tero Kristo <t-kristo@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tony,

On 2/20/2019 10:06 PM, Tony Lindgren wrote:
> Hi,
> 
> Some more info on chained irq vs mux below that might
> help.
> 
> * Tony Lindgren <tony@atomide.com> [190219 15:36]:
>> * Lokesh Vutla <lokeshvutla@ti.com> [190219 08:51]:
>>> With this can you tell me how can we not have a device-tree and still support
>>> irq allocation?
>>
>> Using standard dts reg property to differentiate the interrupt
>> router instances. And if the interrupt router is a mux, you should
>> treat it as a mux rather than a chained interrupt controller.
>>
>> We do have drivers/mux nowadays, not sure if it helps in this case
>> as at least timer interrupts need to be configured very early.
> 
> Adding Linus Walleij to Cc since he posted a good test to
> consider if something should use chained (or nested) irq:
> 
> "individual masking and ACKing bits and can all be used at the
>  same time" [0]

Interrupt Router just routes M inputs to N outputs. One input can only
be mapped to one output. This is a clear case of a hierarchical domain
and the driver is implementing it.

Thanks and regards,
Lokesh

> 
> Not sure if we have that documented somewhere?
> 
> But seems like the interrupt router should be set up as
> a separate mux driver talking with firmware that the
> interrupt controller driver calls on request_irq(>
> Cheers,
> 
> Tony
> 
> 
> [0] https://marc.info/?l=linux-omap&m=155065629529311&w=2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
