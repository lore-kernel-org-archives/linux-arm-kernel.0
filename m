Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36095C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:03:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0520720834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t9IFPNet";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+l5Frrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0520720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xKf66NRumU3VaFxfIgSa7C30ZWeCMIanrsC/uCc9/9k=; b=t9IFPNetApObRh
	SKl56is/cqSa0tcpLRnZIm9P+TgLq6ZEF5V3rCCDpgA6a0XD37PP5dSkGJfGAVxDr/Xw4GvP2zMWh
	54YDfwFNffNbxWANTytDgZ5bnMC+jmLzgiWIKOIMjJqHZMkqJ3WjSPGYcZxE69h/Hlg5tgTWROJxa
	HYY3vjqZpKnLHcekNAwHaXDrERL5LA1HL/g9F3PZh4EBYdIb5axS/+HmLkyf83HUr81eGOLQB+Nba
	HrMPiSIK4WA0fYClZZdr05NoWOySD9O8Mt+kQuUKghyiGfv2dGtWYXNL+7Jf9Mj20nNl9ssgBAB1B
	up/EwomIZdaTs0hmDGQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU3nM-0004zq-Ft; Tue, 04 Dec 2018 06:02:56 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU3nI-0004yo-6w
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 06:02:53 +0000
Received: by mail-ot1-x343.google.com with SMTP id n8so10240523otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 22:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qENavGeNdHRdZWiHMMywSIpwAWCHoygMUGrnlY6JJqQ=;
 b=T+l5Frrjeu4mMsyfTSSNKmNwHAUkYr42CVL1+6caCRPDlTA2Xpp72pE0DvzHrei4Zh
 fsLvujAQNBVTmIW9QeKQxyb8tvEcQQDEwKmpePQRgwlQb5d5RJQQ/ibBIGCF7MvbdLR9
 Xhg6gtRK0w281S7rdXIS2hvVnV0TYjRPknw7Gzco3KbqBfdjnBOTfjlEPweg1cerbX5E
 onv3/K/9ZgR+7HNHIjPs5HFjqNlbRYcytl3JeyJY/VWPdoHdQK+gPV+xqynM1y2jjwp4
 GmTrgeDZi8N0d0sJFGRn71A0QBginBC1Ivnv/QQDFmXG11snNRklAzZqMuxIdEOVGovu
 QR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qENavGeNdHRdZWiHMMywSIpwAWCHoygMUGrnlY6JJqQ=;
 b=KQ8ZcKV0WZaX5twlLWZ+ULlbnEGFBUtq7maRTEW0TMWd5g/AI8n/U7gy2R4gQlGw1F
 r5oSV+eU8b35adAeIQ5DfQaYgYAEnwkpKHVd+qDRTE+4oBzcjIQoYUkU55vT3QZoMeNv
 hgEeZtGahU5fANkSNealE56Mfd9Nd2jRUN3GfLKXnEaLpl6smwqKM10UW3sFKSy5/1RI
 hYmQtMAMJfrJ3jzDIxL7XxwoK5jo9Y9qM9c8JTTjn+OmnNZUWPXu4yqFM5GjjtJTCxPt
 ZZsta5vCGBr9uvTXvywg9PPXadyZeknAxD1pEL3Mq+vBwJgCgA/UYfX598QfnMJ5QCKy
 Kw2w==
X-Gm-Message-State: AA+aEWac2fM9+fE+OAwGJQHHfNgjx55dtlUe6z1OpT2BJcQiDcVYkgSt
 Rys26PtRwJ+gHFtBHLXJugpdXD5TO9wdvdgMaU4=
X-Google-Smtp-Source: AFSGD/U4ziTgMukjj2XYbngscdJjnJXJvrsmdaxAS9qGt/DpuSe+EjsUER4jQ8k29Dr4KxswXj9GjIIugmrpX3A4bSA=
X-Received: by 2002:a9d:8e4:: with SMTP id 91mr11553670otf.169.1543903360992; 
 Mon, 03 Dec 2018 22:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20181122030354.13570-1-ganapatrao.kulkarni@cavium.com>
 <20181122030354.13570-3-ganapatrao.kulkarni@cavium.com>
 <20181203121128.GC24824@arm.com>
