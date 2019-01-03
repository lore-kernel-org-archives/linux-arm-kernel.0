Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35AB21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rjT1y0e9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TW4JtqNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35AB21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DbfyIgtcLLE31qHYBCPfE8gzz0kRRZ5dNaevqkknDtU=; b=rjT1y0e9ISLkOS
	TpkpaZviS7Qv0zpK1SMHTuyEElCpUSHmh2a8sBBKByuFryIxgOhtjxBmZXOEfUvLIyeC4E5IZzUxs
	9H70nyId74kewqkgMq/C4sSVA4/gSywUxnWunO0bJzwmYKKvtEGMF0qpLaFlm+6gNU+WP5v75oWhD
	e8vqZfxfqTtx0fZ+oaBxONEtaBVw+ss9zcH42LrQ5KDIiHrrh7Ec4HFUH7j5OXFttF2JcoszyR6/u
	RWkglJrGC2RJ7IPBuVlhQ4QHkCZggvhLJgQmEVFK7NPEe0yQR0L8pNudnd+9DNtaLKTN6sOaCKBee
	/BZDDObK0kPSzuqF9lRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfC6S-0002yk-3l; Thu, 03 Jan 2019 23:08:40 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfC6O-0002xy-J2
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 23:08:38 +0000
Received: by mail-pl1-x643.google.com with SMTP id gn14so16531149plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 15:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=7UdCHbE859jwPfcwXHGD+QhI1MzB5DLi1gzzamVRw4s=;
 b=TW4JtqNz84nNXPzgdvUQnTLmfJ6B6Ql1y+gF7j6twmnPjNiuNFwbS1gzGyLCHyXOzh
 BOhNi+xdwBrQlQzAaLSfr88s9/zPpTjWKU5ny2zLKiXyBK//M6x4/tPPLMraYhlGhjWP
 iITIMlpvXpycTpMXJNHXQqFNCLa51o2sB2tbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=7UdCHbE859jwPfcwXHGD+QhI1MzB5DLi1gzzamVRw4s=;
 b=FOmB8+TYcVpPcENyl4n25LxVRrfh9Sz/ru8x8F394NHeQOTmLoxw+BPCye4q+vIigh
 CK4FzU4u2JdGmaXOsbHIwlWGczY79E/HVQa0/cCutewl6AdYVIx8kXuUpoHtD72Ppgfd
 YcdSgxVG1yl/p0V0NAF7do7U3LYqSv/TvPtiAInmH4+8SEVWd9gANkCjMdOGiHAMDJ/a
 skbSrfhA4aU5Ol4nW07YLwHZl5VanSJmsXzXM4/kn/2TldHG7sNtVEahrQjocYDnAs13
 nMXv1l1C+iF0OFE+kIQ34Gz/c96fu8KX0Gt/FY5CHO7VZZ/vJfRhflHaxmxqHocQNsSG
 Kfmw==
X-Gm-Message-State: AJcUukfp4D3qMnq586i3/tUJHSfAdpQFoJV4Za0lEtnINsDsOVCVX2PQ
 Qs5NWFHKnCqa732/jttKbFWkuw==
X-Google-Smtp-Source: ALg8bN589W2xiR+UUwdV62VA5H+pBaYIS7eBvnaS1DBZ8kLIwy3zeoANfd3xgu+0Mc+YCFCb0uRX7A==
X-Received: by 2002:a17:902:24e7:: with SMTP id
 l36mr48801036plg.61.1546556915272; 
 Thu, 03 Jan 2019 15:08:35 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id 125sm100811360pfd.124.2019.01.03.15.08.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 15:08:34 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [RFC RESEND PATCH 6/7] soc: mediatek: add MT8183 dvfsrc support
