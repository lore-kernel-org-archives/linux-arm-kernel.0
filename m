Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D21C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:34:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900EB20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D/bYdhpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900EB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zq11aOz8X+uvXBY2uAwa57EhYfjwFFZXzCMwnCYYE+w=; b=D/bYdhpoSSFVsl
	UdWoJ4RSwWEbyMSys1hOIUJR7PTeefE2XcZBVKX8WmwmiySGsu/pwUFOTzxc7R8M9B6POidEROp6q
	hlK0CIF/ATNaSUudd2XbIZlW9E6yVslkSv6wuKicxtyr//hgFeX/mtEY3iQLsdcupd7bG7RLfHWNA
	izlevCt4T/Y/P6QD4oHqgyixhkNuKXJYoU0xT5E/XlghkS/S3/hYVDcxj1Fg6XP/WOhSq3NWNElUh
	duVnpeKwrMpJhNQKOIBsJobtxLjGvt9Hj8/EKUj/BHaAQM7g37Qg6Q8I9Lxb5Zw+MGVybKrsHCbAx
	WzDe86TqzzOXr+yAyVgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0hk-0001D9-QE; Fri, 11 Jan 2019 17:34:48 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0hg-0001Ci-Jj
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:34:46 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0BHQDoW010536; Fri, 11 Jan 2019 18:34:34 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2ptybng97d-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 11 Jan 2019 18:34:34 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E119231;
 Fri, 11 Jan 2019 17:34:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9250655A4;
 Fri, 11 Jan 2019 17:34:32 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 11 Jan
 2019 18:34:32 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Fri, 11 Jan 2019 18:34:32 +0100
From: Loic PALLARDY <loic.pallardy@st.com>
To: Marc Zyngier <marc.zyngier@arm.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Alexandre TORGUE
 <alexandre.torgue@st.com>
Subject: RE: [PATCH 1/1] irqchip: stm32-exti: add domain translate function
Thread-Topic: [PATCH 1/1] irqchip: stm32-exti: add domain translate function
Thread-Index: AQHUqbXR7xrMy0xrkECi13pJpL3NPqWqJw+AgAAkTxA=
Date: Fri, 11 Jan 2019 17:34:32 +0000
Message-ID: <fb407c82a8fc44cdb0fd4c8954c4c12d@SFHDAG7NODE2.st.com>
References: <1547215132-85612-1-git-send-email-loic.pallardy@st.com>
 <7e36a9f2-2b43-5af3-2094-198a61030687@arm.com>
In-Reply-To: <7e36a9f2-2b43-5af3-2094-198a61030687@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-11_09:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_093444_948322_89D38D23 
X-CRM114-Status: GOOD (  18.49  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,
Thanks for the review

> -----Original Message-----
> From: Marc Zyngier <marc.zyngier@arm.com>
> Sent: vendredi 11 janvier 2019 16:52
> To: Loic PALLARDY <loic.pallardy@st.com>; tglx@linutronix.de;
> jason@lakedaemon.net; mcoquelin.stm32@gmail.com; Alexandre TORGUE
> <alexandre.torgue@st.com>
> Cc: linux-kernel@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/1] irqchip: stm32-exti: add domain translate function
> 
> On 11/01/2019 13:58, Loic Pallardy wrote:
> > Domain translate function is needed to recover irq
> > configuration parameters from DT node
> >
> > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> 
> Surely this fixes something, right? Can you please add a Fixes: tag?
Yes I will add tag of patch introducing hierarchical domain

> 
> > ---
> >  drivers/irqchip/irq-stm32-exti.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-
> exti.c
> > index 6edfd4bfa169..717879028cc4 100644
> > --- a/drivers/irqchip/irq-stm32-exti.c
> > +++ b/drivers/irqchip/irq-stm32-exti.c
> > @@ -819,9 +819,27 @@ static int __init stm32_exti_init(const struct
> stm32_exti_drv_data *drv_data,
> >  	return ret;
> >  }
> >
> > +static int stm32_exti_h_translate(struct irq_domain *d,
> > +				  struct irq_fwspec *fwspec,
> > +				  unsigned long *out_hwirq,
> > +				  unsigned int *out_type)
> > +{
> > +	if (is_of_node(fwspec->fwnode)) {
> 
> Is there any case where this wouldn't be true? i.e. an stm32 ACPI system?

You're right, no ACPI so check useless

> 
> > +		if (fwspec->param_count != 2)
> > +			return -EINVAL;
> > +
> > +		*out_hwirq = fwspec->param[0];
> > +		*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> 
> Because otherwise, this is exactly what irq_domain_xlate_twocell() does.

Thanks for pointing me this helper. Indeed no need to duplicate code
I'll send a v2 

Regards,
Loic
> 
> > +
> >  static const struct irq_domain_ops stm32_exti_h_domain_ops = {
> >  	.alloc	= stm32_exti_h_domain_alloc,
> >  	.free	= irq_domain_free_irqs_common,
> > +	.translate = stm32_exti_h_translate,
> >  };
> >
> >  static int
> >
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