In-Reply-To: <20181203121128.GC24824@arm.com>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Tue, 4 Dec 2018 11:32:29 +0530
Message-ID: <CAKTKpr7uSdrMrzVG5rHzmYSF6hKuP+R=ag9DqrbzSNNWQ_OyKA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE
 PMU driver
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_220252_257014_1CF7C2DA 
X-CRM114-Status: GOOD (  25.97  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, "Nair,
 Jayachandran" <Jayachandran.Nair@cavium.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 suzuki.poulose@arm.com, LKML <linux-kernel@vger.kernel.org>,
 Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com,
 Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>, Jan.Glauber@cavium.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 5:41 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Nov 22, 2018 at 03:04:35AM +0000, Kulkarni, Ganapatrao wrote:
> > This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
> > Controller(DMC) and Level 3 Cache(L3C). Each PMU supports up to 4
> > counters. All counters lack overflow interrupt and are
> > sampled periodically.
> >
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > ---
> >  drivers/perf/Kconfig         |   9 +
> >  drivers/perf/Makefile        |   1 +
> >  drivers/perf/thunderx2_pmu.c | 869 +++++++++++++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h   |   1 +
> >  4 files changed, 880 insertions(+)
> >  create mode 100644 drivers/perf/thunderx2_pmu.c
> >
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 08ebaf7cca8b..af9bc178495d 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -87,6 +87,15 @@ config QCOM_L3_PMU
> >          Adds the L3 cache PMU into the perf events subsystem for
> >          monitoring L3 cache events.
> >
> > +config THUNDERX2_PMU
> > +     tristate "Cavium ThunderX2 SoC PMU UNCORE"
> > +     depends on ARCH_THUNDER2 && ARM64 && ACPI && NUMA
> > +     default m
> > +     help
> > +        Provides support for ThunderX2 UNCORE events.
> > +        The SoC has PMU support in its L3 cache controller (L3C) and
> > +        in the DDR4 Memory Controller (DMC).
> > +
> >  config XGENE_PMU
> >          depends on ARCH_XGENE
> >          bool "APM X-Gene SoC PMU"
> > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > index b3902bd37d53..909f27fd9db3 100644
> > --- a/drivers/perf/Makefile
> > +++ b/drivers/perf/Makefile
> > @@ -7,5 +7,6 @@ obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
> >  obj-$(CONFIG_HISI_PMU) += hisilicon/
> >  obj-$(CONFIG_QCOM_L2_PMU)    += qcom_l2_pmu.o
> >  obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
> > +obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
> >  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
> >  obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
> > diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> > new file mode 100644
> > index 000000000000..e6509ba868ab
> > --- /dev/null
> > +++ b/drivers/perf/thunderx2_pmu.c
> > @@ -0,0 +1,869 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * CAVIUM THUNDERX2 SoC PMU UNCORE
> > + * Copyright (C) 2018 Cavium Inc.
> > + * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/cpuhotplug.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/platform_device.h>
> > +
> > +/* Each ThunderX2(TX2) Socket has a L3C and DMC UNCORE PMU device.
> > + * Each UNCORE PMU device consists of 4 independent programmable counters.
> > + * Counters are 32 bit and do not support overflow interrupt,
> > + * they need to be sampled before overflow(i.e, at every 2 seconds).
> > + */
> > +
> > +#define TX2_PMU_MAX_COUNTERS         4
> > +#define TX2_PMU_DMC_CHANNELS         8
> > +#define TX2_PMU_L3_TILES             16
> > +
> > +#define TX2_PMU_HRTIMER_INTERVAL     (2 * NSEC_PER_SEC)
> > +#define GET_EVENTID(ev)                      ((ev->hw.config) & 0x1ff)
>
> I think this should be 0x1f.

yes it should be, i will update it.
>
> > +#define GET_COUNTERID(ev)            ((ev->hw.idx) & 0x3)
> > + /* 1 byte per counter(4 counters).
> > +  * Event id is encoded in bits [5:1] of a byte,
> > +  */
> > +#define DMC_EVENT_CFG(idx, val)              ((val) << (((idx) * 8) + 1))
> > +
> > +#define L3C_COUNTER_CTL                      0xA8
> > +#define L3C_COUNTER_DATA             0xAC
> > +#define DMC_COUNTER_CTL                      0x234
> > +#define DMC_COUNTER_DATA             0x240
> > +
> > +/* L3C event IDs */
> > +#define L3_EVENT_READ_REQ            0xD
> > +#define L3_EVENT_WRITEBACK_REQ               0xE
> > +#define L3_EVENT_INV_N_WRITE_REQ     0xF
> > +#define L3_EVENT_INV_REQ             0x10
> > +#define L3_EVENT_EVICT_REQ           0x13
> > +#define L3_EVENT_INV_N_WRITE_HIT     0x14
> > +#define L3_EVENT_INV_HIT             0x15
> > +#define L3_EVENT_READ_HIT            0x17
> > +#define L3_EVENT_MAX                 0x18
> > +
> > +/* DMC event IDs */
> > +#define DMC_EVENT_COUNT_CYCLES               0x1
> > +#define DMC_EVENT_WRITE_TXNS         0xB
> > +#define DMC_EVENT_DATA_TRANSFERS     0xD
> > +#define DMC_EVENT_READ_TXNS          0xF
> > +#define DMC_EVENT_MAX                        0x10
> > +
> > +enum tx2_uncore_type {
> > +     PMU_TYPE_L3C,
> > +     PMU_TYPE_DMC,
> > +     PMU_TYPE_INVALID,
> > +};
> > +
> > +/*
> > + * pmu on each socket has 2 uncore devices(dmc and l3c),
> > + * each device has 4 counters.
> > + */
> > +struct tx2_uncore_pmu {
> > +     struct hlist_node hpnode;
> > +     struct list_head  entry;
> > +     struct pmu pmu;
> > +     char *name;
> > +     int node;
> > +     int cpu;
> > +     u32    max_counters;
> > +     u32    prorate_factor;
> > +     u32    max_events;
> > +     u64 hrtimer_interval;
> > +     void __iomem *base;
> > +     DECLARE_BITMAP(active_counters, TX2_PMU_MAX_COUNTERS);
> > +     struct perf_event *events[TX2_PMU_MAX_COUNTERS];
> > +     struct device *dev;
> > +     struct hrtimer hrtimer;
> > +     const struct attribute_group **attr_groups;
> > +     enum tx2_uncore_type type;
> > +     void    (*init_cntr_base)(struct perf_event *event,
> > +                     struct tx2_uncore_pmu *tx2_pmu);
> > +     void    (*stop_event)(struct perf_event *event);
> > +     void    (*start_event)(struct perf_event *event, int flags);
> > +};
> > +
> > +static LIST_HEAD(tx2_pmus);
> > +
> > +static inline struct tx2_uncore_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
> > +{
> > +     return container_of(pmu, struct tx2_uncore_pmu, pmu);
> > +}
> > +
> > +/*
> > + * sysfs format attributes
> > + */
> > +static ssize_t tx2_pmu_format_show(struct device *dev,
> > +                                  struct device_attribute *attr, char *buf)
> > +{
> > +     struct dev_ext_attribute *eattr;
> > +
> > +     eattr = container_of(attr, struct dev_ext_attribute, attr);
> > +     return sprintf(buf, "%s\n", (char *) eattr->var);
> > +}
> > +
> > +#define FORMAT_ATTR(_name, _config) \
> > +     (&((struct dev_ext_attribute[]) { \
> > +        { \
> > +        .attr = __ATTR(_name, 0444, tx2_pmu_format_show, NULL), \
> > +        .var = (void *) _config, \
> > +        } \
> > +     })[0].attr.attr)
> > +
> > +static struct attribute *l3c_pmu_format_attrs[] = {
> > +     FORMAT_ATTR(event,      "config:0-4"),
> > +     NULL,
> > +};
> > +
> > +static struct attribute *dmc_pmu_format_attrs[] = {
> > +     FORMAT_ATTR(event,      "config:0-4"),
> > +     NULL,
> > +};
>
> We have PMU_FORMAT_ATTR, PMU_EVENT_ATTR etc in the core code to help here.
> Please try to use them.

ok, i will try to use it.
>
> > +static const struct attribute_group l3c_pmu_format_attr_group = {
> > +     .name = "format",
> > +     .attrs = l3c_pmu_format_attrs,
> > +};
> > +
> > +static const struct attribute_group dmc_pmu_format_attr_group = {
> > +     .name = "format",
> > +     .attrs = dmc_pmu_format_attrs,
> > +};
> > +
> > +/*
> > + * sysfs event attributes
> > + */
> > +static ssize_t tx2_pmu_event_show(struct device *dev,
> > +                                 struct device_attribute *attr, char *buf)
> > +{
> > +     struct dev_ext_attribute *eattr;
> > +
> > +     eattr = container_of(attr, struct dev_ext_attribute, attr);
> > +     return sprintf(buf, "config=0x%lx\n", (unsigned long) eattr->var);
> > +}
>
> Shouldn't this be "event=" instead of "config="?

yep, thanks
>
> Will

Thanks,
Ganapat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