To: Henry Chen <henryc.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>
In-Reply-To: <1546438198-1677-7-git-send-email-henryc.chen@mediatek.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-7-git-send-email-henryc.chen@mediatek.com>
Message-ID: <154655691363.15366.15223653253336032554@swboyd.mtv.corp.google.com>
Date: Thu, 03 Jan 2019 15:08:33 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_150836_653692_0AAF81BF 
X-CRM114-Status: GOOD (  26.56  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Henry Chen <henryc.chen@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Henry Chen (2019-01-02 06:09:57)
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index a7d0667..f956f03 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -12,6 +12,21 @@ config MTK_INFRACFG
>           INFRACFG controller contains various infrastructure registers not
>           directly associated to any device.
>  
> +config MTK_DVFSRC
> +       bool "MediaTek DVFSRC Support"
> +       depends on ARCH_MEDIATEK
> +       default ARCH_MEDIATEK
> +       select REGMAP

Why?

> +       select MTK_INFRACFG
> +       select PM_GENERIC_DOMAINS if PM

It doesn't depend on it?

> +       depends on MTK_SCPSYS
> +       help
> +         Say yes here to add support for the MediaTek DVFSRC found

Maybe you can spell out what the DVFSRC acronym means?

> +         on different MediaTek SoCs. The DVFSRC is a proprietary
> +         hardware which is used to collect all the requests from
> +         system and turn into the decision of minimum Vcore voltage
> +         and minimum DRAM frequency to fulfill those requests.
> +
>  config MTK_PMIC_WRAP
>         tristate "MediaTek PMIC Wrapper Support"
>         depends on RESET_CONTROLLER
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 9dc6670..5c010b9 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MTK_DVFSRC) += mtk-dvfsrc.o
>  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
> new file mode 100644
> index 0000000..af462a3
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-dvfsrc.c
> @@ -0,0 +1,473 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 MediaTek Inc.
> + */
> +#include <linux/arm-smccc.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>

Presumably both interrupt.h and irq.h aren't needed.

> +#include <linux/delay.h>
> +#include <linux/kthread.h>

Is this used?

> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>

Is this used?

> +#include <soc/mediatek/mtk_sip.h>
> +#include <dt-bindings/power/mt8183-power.h>
> +#include <dt-bindings/soc/mtk,dvfsrc.h>
> +#include "mtk-scpsys.h"
> +
> +#define DVFSRC_IDLE            0x00
> +#define DVFSRC_GET_TARGET_LEVEL(x)     (((x) >> 0) & 0x0000ffff)
> +#define DVFSRC_GET_CURRENT_LEVEL(x)    (((x) >> 16) & 0x0000ffff)
> +
> +/* macro for irq */
> +#define DVFSRC_IRQ_TIMEOUT_EN          BIT(1)
> +
> +struct dvfsrc_opp {
> +       int vcore_opp;
> +       int dram_opp;
> +};
> +
> +struct dvfsrc_domain {
> +       int id;
> +       int state;

Does id or state need to be signed? Perhaps unsigned or u32 is better?

> +};
> +
> +struct mtk_dvfsrc;
> +struct dvfsrc_soc_data {
> +       const int *regs;
> +       int num_opp;
> +       int num_domains;
> +       int dram_sft;
> +       int vcore_sft;
> +       const struct dvfsrc_opp **opps;
> +       struct dvfsrc_domain *domains;
> +       void (*init_soc)(struct mtk_dvfsrc *dvfsrc);
> +       int (*get_target_level)(struct mtk_dvfsrc *dvfsrc);
> +       int (*get_current_level)(struct mtk_dvfsrc *dvfsrc);
> +};
> +
> +struct mtk_dvfsrc {
> +       struct device *dev;
> +       struct clk *clk_dvfsrc;
> +       const struct dvfsrc_soc_data *dvd;
> +       int dram_type;
> +       int irq;
> +       void __iomem *regs;
> +       struct mutex lock;      /* generic mutex for dvfsrc driver */

That's not a very useful comment. Please make it useful or remove it.

> +
> +       struct notifier_block qos_notifier;
> +       struct notifier_block scpsys_notifier;
> +};
> +
> +static u32 dvfsrc_read(struct mtk_dvfsrc *dvfs, u32 offset)
> +{
> +       return readl(dvfs->regs + dvfs->dvd->regs[offset]);
> +}
> +
> +static void dvfsrc_write(struct mtk_dvfsrc *dvfs, u32 offset, u32 val)
> +{
> +       writel(val, dvfs->regs + dvfs->dvd->regs[offset]);
> +}
> +
[...]
> +
> +static bool dvfsrc_is_idle(struct mtk_dvfsrc *dvfsrc)
> +{
> +       int val = 0;
> +
> +       if (dvfsrc->dvd->get_target_level)
> +               val = dvfsrc->dvd->get_target_level(dvfsrc);
> +
> +       return val == DVFSRC_IDLE;
> +}
> +
> +static int dvfsrc_wait_for_state(struct mtk_dvfsrc *dvfsrc,
> +                                bool (*fp)(struct mtk_dvfsrc *))

