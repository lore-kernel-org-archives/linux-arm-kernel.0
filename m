Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9823BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:22:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CEC2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H7pCaZNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CEC2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=41p3gLrTT+IYBfXrZ1FD3y0BstAz0JUu6C1D/dWj3fw=; b=H7pCaZNU2YMXi+
	9ZOowpO1wtmI7kpT5FuWhrVzQalzviUX/KgzbyyoRMbQ/4X1F1OJ6Mt5RzMgcgdbHvnXFbf9EHD9L
	Ydn5b9OUxSaaiLR7ETWFcRscx9i+nIF2gNSJSrbQzd7y3u32lYBTUjTh5bXiJ556eGTG8yG0AohIA
	zJSCN+12gY59ndFR22Si66qmoCV5W1WrPJoLesmoCim57Q82nJGVx4Fk4MJXSVtItD1jHoY5wrb2o
	Jiu23x1WCmXyEqdf3493TVnx9XtaVg/ANG1mCSLBSNo6ph6FzPksAQFmZes9SWogYMhAm3NMRXs+z
	j3Floqd/tK0fy/Xn5kaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueOB-000200-6Q; Fri, 15 Feb 2019 14:22:51 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueO7-0001zU-BF
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:22:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A22BA78;
 Fri, 15 Feb 2019 06:22:46 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 266043F575;
 Fri, 15 Feb 2019 06:22:44 -0800 (PST)
Date: Fri, 15 Feb 2019 14:22:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH V3 1/4] drivers/perf: imx_ddr: Add ddr performance
 counter support
Message-ID: <20190215142241.GB55505@lakrids.cambridge.arm.com>
References: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_062247_401101_6C9EBF9A 
X-CRM114-Status: GOOD (  26.52  )
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
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 06:12:27PM +0000, Frank Li wrote:
> event 41: axid-read and event 42: axi-write support count only
> for special axi id. config1 is axi master id.

These should be commented in the code, and shouldn't be the start of the
commit message.

> please refer chip manual to get axi master id information.

... where can I find this manual?

> 
> event 'cycles' must be enabled because hardware requirement.

Can you please describe this requirement in more detail?

Do the other counters only count when this event is enabled, for
example?

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index af9bc17..6e279e6 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -61,6 +61,13 @@ config ARM_DSU_PMU
>  	  system, control logic. The PMU allows counting various events related
>  	  to DSU.
>  
> +config FSL_IMX8_DDR_PERF

Please s/PERF/PMU/ here, matching the other PMU drivers.

> +	tristate "Freescale i.MX8 DDR perf monitor"
> +	depends on ARCH_MXC
> +	  help
> +	  Provides support for ddr perfomance monitor in i.MX8. Provide memory
> +	  througput information.
> +
>  config HISI_PMU
>         bool "HiSilicon SoC PMU"
>         depends on ARM64 && ACPI

[...]

> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> new file mode 100644
> index 0000000..a15bb46
> --- /dev/null
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -0,0 +1,570 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2017 NXP
> + * Copyright 2016 Freescale Semiconductor, Inc.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/perf_event.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>

Nit: please sort these in alphabetical order.

[...]

> +struct fsl_ddr_devtype_data {
> +	unsigned int flags;
> +};
> +
> +static const struct fsl_ddr_devtype_data imx8_data;
> +static const struct fsl_ddr_devtype_data imx8m_data = {
> +	.flags = DDR_CAP_AXI_ID,
> +};
> +
> +static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> +	{ .compatible = "fsl,imx8-ddr-pmu", .data = (void *)&imx8_data},
> +	{ .compatible = "fsl,imx8m-ddr-pmu", .data = (void *)&imx8m_data},
> +	{ /* sentinel */ }
> +};

You could encode the flags directly in of_device_id::data, and avoid the
need for this structure entirely.

[...]

