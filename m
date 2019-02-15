Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FAFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:03:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E54F21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iHcMOYb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E54F21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8xmwHnWHdh9MFPkDuojANhrTkIqpyeCRCFc1VsF+NNM=; b=iHcMOYb1MUILCZ
	qkhaX/Ctz8ou1nLpheIfxqO3LDfGOmZGX8bSzZRxPT+1zT7noFhcrNir7cPfToIT41vnX7BamxO6V
	N10XpOc+9ySswBEDP3fd35fCQUX9V+HLtgE4Ov1WnjtUQq/4FaB1mfcJ/zElNLm4Wd5XttE5Jl3ln
	PhoxSq+gsBQjb5BueiYwzUc87qo+DuFyAoWMWXNC5i1sEEuYcG90Cno2DgSoSuAlo8zE1ViQiJmD2
	+UJhHlYkkiYs1YmO0xo4MqIa8aZKoG0r6Xax120hIhxzM1k6JOp5j2fbByKGg79kC8Rt5/Xxt/IBf
	WRqhtxfMGEi2RuFbr7MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugtM-0003yq-IN; Fri, 15 Feb 2019 17:03:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugst-0003Xa-I0
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:02:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEF4DEBD;
 Fri, 15 Feb 2019 09:02:42 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB3883F557;
 Fri, 15 Feb 2019 09:02:40 -0800 (PST)
Date: Fri, 15 Feb 2019 17:02:38 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Zhi Li <lznuaa@gmail.com>
Subject: Re: [PATCH V3 1/4] drivers/perf: imx_ddr: Add ddr performance
 counter support
Message-ID: <20190215170238.GB10859@lakrids.cambridge.arm.com>
References: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
 <20190215142241.GB55505@lakrids.cambridge.arm.com>
 <CAHrpEqT9sS2gmvB9iSH6V2-B3iza05qMGGLYRwR2sR3ZjO4wqA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHrpEqT9sS2gmvB9iSH6V2-B3iza05qMGGLYRwR2sR3ZjO4wqA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_090243_620329_B281BA97 
X-CRM114-Status: GOOD (  21.66  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 10:04:10AM -0600, Zhi Li wrote:
> On Fri, Feb 15, 2019 at 8:22 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Feb 13, 2019 at 06:12:27PM +0000, Frank Li wrote:
> > > +struct fsl_ddr_devtype_data {
> > > +     unsigned int flags;
> > > +};
> > > +
> > > +static const struct fsl_ddr_devtype_data imx8_data;
> > > +static const struct fsl_ddr_devtype_data imx8m_data = {
> > > +     .flags = DDR_CAP_AXI_ID,
> > > +};
> > > +
> > > +static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> > > +     { .compatible = "fsl,imx8-ddr-pmu", .data = (void *)&imx8_data},
> > > +     { .compatible = "fsl,imx8m-ddr-pmu", .data = (void *)&imx8m_data},
> > > +     { /* sentinel */ }
> > > +};
> >
> > You could encode the flags directly in of_device_id::data, and avoid the
> > need for this structure entirely.
> 
> I plan use fsl_ddr_devtype to save some friendly AXI ID name in future, such as
> GPU  0x111122222
> VPU  0x333344444
> 
> so user can use bus master name instead of to look ref manual to get hex number.
> 
> perf stat -e ddr0/axid_read, axid=GPU
> 
> But perf application can't pass string by config.
> 
> Any suggestion here ?

Remove it for now, and we can consider it if/when you add that
functionality.

However, I will say that in general I am not a fan of coding SoC-level
details into individual drivers, and I would prefer to avoid hard coding
the AXI IDs here regardless.

> > > +static u32 ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event)
> > > +{
> > > +     int i;
> > > +
> > > +     /* Always map cycle event to counter 0 */
> > > +     if (event == EVENT_CYCLES_ID)
> > > +             return EVENT_CYCLES_COUNTER;
> >
> > What if the cycle counter is already in use?
> 
> cycles counter is dedicated to cycles events.
> Can't use for other event.

What I meant was if you have two cycles events, they'll both try to
configure the cycle counter (e.g. when it overflows), which may not
behave as you expect.

I think that you should only allow one event to use the cycle counter at
a time.

> > > +static irqreturn_t ddr_perf_irq_handler(int irq, void *p)
> > > +{
> > > +     int i;
> > > +     u8 reg;
> > > +     int val;
> > > +     int counter;
> > > +     struct ddr_pmu *pmu = (struct ddr_pmu *) p;
> > > +     struct perf_event *event;
> > > +
> > > +     /* Only cycles counter overflowed can issue irq. all counters will
> > > +      * be stopped when cycles counter overflow. but other counter don't stop
> > > +      * when overflow happen. Update all of the local counter values,
> > > +      * then reset the cycles counter, so the others can continue
> > > +      * counting.
> > > +      */
> >
> > That is a rather unfortunate design decision.
> >
> > Can any of the counters count multiple events per cycle?
> 
> No,  other events always much less than cycle counters.

Ok. Please describe that in the comment.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
