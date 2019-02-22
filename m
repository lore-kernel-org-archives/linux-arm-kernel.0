Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1904C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:46:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC12B2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E4dKSfAx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl+kftGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC12B2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ih4vTZLKCc7fKYCeuAzj2Z4EjpGMY3c36Qt+fZm4g8I=; b=E4dKSfAx6FVoCi
	Um7cP8zHiHG7e4StMkRoKsLWrE5Zr8h3bU4XNqfHiKds2/GxNXwPJmU8pmMOwxlnubEB0MprjmLk3
	DnxfR+itVIOiAkitICiH4UC+8bsOOx2YNkKT9rjlRdub1qpaoY5NaP5Gcdzwi9gMAVCF9P5gDTzPR
	Qi3Mvs1y8lg7e7CkLG3pcz780myY7AecGXIBYNZFpsSWu+x0P5glxwj2UmMgn8UNgbtF0RBLCPNBi
	RRBgMF/YCGZPv+0u8jaCTq2jonb3f1ExiuNwgFZWqANZskpRuWlEcQYdHLIkdVYAA+6YA7oaFcyiz
	IOwhBQYe/JeNY5ZBOFkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGlv-0001JT-0I; Fri, 22 Feb 2019 19:46:11 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGlr-0001J2-00
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:46:09 +0000
Received: by mail-pl1-x644.google.com with SMTP id m10so1525882plt.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HwRSywUMrhaEYOTUd4ZZFkdumfa5Qr7Zf9nw2JVa4V0=;
 b=Zl+kftGJefRTCv1UirCyE41RcEs1dEXDcJuMEIVxp20rzsZdOiFP46WAq5rXJL6OcP
 /6WDXALM7cbXdJNlOk9wHSsyFmajJXiWNC5boc/qpLzSFZNop33D9mRpHfCsAMfO6mDV
 666Btfpo5OqNb68xxnzCo4n/d8kCsjnY2iRshwGpjergIB+DpirdAUqUNXkPQFD0DQKf
 K+1UfTEJHhaEgrbcvOxmk3nsBIHrSHGSanusPLFLnTvP3ynFlAb8WhOUJM80Ch2a6z60
 oU+Le/rDO/hibVnjRp/S/rlY8F07qFt+bzzMZTBbTOGXGcB2Er4gq0sg54aK9cFZ6ZqK
 Rkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HwRSywUMrhaEYOTUd4ZZFkdumfa5Qr7Zf9nw2JVa4V0=;
 b=UgbxgWk7HB97QgoUgUNLpPstC4XxydOk8LSa7qEo/9uFgAAmoMpKjTCtAVHuyPNSuc
 EBQfREPLtY/gr+NVx1kDyN8o8hBCryBlEfsOu3+yWl9MGCG5yaQqE3AltrSf6/QNKaFO
 svR81b2XbTx/AEfwq+4yAZyIM1jHTzz/iDt7sk3ndbEz+/IcrB0KpeDPzoM4Jozb5YMN
 MdW/eVOfv7avBRiE/BqK1cMZqmds+9HeIj67b3VFftfRhXefKvgZ3+kGvfILHMX5CllO
 wlf6YL9jDQFQOHixtczTe334OQHcx1BPxYl84v9bNie37jJGRnjEjqX7PaO9GQofqyBf
 bQ3A==
X-Gm-Message-State: AHQUAuY+sg9dObnKTjqCx7RkrgOlHoOiiwvOo4niPCAGzgedaFlzswLr
 Gj6x8+9d124TPchItUr4Ow49h7VprDEgaBAjmaM=
X-Google-Smtp-Source: AHgI3IaZR/31OiFn4e1FvZkZLtDSR0XeXU2709V5qCISGPVaKwMKEvOXF6JyzH2CINIyl341UemZGmFDYpJAXfD3ZOk=
X-Received: by 2002:a17:902:8ec1:: with SMTP id
 x1mr5935009plo.52.1550864765441; 
 Fri, 22 Feb 2019 11:46:05 -0800 (PST)
