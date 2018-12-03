Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D69C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:11:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8E820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mLSuCHcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8E820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y3L31wSfF1++57DACgikJeSim09LkKzy85Yt4qD32es=; b=mLSuCHcUbWJW2u
	cNm+Ne13fL9zl17XmF4WtkIXV2B5X1mTH4FdySuB9FhxREfvevQ4rIGVjHI4PmWSPEl+VSKALLNoh
	ZefWvmIMPiesWTKNagxrdmgv+JsH7DC4jDIk03TK5CHmPJmAj9Nd+olg1DXuBdhQFX3bY5xMWzCtV
	aKbcUP0CyjxVznFhH7l+rP4nFI9aJjRcZY/K5s/vQK6iYH9AKf4NvoEHK7qh28LZn9vMsMf0Pi80Y
	oBaZJe15yvG/XgztaaoGT5OuuVQklfGi1raI4EEtN8TCpKgDU/pPyG8GE8QVYqxcCjbtCaagr+pTS
	eUc7kyegVwmeMzaCzduw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTn4N-0004DZ-Ar; Mon, 03 Dec 2018 12:11:23 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTn4J-00041i-PA
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:11:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078F1165C;
 Mon,  3 Dec 2018 04:11:09 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB1A33F614;
 Mon,  3 Dec 2018 04:11:08 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id B9D391AE1062; Mon,  3 Dec 2018 12:11:28 +0000 (GMT)
Date: Mon, 3 Dec 2018 12:11:28 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
Subject: Re: [PATCH v8 2/2] ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE
 PMU driver
Message-ID: <20181203121128.GC24824@arm.com>
References: <20181122030354.13570-1-ganapatrao.kulkarni@cavium.com>
 <20181122030354.13570-3-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181122030354.13570-3-ganapatrao.kulkarni@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_041119_839069_57CEFE52 