It's always dvfsrc_is_idle though, so why pass it as an argument?

> +{
> +       unsigned long timeout;
> +
> +       timeout = jiffies + usecs_to_jiffies(1000);
> +
> +       do {
> +               if (fp(dvfsrc))
> +                       return 0;
> +       } while (!time_after(jiffies, timeout));
> +
> +       return -ETIMEDOUT;
> +}
> +
> +static void mtk_dvfsrc_mt8183_init(struct mtk_dvfsrc *dvfsrc)
> +{
> +       struct arm_smccc_res res;
> +
> +       mutex_lock(&dvfsrc->lock);
> +
> +       arm_smccc_smc(MTK_SIP_SPM, MTK_SIP_SPM_DVFSRC_INIT, 0, 0, 0, 0, 0, 0,
> +                     &res);

What if that fails?

> +
> +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_0_1, 0x00100000);
> +
> +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_2_3, 0x00210011);
> +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_4_5, 0x01100100);
> +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_6_7, 0x01210111);
> +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_8_9, 0x02100200);
> +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_10_11, 0x02210211);
> +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_12_13, 0x03210321);
> +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_14_15, 0x03210321);
> +
> +       /* EMI/VCORE HRT, MD2SPM, BW setting */
> +       dvfsrc_write(dvfsrc, DVFSRC_EMI_QOS0, 0x32);
> +       dvfsrc_write(dvfsrc, DVFSRC_EMI_QOS1, 0x66);
> +       dvfsrc_write(dvfsrc, DVFSRC_EMI_MD2SPM0, 0x80F8);
> +       dvfsrc_write(dvfsrc, DVFSRC_EMI_MD2SPM1, 0x0);
> +       dvfsrc_write(dvfsrc, DVFSRC_VCORE_MD2SPM0, 0x80C0);
> +
> +       dvfsrc_write(dvfsrc, DVFSRC_RSRV_1, 0x0000001C);
> +       dvfsrc_write(dvfsrc, DVFSRC_TIMEOUT_NEXTREQ, 0x00000013);
> +       dvfsrc_write(dvfsrc, DVFSRC_INT_EN, 0x2);
> +
> +       dvfsrc_write(dvfsrc, DVFSRC_EMI_REQUEST, 0x00290209);
> +       dvfsrc_write(dvfsrc, DVFSRC_EMI_REQUEST2, 0);
> +
> +       dvfsrc_write(dvfsrc, DVFSRC_VCORE_REQUEST, 0x00150000);
> +
> +       dvfsrc_write(dvfsrc, DVFSRC_QOS_EN, 0x0000407F);
> +       dvfsrc_write(dvfsrc, DVFSRC_EMI_REQUEST3, 0x09000000);
> +
> +       dvfsrc_write(dvfsrc, DVFSRC_FORCE, 0x00400000);
> +       dvfsrc_write(dvfsrc, DVFSRC_BASIC_CONTROL, 0x0000C07B);
> +       dvfsrc_write(dvfsrc, DVFSRC_BASIC_CONTROL, 0x0000017B);
> +
> +       dvfsrc_write(dvfsrc, DVFSRC_VCORE_REQUEST,
> +                    (dvfsrc_read(dvfsrc, DVFSRC_VCORE_REQUEST)
> +                    & ~(0x3 << 20)));
> +       dvfsrc_write(dvfsrc, DVFSRC_EMI_REQUEST,
> +                    (dvfsrc_read(dvfsrc, DVFSRC_EMI_REQUEST)
> +                    & ~(0x3 << 20)));