MIME-Version: 1.0
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
 <1550253761-26841-2-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550253761-26841-2-git-send-email-Frank.Li@nxp.com>
From: Zhi Li <lznuaa@gmail.com>
Date: Fri, 22 Feb 2019 13:45:53 -0600
Message-ID: <CAHrpEqROSC7_LnkoT=HDjEh=nitN+3PkNEgzaadCABR52Si8Vw@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] drivers/perf: imx_ddr: Add ddr performance counter
 support
To: Frank Li <frank.li@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_114607_044019_CF4BB2B6 
X-CRM114-Status: GOOD (  21.34  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 12:03 PM Frank Li <frank.li@nxp.com> wrote:
>
> Add ddr performance monitor support for iMX8QXP
>
> There are 4 counters for ddr perfomance events.
> counter 0 is dedicated for cycles.
> you choose any up to 3 no cycles events.

Any additional comments for these patches?

best regards
Frank Li

>
> for example:
>
> perf stat -a -e ddr0/read-access/,ddr0/write-access/,ddr0/precharge/ ls
> perf stat -a -e ddr0/cycles/,ddr0/read-access/,ddr0/write-access/ ls
>
> Support below events.
>
>   ddr0/activate/                                     [Kernel PMU event]
>   ddr0/axid-read/                                    [Kernel PMU event]
>   ddr0/axid-write/                                   [Kernel PMU event]
>   ddr0/cycles/                                       [Kernel PMU event]
>   ddr0/hp-read-credit-cnt/                           [Kernel PMU event]
>   ddr0/hp-read/                                      [Kernel PMU event]
>   ddr0/hp-req-nodcredit/                             [Kernel PMU event]
>   ddr0/hp-xact-credit/                               [Kernel PMU event]
>   ddr0/load-mode/                                    [Kernel PMU event]
>   ddr0/lp-read-credit-cnt/                           [Kernel PMU event]
>   ddr0/lp-req-nocredit/                              [Kernel PMU event]
>   ddr0/lp-xact-credit/                               [Kernel PMU event]
>   ddr0/mwr/                                          [Kernel PMU event]
>   ddr0/precharge/                                    [Kernel PMU event]
>   ddr0/raw-hazard/                                   [Kernel PMU event]
>   ddr0/read-access/                                  [Kernel PMU event]
>   ddr0/read-activate/                                [Kernel PMU event]
>   ddr0/read-command/                                 [Kernel PMU event]
>   ddr0/read-cycles/                                  [Kernel PMU event]
>   ddr0/read-modify-write-command/                    [Kernel PMU event]
>   ddr0/read-queue-depth/                             [Kernel PMU event]
>   ddr0/read-write-transition/                        [Kernel PMU event]
>   ddr0/read/                                         [Kernel PMU event]
>   ddr0/refresh/                                      [Kernel PMU event]
>   ddr0/selfresh/                                     [Kernel PMU event]
>   ddr0/wr-xact-credit/                               [Kernel PMU event]
>   ddr0/write-access/                                 [Kernel PMU event]
>   ddr0/write-command/                                [Kernel PMU event]
>   ddr0/write-credit-cnt/                             [Kernel PMU event]
>   ddr0/write-cycles/                                 [Kernel PMU event]
>   ddr0/write-queue-depth/                            [Kernel PMU event]
>   ddr0/write/
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
>  * Change FSL_IMX8_DDR_PERF to FSL_IMX8_DDR_PMU
>  * sort include
>  * remove struct fsl_ddr_devtype_data
>  * Added comment need disable control first
>  * Added comment about must enable cycle counter
>  * Added macro for EVENT_AXI_READ, remove hardcode 0x41 and 0x42
>  * Added comment about cycle counter is fastest one
>
> Change from v2 to v3
>  * remove kfree
>
> Change from V1 to V2
>  * update Kconfig by use i.MX8 instead of i.MX8 QXP
>  * remove gpl statememnt since SPDX tag
>  * use dev_kzalloc
>  * use dev_err
>  * commit message show axi_read 0x41\axi_write 0x42
>  * commit message show cycles must be enabled
>  * Irq only issue at cycles overflow
>  * use NUM_COUNTER
>  * use devm_request_irq
>  * add hotplug callback to handle context migration
>
>  drivers/perf/Kconfig             |   7 +
>  drivers/perf/Makefile            |   1 +
>  drivers/perf/fsl_imx8_ddr_perf.c | 573 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 581 insertions(+)
>  create mode 100644 drivers/perf/fsl_imx8_ddr_perf.c
>
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index af9bc17..e567437 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -61,6 +61,13 @@ config ARM_DSU_PMU
>           system, control logic. The PMU allows counting various events related
>           to DSU.
>
> +config FSL_IMX8_DDR_PMU
> +       tristate "Freescale i.MX8 DDR perf monitor"
> +       depends on ARCH_MXC
> +         help
> +         Provides support for ddr perfomance monitor in i.MX8. Provide memory
> +         througput information.
> +
>  config HISI_PMU
>         bool "HiSilicon SoC PMU"
>         depends on ARM64 && ACPI
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 909f27f..0bc066b 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARM_CCN) += arm-ccn.o
>  obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
>  obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
>  obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
> +obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
>  obj-$(CONFIG_HISI_PMU) += hisilicon/
>  obj-$(CONFIG_QCOM_L2_PMU)      += qcom_l2_pmu.o
>  obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> new file mode 100644
> index 0000000..3d02daf
> --- /dev/null
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -0,0 +1,573 @@
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
> +
> +#define COUNTER_CNTL           0x0
> +#define COUNTER_READ           0x20
> +
> +#define COUNTER_DPCR1          0x30
> +
> +#define CNTL_OVER              0x1
> +#define CNTL_CLEAR             0x2
> +#define CNTL_EN                        0x4
> +#define CNTL_EN_MASK           0xFFFFFFFB
> +#define CNTL_CLEAR_MASK                0xFFFFFFFD
> +#define CNTL_OVER_MASK         0xFFFFFFFE
> +
> +#define CNTL_CSV_SHIFT         24
> +#define CNTL_CSV_MASK          (0xFF << CNTL_CSV_SHIFT)
> +
> +#define EVENT_CYCLES_ID                0
> +#define EVENT_CYCLES_COUNTER   0
> +#define NUM_COUNTER            4
> +#define MAX_EVENT              3
> +#define EVENT_AXI_READ         0x41
> +#define EVENT_AXI_WRITE                0x42
> +
> +#define to_ddr_pmu(p)          container_of(p, struct ddr_pmu, pmu)
> +
> +#define DDR_PERF_DEV_NAME      "ddr_perf"
> +
> +static DEFINE_IDA(ddr_ida);
> +
> +PMU_EVENT_ATTR_STRING(cycles, ddr_perf_cycles, "event=0x00");
> +PMU_EVENT_ATTR_STRING(selfresh, ddr_perf_selfresh, "event=0x01");
> +PMU_EVENT_ATTR_STRING(read-access, ddr_perf_read_accesses, "event=0x04");
> +PMU_EVENT_ATTR_STRING(write-access, ddr_perf_write_accesses, "event=0x05");
> +PMU_EVENT_ATTR_STRING(read-queue-depth, ddr_perf_read_queue_depth,
> +                       "event=0x08");
> +PMU_EVENT_ATTR_STRING(write-queue-depth, ddr_perf_write_queue_depth,
> +                       "event=0x09");
> +PMU_EVENT_ATTR_STRING(lp-read-credit-cnt, ddr_perf_lp_read_credit_cnt,
> +                       "event=0x10");
> +PMU_EVENT_ATTR_STRING(hp-read-credit-cnt, ddr_perf_hp_read_credit_cnt,
> +                       "event=0x11");
> +PMU_EVENT_ATTR_STRING(write-credit-cnt, ddr_perf_write_credit_cnt,
> +                       "event=0x12");
> +PMU_EVENT_ATTR_STRING(read-command, ddr_perf_read_command, "event=0x20");
> +PMU_EVENT_ATTR_STRING(write-command, ddr_perf_write_command, "event=0x21");
> +PMU_EVENT_ATTR_STRING(read-modify-write-command,
> +               ddr_perf_read_modify_write_command, "event=0x22");
> +PMU_EVENT_ATTR_STRING(hp-read, ddr_perf_hp_read, "event=0x23");
> +PMU_EVENT_ATTR_STRING(hp-req-nodcredit, ddr_perf_hp_req_nocredit, "event=0x24");
> +PMU_EVENT_ATTR_STRING(hp-xact-credit, ddr_perf_hp_xact_credit, "event=0x25");
> +PMU_EVENT_ATTR_STRING(lp-req-nocredit, ddr_perf_lp_req_nocredit, "event=0x26");
> +PMU_EVENT_ATTR_STRING(lp-xact-credit, ddr_perf_lp_xact_credit, "event=0x27");
> +PMU_EVENT_ATTR_STRING(wr-xact-credit, ddr_perf_wr_xact_credit, "event=0x29");
> +PMU_EVENT_ATTR_STRING(read-cycles, ddr_perf_read_cycles, "event=0x2a");
> +PMU_EVENT_ATTR_STRING(write-cycles, ddr_perf_write_cycles, "event=0x2b");
> +PMU_EVENT_ATTR_STRING(read-write-transition, ddr_perf_read_write_transition,
> +                       "event=0x30");
> +PMU_EVENT_ATTR_STRING(precharge, ddr_perf_precharge, "event=0x31");
> +PMU_EVENT_ATTR_STRING(activate, ddr_perf_activate, "event=0x32");
> +PMU_EVENT_ATTR_STRING(load-mode, ddr_perf_load_mode, "event=0x33");
> +PMU_EVENT_ATTR_STRING(mwr, ddr_perf_mwr, "event=0x34");
> +PMU_EVENT_ATTR_STRING(read, ddr_perf_read, "event=0x35");
> +PMU_EVENT_ATTR_STRING(read-activate, ddr_perf_read_activate, "event=0x36");
> +PMU_EVENT_ATTR_STRING(refresh, ddr_perf_refresh, "event=0x37");
> +PMU_EVENT_ATTR_STRING(write, ddr_perf_write, "event=0x38");
> +PMU_EVENT_ATTR_STRING(raw-hazard, ddr_perf_raw_hazard, "event=0x39");
> +
> +PMU_EVENT_ATTR_STRING(axid-read, ddr_perf_axid_read,
> +                       "event="__stringify(EVENT_AXI_READ));
> +PMU_EVENT_ATTR_STRING(axid-write, ddr_perf_axid_write,
> +                       "event="__stringify(EVENT_AXI_WRITE));
> +
> +#define DDR_CAP_AXI_ID 0x1
> +
> +static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> +       { .compatible = "fsl,imx8-ddr-pmu",},
> +       { .compatible = "fsl,imx8m-ddr-pmu", .data = (void *)DDR_CAP_AXI_ID},
> +       { /* sentinel */ }
> +};
> +
> +struct ddr_pmu {
> +       struct pmu pmu;
> +       void __iomem *base;
> +       cpumask_t cpu;
> +       struct  hlist_node node;
> +       struct  device *dev;
> +       struct perf_event *active_events[NUM_COUNTER];
> +       int total_events;
> +       enum cpuhp_state cpuhp_state;
> +       bool cycles_active;
> +       uintptr_t flags;
> +};
> +
> +static ssize_t ddr_perf_cpumask_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct ddr_pmu *pmu = dev_get_drvdata(dev);
> +
> +       return cpumap_print_to_pagebuf(true, buf, &pmu->cpu);
> +}
> +
> +static struct device_attribute ddr_perf_cpumask_attr =
> +       __ATTR(cpumask, 0444, ddr_perf_cpumask_show, NULL);
> +
> +static struct attribute *ddr_perf_cpumask_attrs[] = {
> +       &ddr_perf_cpumask_attr.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group ddr_perf_cpumask_attr_group = {
> +       .attrs = ddr_perf_cpumask_attrs,
> +};
> +
> +static struct attribute *ddr_perf_events_attrs[] = {
> +       &ddr_perf_cycles.attr.attr,
> +       &ddr_perf_selfresh.attr.attr,
> +       &ddr_perf_read_accesses.attr.attr,
> +       &ddr_perf_write_accesses.attr.attr,
> +       &ddr_perf_read_queue_depth.attr.attr,
> +       &ddr_perf_write_queue_depth.attr.attr,
> +       &ddr_perf_lp_read_credit_cnt.attr.attr,
> +       &ddr_perf_hp_read_credit_cnt.attr.attr,
> +       &ddr_perf_write_credit_cnt.attr.attr,
> +       &ddr_perf_read_command.attr.attr,
> +       &ddr_perf_write_command.attr.attr,
> +       &ddr_perf_read_modify_write_command.attr.attr,
> +       &ddr_perf_hp_read.attr.attr,
> +       &ddr_perf_hp_req_nocredit.attr.attr,
> +       &ddr_perf_hp_xact_credit.attr.attr,
> +       &ddr_perf_lp_req_nocredit.attr.attr,
> +       &ddr_perf_lp_xact_credit.attr.attr,
> +       &ddr_perf_wr_xact_credit.attr.attr,
> +       &ddr_perf_read_cycles.attr.attr,
> +       &ddr_perf_write_cycles.attr.attr,
> +       &ddr_perf_read_write_transition.attr.attr,
> +       &ddr_perf_precharge.attr.attr,
> +       &ddr_perf_activate.attr.attr,
> +       &ddr_perf_load_mode.attr.attr,
> +       &ddr_perf_mwr.attr.attr,
> +       &ddr_perf_read.attr.attr,
> +       &ddr_perf_read_activate.attr.attr,
> +       &ddr_perf_refresh.attr.attr,
> +       &ddr_perf_write.attr.attr,
> +       &ddr_perf_raw_hazard.attr.attr,
> +       &ddr_perf_axid_read.attr.attr,
> +       &ddr_perf_axid_write.attr.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group ddr_perf_events_attr_group = {
> +       .name = "events",
> +       .attrs = ddr_perf_events_attrs,
> +};
> +
> +PMU_FORMAT_ATTR(event, "config:0-63");
> +PMU_FORMAT_ATTR(axi_id, "config1:0-63");
> +
> +static struct attribute *ddr_perf_format_attrs[] = {
> +       &format_attr_event.attr,
> +       &format_attr_axi_id.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group ddr_perf_format_attr_group = {
> +       .name = "format",
> +       .attrs = ddr_perf_format_attrs,
> +};
> +
> +static const struct attribute_group *attr_groups[] = {
> +       &ddr_perf_events_attr_group,
> +       &ddr_perf_format_attr_group,
> +       &ddr_perf_cpumask_attr_group,
> +       NULL,
> +};
> +
> +static u32 ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event)
> +{
> +       int i;
> +
> +       /* Always map cycle event to counter 0
> +          Cycles counter is dedicated for cycle event
> +          can't used for the other events
> +        */
> +       if (event == EVENT_CYCLES_ID)
> +               return EVENT_CYCLES_COUNTER;
> +
> +       for (i = 1; i < NUM_COUNTER; i++)
> +               if (pmu->active_events[i] == NULL)
> +                       return i;
> +
> +       return -ENOENT;
> +}
> +
> +static u32 ddr_perf_free_counter(struct ddr_pmu *pmu, int counter)
> +{
> +       if (counter < 0 || counter >= NUM_COUNTER)
> +               return -ENOENT;
> +
> +       pmu->active_events[counter] = NULL;
> +
> +       return 0;
> +}
> +
> +static u32 ddr_perf_read_counter(struct ddr_pmu *pmu, int counter)
> +{
> +       return readl(pmu->base + COUNTER_READ + counter * 4);
> +}
> +
> +static int ddr_perf_event_init(struct perf_event *event)
> +{
> +       struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +       struct hw_perf_event *hwc = &event->hw;
> +
> +       if (event->attr.type != event->pmu->type)
> +               return -ENOENT;
> +
> +       if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +               return -EOPNOTSUPP;
> +
> +       if (event->cpu < 0) {
> +               dev_warn(pmu->dev, "Can't provide per-task data!\n");
> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (event->attr.exclude_user        ||
> +           event->attr.exclude_kernel      ||
> +           event->attr.exclude_hv          ||
> +           event->attr.exclude_idle        ||
> +           event->attr.exclude_host        ||
> +           event->attr.exclude_guest       ||
> +           event->attr.sample_period)
> +               return -EINVAL;
> +
> +       event->cpu = cpumask_first(&pmu->cpu);
> +       hwc->idx = -1;
> +
> +       return 0;
> +}
> +
> +
> +static void ddr_perf_event_update(struct perf_event *event)
> +{
> +       struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +       struct hw_perf_event *hwc = &event->hw;
> +       u64 delta, prev_raw_count, new_raw_count;
> +       int counter = hwc->idx;
> +
> +       do {
> +               prev_raw_count = local64_read(&hwc->prev_count);
> +               new_raw_count = ddr_perf_read_counter(pmu, counter);
> +       } while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> +                       new_raw_count) != prev_raw_count);
> +
> +       delta = (new_raw_count - prev_raw_count) & 0xFFFFFFFF;
> +
> +       local64_add(delta, &event->count);
> +}
> +
> +static void ddr_perf_event_enable(struct ddr_pmu *pmu, int config,
> +                                 int counter, bool enable)
> +{
> +       u8 reg = counter * 4 + COUNTER_CNTL;
> +       int val;
> +
> +       if (enable) {
> +               /* must disable first, then enable again
> +                * otherwise, cycle counter will not work
> +                * if previous state is enabled.
> +                */
> +               writel(0, pmu->base + reg);
> +               val = CNTL_EN | CNTL_CLEAR;
> +               val |= (config << CNTL_CSV_SHIFT) & CNTL_CSV_MASK;
> +       } else {
> +               /* Disable counter */
> +               val = readl(pmu->base + reg) & CNTL_EN_MASK;
> +       }
> +
> +       writel(val, pmu->base + reg);
> +
> +       if (config == EVENT_CYCLES_ID)
> +               pmu->cycles_active = enable;
> +}
> +
> +static void ddr_perf_event_start(struct perf_event *event, int flags)
> +{
> +       struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +       struct hw_perf_event *hwc = &event->hw;
> +       int counter = hwc->idx;
> +
> +       if (pmu->flags & DDR_CAP_AXI_ID) {
> +               if (event->attr.config == EVENT_AXI_READ ||
> +                   event->attr.config == EVENT_AXI_WRITE) {
> +                       int val = event->attr.config1;
> +
> +                       writel(val, pmu->base + COUNTER_DPCR1);
> +               }
> +       }
> +
> +       local64_set(&hwc->prev_count, 0);
> +
> +       ddr_perf_event_enable(pmu, event->attr.config, counter, true);
> +       /*
> +        * If the cycles counter wasn't explicitly selected,
> +        * we will enable it now.
> +        * cycles counter must be enabled otherwise other counters will
> +        * stopped.
> +        */
> +       if (counter > 0 && !pmu->cycles_active)
> +               ddr_perf_event_enable(pmu, EVENT_CYCLES_ID,
> +                                     EVENT_CYCLES_COUNTER, true);
> +}
> +
> +static int ddr_perf_event_add(struct perf_event *event, int flags)
> +{
> +       struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +       struct hw_perf_event *hwc = &event->hw;
> +       int counter;
> +       int cfg = event->attr.config;
> +
> +       counter = ddr_perf_alloc_counter(pmu, cfg);
> +       if (counter < 0) {
> +               dev_dbg(pmu->dev, "There are not enough counters\n");
> +               return -EOPNOTSUPP;
> +       }
> +
> +       pmu->active_events[counter] = event;
> +       pmu->total_events++;
> +       hwc->idx = counter;
> +
> +       if (flags & PERF_EF_START)
> +               ddr_perf_event_start(event, flags);
> +
> +       local64_set(&hwc->prev_count, ddr_perf_read_counter(pmu, counter));
> +
> +       return 0;
> +}
> +
> +static void ddr_perf_event_stop(struct perf_event *event, int flags)
> +{
> +       struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +       struct hw_perf_event *hwc = &event->hw;
> +       int counter = hwc->idx;
> +
> +       ddr_perf_event_enable(pmu, event->attr.config, counter, false);
> +       ddr_perf_event_update(event);
> +}
> +
> +static void ddr_perf_event_del(struct perf_event *event, int flags)
> +{
> +       struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +       struct hw_perf_event *hwc = &event->hw;
> +       int counter = hwc->idx;
> +
> +       ddr_perf_event_stop(event, PERF_EF_UPDATE);
> +
> +       ddr_perf_free_counter(pmu, counter);
> +       pmu->total_events--;
> +       hwc->idx = -1;
> +
> +       /* If all events have stopped, stop the cycles counter as well */
> +       if ((pmu->total_events == 0) && pmu->cycles_active)
> +               ddr_perf_event_enable(pmu, EVENT_CYCLES_ID,
> +                                     EVENT_CYCLES_COUNTER, false);
> +}
> +
> +static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
> +                        struct device *dev)
> +{
> +       *pmu = (struct ddr_pmu) {
> +               .pmu = (struct pmu) {
> +                       .task_ctx_nr = perf_invalid_context,
> +                       .attr_groups = attr_groups,
> +                       .event_init  = ddr_perf_event_init,
> +                       .add         = ddr_perf_event_add,
> +                       .del         = ddr_perf_event_del,
> +                       .start       = ddr_perf_event_start,
> +                       .stop        = ddr_perf_event_stop,
> +                       .read        = ddr_perf_event_update,
> +               },
> +               .base = base,
> +               .dev = dev,
> +       };
> +
> +       return ida_simple_get(&ddr_ida, 0, 0, GFP_KERNEL);
> +}
> +
> +static irqreturn_t ddr_perf_irq_handler(int irq, void *p)
> +{
> +       int i;
> +       u8 reg;
> +       int val;
> +       int counter;
> +       struct ddr_pmu *pmu = (struct ddr_pmu *) p;
> +       struct perf_event *event;
> +
> +       /* Only cycles counter overflowed can issue irq. all counters will
> +        * be stopped when cycles counter overflow. but other counter don't stop
> +        * when overflow happen. Update all of the local counter values,
> +        * then reset the cycles counter, so the others can continue
> +        * counting. cycles counter is fastest counter in all events. at last
> +        * 4 times than other counters.
> +        */
> +       for (i = 0; i < NUM_COUNTER; i++) {
> +
> +               if (!pmu->active_events[i])
> +                       continue;
> +
> +               event = pmu->active_events[i];
> +               counter = event->hw.idx;
> +               reg = counter * 4 + COUNTER_CNTL;
> +               val = readl(pmu->base + reg);
> +
> +               ddr_perf_event_update(event);
> +
> +               if (counter == EVENT_CYCLES_COUNTER) {
> +                       ddr_perf_event_enable(pmu,
> +                                             EVENT_CYCLES_ID,
> +                                             EVENT_CYCLES_COUNTER,
> +                                             true);
> +                       ddr_perf_event_update(event);
> +               }
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +       struct ddr_pmu *pmu = hlist_entry_safe(node, struct ddr_pmu, node);
> +       int target;
> +
> +       if (!cpumask_test_and_clear_cpu(cpu, &pmu->cpu))
> +               return 0;
> +
> +       target = cpumask_any_but(cpu_online_mask, cpu);
> +       if (target >= nr_cpu_ids)
> +               return 0;
> +
> +       perf_pmu_migrate_context(&pmu->pmu, cpu, target);
> +       cpumask_set_cpu(target, &pmu->cpu);
> +
> +       return 0;
> +}
> +
> +static int ddr_perf_probe(struct platform_device *pdev)
> +{
> +       struct ddr_pmu *pmu;
> +       struct device_node *np;
> +       void __iomem *base;
> +       struct resource *iomem;
> +       char *name;
> +       char *hpname;
> +       int num;
> +       int ret;
> +       u32 irq;
> +       const struct of_device_id *of_id =
> +               of_match_device(imx_ddr_pmu_dt_ids, &pdev->dev);
> +
> +       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(&pdev->dev, iomem);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       np = pdev->dev.of_node;
> +
> +       pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
> +       if (!pmu)
> +               return -ENOMEM;
> +
> +       num = ddr_perf_init(pmu, base, &pdev->dev);
> +
> +       name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ddr%d", num);
> +       if (!name)
> +               return -ENOMEM;
> +
> +       hpname = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +                               "perf/imx/ddr%d:online", num);
> +       if (!hpname)
> +               return -ENOMEM;
> +
> +       pmu->flags = (uintptr_t) of_id->data;
> +
> +       cpumask_set_cpu(raw_smp_processor_id(), &pmu->cpu);
> +       ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, hpname, NULL,
> +                                        ddr_perf_offline_cpu);
> +
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "cpuhp_setup_state_multi failed\n");
> +               goto ddr_perf_err;
> +       }
> +
> +       pmu->cpuhp_state = ret;
> +
> +       /* Register the pmu instance for cpu hotplug */
> +       cpuhp_state_add_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +
> +       ret = perf_pmu_register(&(pmu->pmu), name, -1);
> +       if (ret)
> +               goto ddr_perf_err;
> +
> +       /* Request irq */
> +       irq = of_irq_get(np, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "Failed to get irq: %d", irq);
> +               ret = irq;
> +               goto ddr_perf_irq_err;
> +       }
> +
> +       ret = devm_request_irq(&pdev->dev, irq,
> +                                       ddr_perf_irq_handler,
> +                                       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +                                       DDR_PERF_DEV_NAME,
> +                                       pmu);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Request irq failed: %d", ret);
> +               goto ddr_perf_irq_err;
> +       }
> +
> +       return 0;
> +
> +ddr_perf_irq_err:
> +       perf_pmu_unregister(&(pmu->pmu));
> +
> +ddr_perf_err:
> +       if (pmu->cpuhp_state)
> +               cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +
> +       dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
> +       return ret;
> +}
> +
> +static int ddr_perf_remove(struct platform_device *pdev)
> +{
> +       struct ddr_pmu *pmu = platform_get_drvdata(pdev);
> +
> +       cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +       perf_pmu_unregister(&pmu->pmu);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver imx_ddr_pmu_driver = {
> +       .driver         = {
> +               .name   = "imx-ddr-pmu",
> +               .of_match_table = imx_ddr_pmu_dt_ids,
> +       },
> +       .probe          = ddr_perf_probe,
> +       .remove         = ddr_perf_remove,
> +};
> +
> +static int __init imx_ddr_pmu_init(void)
> +{
> +       return platform_driver_register(&imx_ddr_pmu_driver);
> +}
> +
> +module_init(imx_ddr_pmu_init);
> +
> --
> 2.5.2
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