X-CRM114-Status: GOOD (  24.33  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "Nair,
 Jayachandran" <Jayachandran.Nair@cavium.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "gklkml16@gmail.com" <gklkml16@gmail.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Richter,
 Robert" <Robert.Richter@cavium.com>, "Lomovtsev,
 Vadim" <Vadim.Lomovtsev@cavium.com>, Jan Glauber <Jan.Glauber@cavium.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 22, 2018 at 03:04:35AM +0000, Kulkarni, Ganapatrao wrote:
> This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
> Controller(DMC) and Level 3 Cache(L3C). Each PMU supports up to 4
> counters. All counters lack overflow interrupt and are
> sampled periodically.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  drivers/perf/Kconfig         |   9 +
>  drivers/perf/Makefile        |   1 +
>  drivers/perf/thunderx2_pmu.c | 869 +++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h   |   1 +
>  4 files changed, 880 insertions(+)
>  create mode 100644 drivers/perf/thunderx2_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 08ebaf7cca8b..af9bc178495d 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -87,6 +87,15 @@ config QCOM_L3_PMU
>  	   Adds the L3 cache PMU into the perf events subsystem for
>  	   monitoring L3 cache events.
>  
> +config THUNDERX2_PMU
> +	tristate "Cavium ThunderX2 SoC PMU UNCORE"
> +	depends on ARCH_THUNDER2 && ARM64 && ACPI && NUMA
> +	default m
> +	help
> +	   Provides support for ThunderX2 UNCORE events.
> +	   The SoC has PMU support in its L3 cache controller (L3C) and
> +	   in the DDR4 Memory Controller (DMC).
> +
>  config XGENE_PMU
>          depends on ARCH_XGENE
>          bool "APM X-Gene SoC PMU"
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index b3902bd37d53..909f27fd9db3 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -7,5 +7,6 @@ obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
>  obj-$(CONFIG_HISI_PMU) += hisilicon/
>  obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
>  obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
> +obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> new file mode 100644
> index 000000000000..e6509ba868ab
> --- /dev/null
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -0,0 +1,869 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CAVIUM THUNDERX2 SoC PMU UNCORE
> + * Copyright (C) 2018 Cavium Inc.
> + * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +/* Each ThunderX2(TX2) Socket has a L3C and DMC UNCORE PMU device.
> + * Each UNCORE PMU device consists of 4 independent programmable counters.
> + * Counters are 32 bit and do not support overflow interrupt,
> + * they need to be sampled before overflow(i.e, at every 2 seconds).
> + */
> +
> +#define TX2_PMU_MAX_COUNTERS		4
> +#define TX2_PMU_DMC_CHANNELS		8
> +#define TX2_PMU_L3_TILES		16
> +
> +#define TX2_PMU_HRTIMER_INTERVAL	(2 * NSEC_PER_SEC)
> +#define GET_EVENTID(ev)			((ev->hw.config) & 0x1ff)

I think this should be 0x1f.

> +#define GET_COUNTERID(ev)		((ev->hw.idx) & 0x3)
> + /* 1 byte per counter(4 counters).
> +  * Event id is encoded in bits [5:1] of a byte,
> +  */
> +#define DMC_EVENT_CFG(idx, val)		((val) << (((idx) * 8) + 1))
> +
> +#define L3C_COUNTER_CTL			0xA8
> +#define L3C_COUNTER_DATA		0xAC
> +#define DMC_COUNTER_CTL			0x234
> +#define DMC_COUNTER_DATA		0x240
> +
> +/* L3C event IDs */
> +#define L3_EVENT_READ_REQ		0xD
> +#define L3_EVENT_WRITEBACK_REQ		0xE
> +#define L3_EVENT_INV_N_WRITE_REQ	0xF
> +#define L3_EVENT_INV_REQ		0x10
> +#define L3_EVENT_EVICT_REQ		0x13
> +#define L3_EVENT_INV_N_WRITE_HIT	0x14
> +#define L3_EVENT_INV_HIT		0x15
> +#define L3_EVENT_READ_HIT		0x17
> +#define L3_EVENT_MAX			0x18
> +
> +/* DMC event IDs */
> +#define DMC_EVENT_COUNT_CYCLES		0x1
> +#define DMC_EVENT_WRITE_TXNS		0xB
> +#define DMC_EVENT_DATA_TRANSFERS	0xD
> +#define DMC_EVENT_READ_TXNS		0xF
> +#define DMC_EVENT_MAX			0x10
> +
> +enum tx2_uncore_type {
> +	PMU_TYPE_L3C,
> +	PMU_TYPE_DMC,
> +	PMU_TYPE_INVALID,
> +};
> +
> +/*
> + * pmu on each socket has 2 uncore devices(dmc and l3c),
> + * each device has 4 counters.
> + */
> +struct tx2_uncore_pmu {
> +	struct hlist_node hpnode;
> +	struct list_head  entry;
> +	struct pmu pmu;
> +	char *name;
> +	int node;
> +	int cpu;
> +	u32    max_counters;
> +	u32    prorate_factor;
> +	u32    max_events;
> +	u64 hrtimer_interval;
> +	void __iomem *base;
> +	DECLARE_BITMAP(active_counters, TX2_PMU_MAX_COUNTERS);
> +	struct perf_event *events[TX2_PMU_MAX_COUNTERS];
> +	struct device *dev;
> +	struct hrtimer hrtimer;
> +	const struct attribute_group **attr_groups;
> +	enum tx2_uncore_type type;
> +	void	(*init_cntr_base)(struct perf_event *event,
> +			struct tx2_uncore_pmu *tx2_pmu);
> +	void	(*stop_event)(struct perf_event *event);
> +	void	(*start_event)(struct perf_event *event, int flags);
> +};
> +
> +static LIST_HEAD(tx2_pmus);
> +
> +static inline struct tx2_uncore_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
> +{
> +	return container_of(pmu, struct tx2_uncore_pmu, pmu);
> +}
> +
> +/*
> + * sysfs format attributes
> + */
> +static ssize_t tx2_pmu_format_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +	return sprintf(buf, "%s\n", (char *) eattr->var);
> +}
> +
> +#define FORMAT_ATTR(_name, _config) \
> +	(&((struct dev_ext_attribute[]) { \
> +	   { \
> +	   .attr = __ATTR(_name, 0444, tx2_pmu_format_show, NULL), \
> +	   .var = (void *) _config, \
> +	   } \
> +	})[0].attr.attr)
> +
> +static struct attribute *l3c_pmu_format_attrs[] = {
> +	FORMAT_ATTR(event,	"config:0-4"),
> +	NULL,
> +};
> +
> +static struct attribute *dmc_pmu_format_attrs[] = {
> +	FORMAT_ATTR(event,	"config:0-4"),
> +	NULL,
> +};

We have PMU_FORMAT_ATTR, PMU_EVENT_ATTR etc in the core code to help here.
Please try to use them.

> +static const struct attribute_group l3c_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = l3c_pmu_format_attrs,
> +};
> +
> +static const struct attribute_group dmc_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = dmc_pmu_format_attrs,
> +};
> +
> +/*
> + * sysfs event attributes
> + */
> +static ssize_t tx2_pmu_event_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +	return sprintf(buf, "config=0x%lx\n", (unsigned long) eattr->var);
> +}

Shouldn't this be "event=" instead of "config="?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