Use some local variables so you don't read inside a write and make long
lines.

> +
> +       mutex_unlock(&dvfsrc->lock);
> +}
> +
> +static int mt8183_get_target_level(struct mtk_dvfsrc *dvfsrc)
> +{
> +       return DVFSRC_GET_TARGET_LEVEL(dvfsrc_read(dvfsrc, DVFSRC_LEVEL));
> +}
> +
> +static int mt8183_get_current_level(struct mtk_dvfsrc *dvfsrc)
> +{
> +       return DVFSRC_GET_CURRENT_LEVEL(dvfsrc_read(dvfsrc, DVFSRC_LEVEL));
> +}
> +
> +static int get_cur_performance_level(struct mtk_dvfsrc *dvfsrc)
> +{
> +       int bit = 0;
> +
> +       if (dvfsrc->dvd->get_current_level)
> +               bit = dvfsrc->dvd->get_current_level(dvfsrc);
> +
> +       return ffs(bit);
> +}
> +
> +static int pm_qos_memory_bw_notify(struct notifier_block *b,
> +                                  unsigned long bw, void *v)
> +{
> +       struct mtk_dvfsrc *dvfsrc;
> +
> +       dvfsrc = container_of(b, struct mtk_dvfsrc, qos_notifier);
> +       mutex_lock(&dvfsrc->lock);
> +
> +       dev_dbg(dvfsrc->dev, "data: 0x%lx\n", bw);
> +       dvfsrc_write(dvfsrc, DVFSRC_SW_BW_0, bw / 100);
> +
> +       mutex_unlock(&dvfsrc->lock);
> +
> +       return NOTIFY_OK;
> +}
> +
> +static int dvfsrc_set_performace(struct notifier_block *b,
> +                                unsigned long l, void *v)
> +{
> +       int i, val, highest = 0, vcore_opp = 0, dram_opp = 0;
> +       struct mtk_dvfsrc *dvfsrc;
> +       struct scp_event_data *sc = v;
> +       struct dvfsrc_domain *d;
> +
> +       if (sc->event_type != MTK_SCPSYS_PSTATE)
> +               return 0;
> +
> +       dvfsrc = container_of(b, struct mtk_dvfsrc, scpsys_notifier);
> +
> +       mutex_lock(&dvfsrc->lock);
> +       d = dvfsrc->dvd->domains;
> +
> +       if (l > dvfsrc->dvd->num_opp || l <= 0) {

How can l be < 0? It's unsigned.

> +               dev_err(dvfsrc->dev, "pstate out of range = %ld\n", l);
> +               goto out;
> +       }
> +
> +       for (i = 0, highest = 0; i < dvfsrc->dvd->num_domains - 1; i++, d++) {
> +               if (sc->domain_id == d->id)
> +                       d->state = l;
> +               if (d->state > highest)
> +                       highest = d->state;
> +       }
> +
> +       if (highest == 0) {
> +               dev_err(dvfsrc->dev, "domain not match\n");
> +               goto out;
> +       }
> +
> +       /* translate pstate to dvfsrc level, and set it to DVFSRC HW */
> +       vcore_opp =
> +               dvfsrc->dvd->opps[dvfsrc->dram_type][highest - 1].vcore_opp;
> +       dram_opp = dvfsrc->dvd->opps[dvfsrc->dram_type][highest - 1].dram_opp;

Maybe make a local variable for

	dvfsrc->dvd->opps[dvfsrc->dram_type][highest - 1]

so you don't have to read that more than once.

> +
> +       if (dvfsrc_wait_for_state(dvfsrc, dvfsrc_is_idle)) {
> +               dev_warn(dvfsrc->dev, "[%s] wait idle, last: %d -> %d\n",
> +                        __func__, dvfsrc_read(dvfsrc, DVFSRC_LEVEL),
> +               dvfsrc_read(dvfsrc, DVFSRC_LAST));
> +               goto out;
> +       }
> +
> +       dvfsrc_write(dvfsrc, DVFSRC_SW_REQ,
> +                    dram_opp << dvfsrc->dvd->dram_sft |
> +                    vcore_opp << dvfsrc->dvd->vcore_sft);
> +
> +       if (dvfsrc_wait_for_state(dvfsrc, dvfsrc_is_idle)) {
> +               dev_warn(dvfsrc->dev, "[%s] wait idle, last: %d -> %d\n",
> +                        __func__, dvfsrc_read(dvfsrc, DVFSRC_LEVEL),
> +                        dvfsrc_read(dvfsrc, DVFSRC_LAST));
> +               goto out;
> +       }
> +
> +       val = get_cur_performance_level(dvfsrc);
> +       if (val < highest) {
> +               dev_err(dvfsrc->dev, "current: %d < hightest: %x\n",
> +                       highest, val);
> +       }
> +out:
> +       mutex_unlock(&dvfsrc->lock);
> +
> +       return 0;
> +}
> +
> +static void pstate_notifier_register(struct mtk_dvfsrc *dvfsrc)
> +{
> +       dvfsrc->scpsys_notifier.notifier_call = dvfsrc_set_performace;
> +       register_scpsys_notifier(&dvfsrc->scpsys_notifier);
> +}
> +
> +static void pm_qos_notifier_register(struct mtk_dvfsrc *dvfsrc)
> +{
> +       dvfsrc->qos_notifier.notifier_call = pm_qos_memory_bw_notify;
> +       pm_qos_add_notifier(PM_QOS_MEMORY_BANDWIDTH, &dvfsrc->qos_notifier);
> +}
> +
> +static irqreturn_t mtk_dvfsrc_interrupt(int irq, void *dev_id)
> +{
> +       u32 val;
> +       struct mtk_dvfsrc *dvfsrc = dev_id;
> +
> +       val = dvfsrc_read(dvfsrc, DVFSRC_INT);
> +       dvfsrc_write(dvfsrc, DVFSRC_INT_CLR, val);
> +       dvfsrc_write(dvfsrc, DVFSRC_INT_CLR, 0x0);
> +       if (val & DVFSRC_IRQ_TIMEOUT_EN)
> +               dev_warn(dvfsrc->dev, "timeout at spm = %x", val);
> +

Do you need to handle the irq at all? It looks like you are cleaning up
something and then complaining if there's a timeout, but otherwise
nothing goes on so perhaps the irq can just be ignored and nobody will
be the wiser?

> +       return IRQ_HANDLED;
> +}
> +
> +static int mtk_dvfsrc_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       struct mtk_dvfsrc *dvfsrc;
> +       int ret;
> +
> +       dvfsrc = devm_kzalloc(&pdev->dev, sizeof(*dvfsrc), GFP_KERNEL);
> +       if (!dvfsrc)
> +               return -ENOMEM;
> +
> +       dvfsrc->dvd = of_device_get_match_data(&pdev->dev);
> +       dvfsrc->dev = &pdev->dev;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       dvfsrc->regs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(dvfsrc->regs))
> +               return PTR_ERR(dvfsrc->regs);
> +
> +       dvfsrc->clk_dvfsrc = devm_clk_get(dvfsrc->dev, "dvfsrc");
> +       if (IS_ERR(dvfsrc->clk_dvfsrc)) {
> +               dev_err(dvfsrc->dev, "failed to get clock: %ld\n",
> +                       PTR_ERR(dvfsrc->clk_dvfsrc));
> +               return PTR_ERR(dvfsrc->clk_dvfsrc);
> +       }
> +
> +       ret = clk_prepare_enable(dvfsrc->clk_dvfsrc);
> +       if (ret)
> +               return ret;
> +
> +       ret = of_property_read_u32(dvfsrc->dev->of_node, "dram_type",
> +                                  &dvfsrc->dram_type);
> +       if (ret) {
> +               dev_err(dvfsrc->dev, "failed to get dram_type: %d\n", ret);
> +               clk_disable_unprepare(dvfsrc->clk_dvfsrc);

Why do you need to enable the clk before reading a DT property? Do that
first and then enable the clk so you don't have to unwind it here?

> +               return ret;
> +       }
> +
> +       dvfsrc->irq = platform_get_irq(pdev, 0);
> +       ret = request_irq(dvfsrc->irq, mtk_dvfsrc_interrupt
> +               , IRQF_TRIGGER_HIGH, "dvfsrc", dvfsrc);

