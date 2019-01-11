Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:35:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6D52177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DTUOstbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6D52177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K+9916x+XjQHf4k2g7m7DCdQiDqLQ0uhiYHkTxkS24w=; b=DTUOstbt/Hq3xm
	UIu567iZiUdmimzq+WLKfamyrBo21NrMTNXmn2Qq0sDrP1myDkwEb4R9Gjh15/0FdrFmziOmT99+6
	02jfQ6PKneNskz8vakXOVJfj30L8ubfb5mxoCdIGgdGycFSPrbLV6UPBEFsuBVaN8OAle/ei0OW5H
	+OQ+WNOS626Z2THfLbdDvOPfbxxXfxm65xELSxCimgy4iGP9z4sB7u5gPE/mdzNJCC7Nm8yPWk5T5
	KoLVf/PelvOfVxiIiVojtIFh+65aSDcRJObMW5IqQj2MQukNbzjpim69O4icORz76OJhdMEzbhMez
	Fnt6NFyIkCaACXFh28tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghu9g-0002pw-2F; Fri, 11 Jan 2019 10:35:12 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghu9c-0001aB-4z
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:35:09 +0000
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 164435B35F258B12420C;
 Fri, 11 Jan 2019 10:34:58 +0000 (GMT)
Received: from FRAEML702-CAH.china.huawei.com (10.206.14.33) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 10:34:57 +0000
Received: from FRAEML521-MBS.china.huawei.com ([169.254.2.121]) by
 fraeml702-cah.china.huawei.com ([10.206.14.33]) with mapi id 14.03.0415.000;
 Fri, 11 Jan 2019 11:34:45 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, "marc.zyngier@arm.com"
 <marc.zyngier@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory allocation
 for ITS tables
Thread-Topic: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory
 allocation for ITS tables
Thread-Index: AQHUqZIBwIWl/QL5rUuwxGPeyFHYR6Wp3fuA
Date: Fri, 11 Jan 2019 10:34:44 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8388B37D4@FRAEML521-MBS.china.huawei.com>
References: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com>
 <9046beb6-36e7-8890-5d09-fc03b6d2728c@arm.com>
In-Reply-To: <9046beb6-36e7-8890-5d09-fc03b6d2728c@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_023508_369127_43117920 
X-CRM114-Status: GOOD (  14.34  )
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
Cc: John Garry <john.garry@huawei.com>, Linuxarm <linuxarm@huawei.com>,
 "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>,
 "shankerd@codeaurora.org" <shankerd@codeaurora.org>, "Guohanjun \(Hanjun
 Guo\)" <guohanjun@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Suzuki,

> -----Original Message-----
> From: Suzuki K Poulose [mailto:suzuki.poulose@arm.com]
> Sent: 11 January 2019 09:42
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> marc.zyngier@arm.com; linux-kernel@vger.kernel.org
> Cc: shankerd@codeaurora.org; ganapatrao.kulkarni@cavium.com;
> Robert.Richter@cavium.com; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; John Garry <john.garry@huawei.com>;
> linux-arm-kernel@lists.infradead.org; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory allocation
> for ITS tables
> 

[...]

> >   drivers/irqchip/irq-gic-v3-its.c | 20 ++++++++++++--------
> >   1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index db20e99..ab01061 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -1749,7 +1749,8 @@ static int its_setup_baser(struct its_node *its,
> struct its_baser *baser,
> >   		order = get_order(GITS_BASER_PAGES_MAX * psz);
> >   	}
> >
> > -	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > +	base = (void *)page_address(alloc_pages_node(its->numa_node,
> > +				    GFP_KERNEL | __GFP_ZERO, order));
> 
> If alloc_pages_node() fails, the page_address() could crash the system.
> 
> > -	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> > -						get_order(ITS_CMD_QUEUE_SZ));
> > +	its->cmd_base = (void
> *)page_address(alloc_pages_node(its->numa_node,
> > +					     GFP_KERNEL | __GFP_ZERO,
> > +					     get_order(ITS_CMD_QUEUE_SZ)));
> 
> Similarly here. We may want to handle it properly.

Ah..good catch. I will change it and rebase on top of 5.0-rc1 as suggested by Marc.

Thanks,
Shameer
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
