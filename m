Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E741EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:37:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF3E21917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mha5W05a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IXS0fpTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF3E21917
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xr7Vm3VtiyT2M59Wjqof0/PwbN3ndcpyUvugnSns0e8=; b=Mha5W05ayOyoua
	0Se2RwiegPsc98P04YFm8kFq8smM9BW7fBAV+p4nuVGjqRdO1ywlmdQPFFBfvTNwnhHjSNXUveiQY
	xU8G3BqRHkAord7bKUKvJUy6PGFwVN2K1cRNSaAHvCPvWiUK5Ryg8mJy/GycQ+OVwOGCN+V11yPPv
	ZP7C+4wNeGkuqjRzytNc75PdYBRYpNoqNQ2DZldk96O0PHGabiBXraALsy0vb72wT34eMTuth1/YC
	krru8XZbzoybMTHx5CrbREr5p52CY5car3aocUZeHK7I4CQHsehIdFluXJ9WTHeFP5QzAxrRudsuk
	1kqwUhl6lTM5SECkmTOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guqnL-0003Lv-4Y; Sat, 16 Feb 2019 03:37:39 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guqnH-0003Lc-Ts
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 03:37:37 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1G3bJfc064879;
 Fri, 15 Feb 2019 21:37:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550288239;
 bh=ri6mOkmvnBM0Ul83HKA3eS1/DP2iHYkFNApn9s0T9eA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=IXS0fpTOUexnAoc/+0MY6HoQmiVD1W52ew5FuZKDRXn87u6GkPCPzCcYiafUTmtKz
 mvxA6yCGCuPkaFUXUCA7xovGGOAreB7evKAu9A5lT/sXAHsUqBQEPs5TNhjxVTkDAE
 HC/gku8BYSsLvkhQNFmWLDx+ia6jaJBuS5GXEbtc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1G3bJNR085478
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 21:37:19 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 21:37:19 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 21:37:19 -0600
Received: from [172.22.218.182] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1G3bDcn024612;
 Fri, 15 Feb 2019 21:37:14 -0600
Subject: Re: [PATCH v5 00/10] Add support for TISCI irqchip drivers
To: <marc.zyngier@arm.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon
 <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <a14f77bd-63cf-adb2-39c4-a8f45070ee9a@ti.com>
Date: Sat, 16 Feb 2019 09:07:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212074237.2875-1-lokeshvutla@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_193736_042123_9393637B 
X-CRM114-Status: GOOD (  18.34  )
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
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On 2/12/2019 1:12 PM, Lokesh Vutla wrote:
> TI AM65x SoC based on K3 architecture introduced support for Events
> which are message based interrupts with minimal latency. These events
> are not compatible with regular interrupts and are valid only through
> an event transport lane. An Interrupt Aggregator(INTA) is introduced
> to convert these events to interrupts. INTA can also group 64 events
> into a single interrupt. Now the SoC has many peripherals and a large
> number of event sources (time sync or DMA), the use of events is
> completely dependent on a user's specific application, which drives a
> need for maximum flexibility in which event sources are used in the
> system. It is also completely up to software control as to how the
> events are serviced.
> 
> Because of the huge flexibility there are certain standard peripherals
> (like GPIO etc)where all interrupts cannot be directly corrected to host
> interrupt controller. For this purpose, Interrupt Router(INTR) is
> introduced in the SoC. INTR just does a classic interrupt redirection.
> 
> So the SoC has 3 types of interrupt controllers:
> - GIC500
> - Interrupt Router
> - Interrupt Aggregator
> 
> Below is a diagrammatic view of how SoC integration of these interrupt
> controllers:(https://pastebin.ubuntu.com/p/9ngV3jdGj2/)
> 
> Device Index-x               Device Index-y
>            |                         |
>            |                         |
>                       ....
>             \                       /
>              \                     /
>               \  (global events)  /
>           +---------------------------+   +---------+
>           |                           |   |         |
>           |             INTA          |   |  GPIO   |
>           |                           |   |         |
>           +---------------------------+   +---------+
>                          |   (vint)            |
>                          |                     |
>                         \|/                    |
>           +---------------------------+        |
>           |                           |<-------+
>           |           INTR            |
>           |                           |
>           +---------------------------+
>                          |
>                          |
>                         \|/ (gic irq)
>           +---------------------------+
>           |                           |
>           |             GIC           |
>           |                           |
>           +---------------------------+
> 
> While at it, TISCI abstracts the handling of all above IRQ routes where
> interrupt sources are not directly connected to host interrupt controller.
> That would be configuration of Interrupt Aggregator and Interrupt Router.
> 
> This series adds support for:
> - TISCI commands needed for IRQ configuration
> - Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers

Sorry to bother you again. Any chance you can take a quick look at the
series?

Thanks and regards,
Lokesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