Nitpick: This is oddly placed comma.

> +       if (ret)
> +               dev_dbg(dvfsrc->dev, "interrupt not use\n");
> +
> +       mutex_init(&dvfsrc->lock);
> +       if (dvfsrc->dvd->init_soc)
> +               dvfsrc->dvd->init_soc(dvfsrc);
> +
> +       pstate_notifier_register(dvfsrc);
> +       pm_qos_notifier_register(dvfsrc);
> +       platform_set_drvdata(pdev, dvfsrc);

Probably should assign the platform data before anything can use it,
including notifiers?

> +
> +       return 0;
> +}
> +
> +static const struct dvfsrc_opp dvfsrc_opp_mt8183_lp4[] = {
> +       {0, 0}, {1, 0}, {1, 1}, {1, 2},
> +};
> +
> +static const struct dvfsrc_opp dvfsrc_opp_mt8183_1p3[] = {
> +       {0, 0}, {0, 1}, {1, 1}, {1, 2},
> +};
> +
> +static const struct dvfsrc_opp *dvfsrc_opp_mt8183[] = {
> +       [MT8183_DVFSRC_OPP_LP4] = dvfsrc_opp_mt8183_lp4,
> +       [MT8183_DVFSRC_OPP_LP4X] = dvfsrc_opp_mt8183_1p3,
> +       [MT8183_DVFSRC_OPP_LP3] = dvfsrc_opp_mt8183_1p3,
> +};
> +
> +static struct dvfsrc_domain dvfsrc_domains_mt8183[] = {
> +       {MT8183_POWER_DOMAIN_MFG_ASYNC, 0},

Nitpick: Put a space around { and }

> +       {MT8183_POWER_DOMAIN_MFG, 0},
> +       {MT8183_POWER_DOMAIN_CAM, 0},
> +       {MT8183_POWER_DOMAIN_DISP, 0},
> +       {MT8183_POWER_DOMAIN_ISP, 0},
> +       {MT8183_POWER_DOMAIN_VDEC, 0},
> +       {MT8183_POWER_DOMAIN_VENC, 0},
> +};
> +
> +static const struct dvfsrc_soc_data mt8183_data = {
> +       .opps = dvfsrc_opp_mt8183,
> +       .num_opp = ARRAY_SIZE(dvfsrc_opp_mt8183_lp4),
> +       .regs = mt8183_regs,
> +       .domains = dvfsrc_domains_mt8183,
> +       .num_domains = ARRAY_SIZE(dvfsrc_domains_mt8183),
> +       .init_soc = mtk_dvfsrc_mt8183_init,
> +       .get_target_level = mt8183_get_target_level,
> +       .get_current_level = mt8183_get_current_level,
> +       .dram_sft = 0,
> +       .vcore_sft = 2,
> +};
> +
> +static int mtk_dvfsrc_remove(struct platform_device *pdev)
> +{
> +       return 0;
> +}

You can just leave it out if it does nothing.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
