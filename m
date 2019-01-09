Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4F6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:30:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C79206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ANi5zDwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C79206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WYSoPQahslyENwndKFi7NBHVeXDHbv56hYeSLEng6eM=; b=ANi5zDwhmU0rrX
	oI613h3LxUKx+6X16XRckTWzrXeL83jbG8ghbKPeD4j2OzNg8UuPDBmkOM1QuZaXp5YRhsZXl4NNM
	ewJyY4AhBDWZu9uEoc3KBciSnjqajHdxogEXnPnBMqBN3Yinalaa4VCTBsMNTTrNLuV+BUWQJZZ9i
	ilZ0PnIyI0j4yY0p2oIzZKjdhCfuJtpr8Szg/pFvwJ1vNHVSq1oUyucpWAgnS3511Cb+pHZ+tkQOd
	gQY98Q0qGpQU3QNEVeCe6fGIuLrxM2ujPIubVT1yMRkLAUeIB964sWwTIpUzJyLSeJFoL5dZmqRkK
	q6nJXFahmLrFiWGmSZRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghABS-0004WX-D8; Wed, 09 Jan 2019 09:29:58 +0000
Received: from [223.203.96.18] (helo=barracuda02.hxt-semitech.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghABN-0004Vw-W5
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 09:29:56 +0000
X-ASG-Debug-ID: 1547026188-107606139f16e190001-tbGyMd
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by
 barracuda02.hxt-semitech.com with ESMTP id BEmb9ExinCQaW2e6 (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
 Wed, 09 Jan 2019 17:29:49 +0800 (CST)
X-Barracuda-Envelope-From: yuanyuan.zhao@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 17:29:42 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Wed, 9 Jan 2019 17:29:42 +0800
From: "Zhao, Yuanyuan" <yuanyuan.zhao@hxt-semitech.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: RE: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
Thread-Topic: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
X-ASG-Orig-Subj: RE: [RESEND 1/1] gic: its: Make sure a LPI is discarded
 before free.
Thread-Index: AQHUp+8DksFLG785G0++VUmPBlsY5qWmkCdg
Date: Wed, 9 Jan 2019 09:29:41 +0000
Message-ID: <c81f42aa93904353bbeac590da7b0945@HXTBJIDCEMVIW02.hxtcorp.net>
References: <e37e3f5e0146be65c60092a457ca5c82e25581a0.1545292748.git.yuanyuan.zhao@hxt-semitech.com>
 <20190109074324.6445118d@why.wild-wind.fr.eu.org>
In-Reply-To: <20190109074324.6445118d@why.wild-wind.fr.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.65.11.40]
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1547026189
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2035
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.60
X-Barracuda-Spam-Status: No, SCORE=0.60 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=ISO2022JP_CHARSET,
 MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65376
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.60 MARKETING_SUBJECT      Subject contains popular marketing words
 -0.00 ISO2022JP_CHARSET      ISO-2022-JP message
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_012954_443629_A8D0F382 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
 "jason@lakedaemon.net" <jason@lakedaemon.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Zheng,
 Joey" <yu.zheng@hxt-semitech.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc:

Thank you for your reply. 

As you said, APIs such as free_irq will deactivate irq
before free it. But deactivation is not forced by every API,
for example irq_dispose_mapping.  So I think it's better to check 
that irq was deactivated as expected.

BRs,
Yuanyuan


> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: 2019年1月9日 15:43
> To: Zhao, Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
> Cc: tglx@linutronix.de; jason@lakedaemon.net; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Zheng, Joey
> <yu.zheng@hxt-semitech.com>; Wang, Dongsheng <dongsheng.wang@hxt-
> semitech.com>
> Subject: Re: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
> 
> On Wed, 9 Jan 2019 11:53:27 +0800
> Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com> wrote:
> 
> Hi Zhao,
> 
> > Its device will be removed after all events be freed.
> > Undisarded events can lead to unpredictable behaviar.
> >
> > Signed-off-by: Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c
> > b/drivers/irqchip/irq-gic-v3-its.c
> > index db20e99..4fee008 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -2572,6 +2572,10 @@ static void its_irq_domain_free(struct
> irq_domain *domain, unsigned int virq,
> >  								virq + i);
> >  		u32 event = its_get_event_id(data);
> >
> > +		/* Discard irq before free */
> > +		if (irqd_is_activated(d))
> > +			its_send_discard(its_dev, event);
> > +
> >  		/* Mark interrupt index as unused */
> >  		clear_bit(event, its_dev->event_map.lpi_map);
> >
> 
> But we already do send a discard on deactivate, which logically happens
> before we free the domain. So what are you fixing here?
> 
> Thanks,
> 
> 	M.
> --
> Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
