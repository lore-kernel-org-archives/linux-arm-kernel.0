Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711F9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:04:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ADEC21927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VT8G6Q3m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQI3CXy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADEC21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A7PwRsfC64A2ya3RM4YnESxcswMqlnrSRUmztX+eKd4=; b=VT8G6Q3m/KoLdA
	CmxWx+esdwio2pueq7yAeH4HwfXjaYj2XLbYAADjINBrhMZkajCpHc6snVOaKu11jvyRNyAk1MB0n
	hIQBAj4CD9n4gtE6x2ELLARrTNSB4SHkVuuhX1YG9PyAlZ9hCuu2smNUEqUGCA4YVo1D4fM+Waxqj
	TbhnE5sbs+WTTOU37E3FgSs0UcOdB8Bw+31rk8zhn5sJTGA2dPSOV4MYoLFJ9x0BH2+u7hy1lgTMW
	KlvewkRfCj11VuyuQ7LfY89nX1VMEHJWE1F0DbFpt/1XQmrS5NwA1cnhdYcTmHPebhiVIabasYZZP
	1lhN1RfltpZnhE+v2xYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufyX-0005Vz-50; Fri, 15 Feb 2019 16:04:29 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufyQ-0005VT-IQ
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:04:27 +0000
Received: by mail-pf1-x444.google.com with SMTP id b7so5025993pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0CCarggZUP7+lgO8YvHDTnz8VFKr9fOYHIg4SR63BJc=;
 b=AQI3CXy62ZiVv7TL42oAs9N6E3g2uUEAh/K875ycgjlX/OBVxZr6yLcsXJbWaQQXyl
 pF7ATewcCHEkByUgKruRzXm8o9JesV+7v/ZnluhfcHkgZwJ/1rG1feJvqduceTZR0qkU
 b9kjU9UESBFhJLYokJspbByg10nAqpb42xQazlTWPN4STOzV6nI7QAi6W8IzdaGcdLTA
 JnWVt64aC1CDwjRIDgBBbJ3lCFILWks0szthMs/tpJBTeVHq2p73tCbv2nr4Yhp/lZjO
 9SwhHkjbCvNnE64c+IHnTE1sh5mVNRjJlNGZBah83RzNe49ooDV+CsCHRJuXah0N2WII
 dnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0CCarggZUP7+lgO8YvHDTnz8VFKr9fOYHIg4SR63BJc=;
 b=Lk41YUhiRvTBRlmQNI+Nf6Sy3Z05Fnpe/GkEHtjtsvRag+J9Nu0aZGhpvAp5nAPQkj
 /wYCui7RrIAFlppP74Z4mYH0YxQYSFFJAGjnDi0SZeDmtOpPhm7cCW+alwchVk5hFwtF
 16+2pEFjhSo1+RA3e6GQI0H2bXFP4K++mmqBjJ5f5i5VChE3Z2qXlDfH8E0Tq07WgwT3
 rCOkHxlf8b0UUNH3daolPDcNyf1RQPRhIhr8b6XDsaj+bTGxtrf7VnDs/pQiLtKXTGTF
 1gMMlrfAT8iYMnLRWD42o99iPNl08KWBaZzbmp0KGxISgTr/i0bSvJl43OwFT8mhPDu8
 v9cw==
X-Gm-Message-State: AHQUAuadc80aErjfruP/AV4aAdOl2gNzxnkJ5rFj+IqPlmRgNfTGPIBU
 PmO5/llalqcMPhLyLe12HbuaDMeep20NE55vLhU=
X-Google-Smtp-Source: AHgI3IYGGu3Y/3uvbPYxDPJk+eola2znog2Q68pAlDo1xnZNNH9L7GEsW2OqYhGwjcbN4UoeRFA5tGrdSWFsCZCetck=
X-Received: by 2002:a63:ef4c:: with SMTP id c12mr5763273pgk.84.1550246661518; 
 Fri, 15 Feb 2019 08:04:21 -0800 (PST)
MIME-Version: 1.0
References: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
 <20190215142241.GB55505@lakrids.cambridge.arm.com>