> +static u32 ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event)
> +{
> +	int i;
> +
> +	/* Always map cycle event to counter 0 */
> +	if (event == EVENT_CYCLES_ID)
> +		return EVENT_CYCLES_COUNTER;

What if the cycle counter is already in use?

I suspect that won't work correctly.

[...]

> +static void ddr_perf_event_enable(struct ddr_pmu *pmu, int config,
> +				  int counter, bool enable)
> +{
> +	u8 reg = counter * 4 + COUNTER_CNTL;
> +	int val;
> +
> +	if (enable) {
> +		/* Clear counter, then enable it. */
> +		writel(0, pmu->base + reg);

Why is it necesary to clear the control register here?

> +		val = CNTL_EN | CNTL_CLEAR;
> +		val |= (config << CNTL_CSV_SHIFT) & CNTL_CSV_MASK;
> +	} else {
> +		/* Disable counter */
> +		val = readl(pmu->base + reg) & CNTL_EN_MASK;
> +	}
> +
> +	writel(val, pmu->base + reg);
> +
> +	if (config == EVENT_CYCLES_ID)
> +		pmu->cycles_active = enable;
> +}
> +
> +static void ddr_perf_event_start(struct perf_event *event, int flags)
> +{
> +	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int counter = hwc->idx;
> +
> +	if (pmu->devtype->flags & DDR_CAP_AXI_ID) {
> +		if (event->attr.config == 0x41 ||
> +		    event->attr.config == 0x42) {

Please add mnemonics for these values.

e.g..

#define EVENT_AXI_READ	0x41
#define EVENT_AXI_WRITE	0x42

... so that this code is easier to read, e.g.

	if (pmu->devtype->flags & DDR_CAP_AXI_ID) {
		if (event->attr.config == EVENT_AXI_READ ||
		    event->attr.config == EVENT_AXI_WRITE) {
			...
		}
	}

> +			int val = event->attr.config1;
> +
> +			writel(val, pmu->base + COUNTER_DPCR1);
> +		}
> +	}
> +
> +	local64_set(&hwc->prev_count, 0);
> +
> +	ddr_perf_event_enable(pmu, event->attr.config, counter, true);
> +	/*
> +	 * If the cycles counter wasn't explicitly selected,
> +	 * we will enable it now.
> +	 */
> +	if (counter > 0 && !pmu->cycles_active)
> +		ddr_perf_event_enable(pmu, EVENT_CYCLES_ID,
> +				      EVENT_CYCLES_COUNTER, true);

Please explain *why* you need to enable the cycle counter. It's fine to
refer to another comment.

> +}

[...]

> +static void ddr_perf_event_del(struct perf_event *event, int flags)
> +{
> +	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int counter = hwc->idx;
> +
> +	ddr_perf_event_stop(event, PERF_EF_UPDATE);
> +
> +	ddr_perf_free_counter(pmu, counter);
> +	pmu->total_events--;
> +	hwc->idx = -1;
> +
> +	/* If all events have stopped, stop the cycles counter as well */
> +	if ((pmu->total_events == 0) && pmu->cycles_active)
> +		ddr_perf_event_enable(pmu, EVENT_CYCLES_ID,
> +				      EVENT_CYCLES_COUNTER, false);

Again, please explain *why*. It's fine to refer to another comment.

[...]

> +static irqreturn_t ddr_perf_irq_handler(int irq, void *p)
> +{
> +	int i;
> +	u8 reg;
> +	int val;
> +	int counter;
> +	struct ddr_pmu *pmu = (struct ddr_pmu *) p;
> +	struct perf_event *event;
> +
> +	/* Only cycles counter overflowed can issue irq. all counters will
> +	 * be stopped when cycles counter overflow. but other counter don't stop
> +	 * when overflow happen. Update all of the local counter values,
> +	 * then reset the cycles counter, so the others can continue
> +	 * counting.
> +	 */

That is a rather unfortunate design decision.

Can any of the counters count multiple events per cycle?

> +	for (i = 0; i < NUM_COUNTER; i++) {
> +
> +		if (!pmu->active_events[i])
> +			continue;
> +
> +		event = pmu->active_events[i];
> +		counter = event->hw.idx;
> +		reg = counter * 4 + COUNTER_CNTL;
> +		val = readl(pmu->base + reg);
> +
> +		ddr_perf_event_update(event);
> +
> +		if (counter == EVENT_CYCLES_COUNTER) {
> +			ddr_perf_event_enable(pmu,
> +					      EVENT_CYCLES_ID,
> +					      EVENT_CYCLES_COUNTER,
> +					      true);
> +			ddr_perf_event_update(event);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