In-Reply-To: <20190215142241.GB55505@lakrids.cambridge.arm.com>
From: Zhi Li <lznuaa@gmail.com>
Date: Fri, 15 Feb 2019 10:04:10 -0600
Message-ID: <CAHrpEqT9sS2gmvB9iSH6V2-B3iza05qMGGLYRwR2sR3ZjO4wqA@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] drivers/perf: imx_ddr: Add ddr performance counter
 support
To: Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_080422_609259_CC5FE730 
X-CRM114-Status: GOOD (  31.22  )
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

On Fri, Feb 15, 2019 at 8:22 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Feb 13, 2019 at 06:12:27PM +0000, Frank Li wrote:
> > event 41: axid-read and event 42: axi-write support count only
> > for special axi id. config1 is axi master id.
>
> These should be commented in the code, and shouldn't be the start of the
> commit message.
>
> > please refer chip manual to get axi master id information.
>
> ... where can I find this manual?
>
> >
> > event 'cycles' must be enabled because hardware requirement.
>
> Can you please describe this requirement in more detail?
>
> Do the other counters only count when this event is enabled, for
> example?
>
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index af9bc17..6e279e6 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -61,6 +61,13 @@ config ARM_DSU_PMU
> >         system, control logic. The PMU allows counting various events related
> >         to DSU.
> >
> > +config FSL_IMX8_DDR_PERF
>
> Please s/PERF/PMU/ here, matching the other PMU drivers.
>
> > +     tristate "Freescale i.MX8 DDR perf monitor"
> > +     depends on ARCH_MXC
> > +       help
> > +       Provides support for ddr perfomance monitor in i.MX8. Provide memory
> > +       througput information.
> > +
> >  config HISI_PMU
> >         bool "HiSilicon SoC PMU"
> >         depends on ARM64 && ACPI
>
> [...]
>
> > diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> > new file mode 100644
> > index 0000000..a15bb46
> > --- /dev/null
> > +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> > @@ -0,0 +1,570 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2017 NXP
> > + * Copyright 2016 Freescale Semiconductor, Inc.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
>
> Nit: please sort these in alphabetical order.
>
> [...]
>
> > +struct fsl_ddr_devtype_data {
> > +     unsigned int flags;
> > +};
> > +
> > +static const struct fsl_ddr_devtype_data imx8_data;
> > +static const struct fsl_ddr_devtype_data imx8m_data = {
> > +     .flags = DDR_CAP_AXI_ID,
> > +};
> > +
> > +static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> > +     { .compatible = "fsl,imx8-ddr-pmu", .data = (void *)&imx8_data},
> > +     { .compatible = "fsl,imx8m-ddr-pmu", .data = (void *)&imx8m_data},
> > +     { /* sentinel */ }
> > +};
>
> You could encode the flags directly in of_device_id::data, and avoid the
> need for this structure entirely.

I plan use fsl_ddr_devtype to save some friendly AXI ID name in future, such as
GPU  0x111122222
VPU  0x333344444

so user can use bus master name instead of to look ref manual to get hex number.

perf stat -e ddr0/axid_read, axid=GPU

But perf application can't pass string by config.

Any suggestion here ?

best regards
Frank Li

>
> [...]
>
> > +static u32 ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event)
> > +{
> > +     int i;
> > +
> > +     /* Always map cycle event to counter 0 */
> > +     if (event == EVENT_CYCLES_ID)
> > +             return EVENT_CYCLES_COUNTER;
>
> What if the cycle counter is already in use?

cycles counter is dedicated to cycles events.
Can't use for other event.

>
> I suspect that won't work correctly.
>
> [...]
>
> > +static void ddr_perf_event_enable(struct ddr_pmu *pmu, int config,
> > +                               int counter, bool enable)
> > +{
> > +     u8 reg = counter * 4 + COUNTER_CNTL;
> > +     int val;
> > +
> > +     if (enable) {
> > +             /* Clear counter, then enable it. */
> > +             writel(0, pmu->base + reg);
>
> Why is it necesary to clear the control register here?
>
> > +             val = CNTL_EN | CNTL_CLEAR;
> > +             val |= (config << CNTL_CSV_SHIFT) & CNTL_CSV_MASK;
> > +     } else {
> > +             /* Disable counter */
> > +             val = readl(pmu->base + reg) & CNTL_EN_MASK;
> > +     }
> > +
> > +     writel(val, pmu->base + reg);
> > +
> > +     if (config == EVENT_CYCLES_ID)
> > +             pmu->cycles_active = enable;
> > +}
> > +
> > +static void ddr_perf_event_start(struct perf_event *event, int flags)
> > +{
> > +     struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     int counter = hwc->idx;
> > +
> > +     if (pmu->devtype->flags & DDR_CAP_AXI_ID) {
> > +             if (event->attr.config == 0x41 ||
> > +                 event->attr.config == 0x42) {
>
> Please add mnemonics for these values.
>
> e.g..
>
> #define EVENT_AXI_READ  0x41
> #define EVENT_AXI_WRITE 0x42
>
> ... so that this code is easier to read, e.g.
>
>         if (pmu->devtype->flags & DDR_CAP_AXI_ID) {
>                 if (event->attr.config == EVENT_AXI_READ ||
>                     event->attr.config == EVENT_AXI_WRITE) {
>                         ...
>                 }
>         }
>
> > +                     int val = event->attr.config1;
> > +
> > +                     writel(val, pmu->base + COUNTER_DPCR1);
> > +             }
> > +     }
> > +
> > +     local64_set(&hwc->prev_count, 0);
> > +
> > +     ddr_perf_event_enable(pmu, event->attr.config, counter, true);
> > +     /*
> > +      * If the cycles counter wasn't explicitly selected,
> > +      * we will enable it now.
> > +      */
> > +     if (counter > 0 && !pmu->cycles_active)
> > +             ddr_perf_event_enable(pmu, EVENT_CYCLES_ID,
> > +                                   EVENT_CYCLES_COUNTER, true);
>
> Please explain *why* you need to enable the cycle counter. It's fine to
> refer to another comment.
>
> > +}
>
> [...]
>
> > +static void ddr_perf_event_del(struct perf_event *event, int flags)
> > +{
> > +     struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     int counter = hwc->idx;
> > +
> > +     ddr_perf_event_stop(event, PERF_EF_UPDATE);
> > +
> > +     ddr_perf_free_counter(pmu, counter);
> > +     pmu->total_events--;
> > +     hwc->idx = -1;
> > +
> > +     /* If all events have stopped, stop the cycles counter as well */
> > +     if ((pmu->total_events == 0) && pmu->cycles_active)
> > +             ddr_perf_event_enable(pmu, EVENT_CYCLES_ID,
> > +                                   EVENT_CYCLES_COUNTER, false);
>
> Again, please explain *why*. It's fine to refer to another comment.
>
> [...]
>
> > +static irqreturn_t ddr_perf_irq_handler(int irq, void *p)
> > +{
> > +     int i;
> > +     u8 reg;
> > +     int val;
> > +     int counter;
> > +     struct ddr_pmu *pmu = (struct ddr_pmu *) p;
> > +     struct perf_event *event;
> > +
> > +     /* Only cycles counter overflowed can issue irq. all counters will
> > +      * be stopped when cycles counter overflow. but other counter don't stop
> > +      * when overflow happen. Update all of the local counter values,
> > +      * then reset the cycles counter, so the others can continue
> > +      * counting.
> > +      */
>
> That is a rather unfortunate design decision.
>
> Can any of the counters count multiple events per cycle?

No,  other events always much less than cycle counters.

>
> > +     for (i = 0; i < NUM_COUNTER; i++) {
> > +
> > +             if (!pmu->active_events[i])
> > +                     continue;
> > +
> > +             event = pmu->active_events[i];
> > +             counter = event->hw.idx;
> > +             reg = counter * 4 + COUNTER_CNTL;
> > +             val = readl(pmu->base + reg);
> > +
> > +             ddr_perf_event_update(event);
> > +
> > +             if (counter == EVENT_CYCLES_COUNTER) {
> > +                     ddr_perf_event_enable(pmu,
> > +                                           EVENT_CYCLES_ID,
> > +                                           EVENT_CYCLES_COUNTER,
> > +                                           true);
> > +                     ddr_perf_event_update(event);
> > +             }
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
>
> Thanks,
> Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
