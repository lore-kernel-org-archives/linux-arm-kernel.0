Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:21:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C02205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jY9hp/GW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gDVU+rXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C02205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gXMuFV1Dv4yEpfQ9LrMI1jOB0EQEHfnSHBfK8Do3ISo=; b=jY9hp/GWHwnjPE
	6Yt5vOQg9yQIN3saxrsfYdpdhsl2W1XIoNKgAiD8xKa4Go3biAvNfaZW+BHD2pY13p/m/GBCIdQfH
	jsau5OG3dqcWtIUV4fMuinDp/JVCO93rUTHnNn+keHEnsp3QL7u712FWl2syMK6pu+AjXiwVJjuWT
	qxENGsyTDielltd5eXFyx+BnKbN5VOxeFYihD4w/fsYraYIIF7XcmnWiEpoICSSBTKyNezIwAHfPE
	aEBFJTSoKHIjjwR2fQ1Fhxsh9ZJ8LkccOCsox3kkh1EcWvxMkz2pgtLjlLVX5dPTa6sKWEk3SM5kC
	ujA1xxdAKND3c7QkdFTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfJnJ-0008Tf-QD; Fri, 04 Jan 2019 07:21:26 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfJnF-0008SG-Gw
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 07:21:23 +0000
Received: by mail-qt1-x841.google.com with SMTP id l11so39561304qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 23:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+T1zAqzsjsRCsWOGvgNAYmKjzogu0XN9kgSsZf8+U7U=;
 b=gDVU+rXky/kXBWaN88pyA39nTK63YJWyefaj9NMBGWURX5ODdeujeU20uq0qXGtKNt
 aKDRERNmq5AW1JYCHZH+07WnRTb+I4hC/mx4nPfkA6HhV+DPh/tFVVCbQ/HrxsCGa6q+
 RsmVMjnXK2JUXTny+ib8xHKzG9Kq1xbtgrnUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+T1zAqzsjsRCsWOGvgNAYmKjzogu0XN9kgSsZf8+U7U=;
 b=KDr4/+KZvi+TLCRHJirb0NVZhgSEr4n7QfnBaFbh5XQaAfu3nBFvt9m7kmuuG0yzs0
 C/KbfbCZcgqhtfXx4GxFqsRKnGefO34WtrPe65Mu2mK8FpVwWJbu61NoUwpvix2+O9zT
 X7XZEw3kQ0GOZgtahVsAFZsBh1nHYVdcaZX0Vf61XLOQVIcwbyw7KrIXI7mylPnET4Wv
 P5rj7gkYU/W2d6xTg9LQxr0uCGVZxmBSptvR0w3Rij2vYqUrsvOU9eRjHCsHXJnD2B2q
 OWLTqGunOtjrZPA4FgzZUrKf0lMKjDNENMccUSxsqiT+R4WSuzn6qXScL3yIUp7bQAky
 7apQ==
X-Gm-Message-State: AA+aEWYw/L4HnxIhqJYKT3Cv+JLiiWRAveJfQ79VxL3WFXmrDH0LFCNL
 F3AfmUauRetR6RbLjGEYecPmvcSviLN5UKwCn/pxng==
X-Google-Smtp-Source: AFSGD/U3I21lq6IKl4aI5P9jOJSCjGTeJMe3df3iGyKG2HN5LKk339V9+IjAbbW94RVP5COIkykBhrM0zUi0UsY32zQ=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr49651800qts.144.1546586479926; 
 Thu, 03 Jan 2019 23:21:19 -0800 (PST)
MIME-Version: 1.0
References: <1546436644-19234-1-git-send-email-henryc.chen@mediatek.com>
 <1546436644-19234-4-git-send-email-henryc.chen@mediatek.com>
 <CANMq1KCNSRv36L7mFNDEwFEdHm+q8cYz7GmfQZJQSGboe36vKQ@mail.gmail.com>
 <1546524988.6818.54.camel@mtksdaap41>
In-Reply-To: <1546524988.6818.54.camel@mtksdaap41>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Fri, 4 Jan 2019 15:21:09 +0800
Message-ID: <CANMq1KBm1Ggaqhd3S3dhkh5Z+YqqD1B5uN48bN2y1_Oq=_u4rQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] soc: mediatek: add support for the performance
 state
To: Henry Chen <henryc.chen@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_232121_560323_43BABC15 
X-CRM114-Status: GOOD (  22.03  )
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
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 3, 2019 at 10:16 PM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> On Thu, 2019-01-03 at 09:48 +0800, Nicolas Boichat wrote:
> > On Wed, Jan 2, 2019 at 10:01 PM Henry Chen <henryc.chen@mediatek.com> wrote:
> > >
> > > Support power domain performance state, add header file for scp event.
> > >
> > > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > > ---
> > >  drivers/soc/mediatek/mtk-scpsys.c | 60 +++++++++++++++++++++++++++++++++++++++
> > >  drivers/soc/mediatek/mtk-scpsys.h | 22 ++++++++++++++
> > >  2 files changed, 82 insertions(+)
> > >  create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
> > >
> > > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > > index 58d84fe..90102ae 100644
> > > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > > @@ -11,7 +11,9 @@
> > >  #include <linux/of_device.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_domain.h>
> > > +#include <linux/pm_opp.h>
> > >  #include <linux/regulator/consumer.h>
> > > +#include <linux/slab.h>
> > >  #include <linux/soc/mediatek/infracfg.h>
> > >  #include <linux/soc/mediatek/scpsys-ext.h>
> > >
> > > @@ -22,6 +24,7 @@
> > >  #include <dt-bindings/power/mt7623a-power.h>
> > >  #include <dt-bindings/power/mt8173-power.h>
> > >  #include <dt-bindings/power/mt8183-power.h>
> > > +#include "mtk-scpsys.h"
> > >
> > >  #define MTK_POLL_DELAY_US   10
> > >  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> > > @@ -187,6 +190,18 @@ struct scp_soc_data {
> > >         bool bus_prot_reg_update;
> > >  };
> > >
> > > +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
> > > +
> > > +int register_scpsys_notifier(struct notifier_block *nb)
> > > +{
> > > +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
> > > +}
> > > +
> > > +int unregister_scpsys_notifier(struct notifier_block *nb)
> > > +{
> > > +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
> > > +}
> > > +
> > >  static int scpsys_domain_is_on(struct scp_domain *scpd)
> > >  {
> > >         struct scp *scp = scpd->scp;
> > > @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
> > >                 clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> > >  }
> > >
> > > +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> > > +                                 unsigned int state)
> > > +{
> > > +       int i;
> > > +       struct scp_domain *scpd =
> > > +               container_of(genpd, struct scp_domain, genpd);
> >
> > nit: This (just) fits in 80 chars.
> Try again and get 81 chars :)

Really not a big deal, but I did check and I think it fits ,-)

        struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
01234567890123456789012345678901234567890123456789012345678901234567890123456789

> >
> > > +       struct scp_event_data scpe;
> > > +       struct scp *scp = scpd->scp;
> > > +       struct genpd_onecell_data *pd_data = &scp->pd_data;
> > > +
> > > +       for (i = 0; i < pd_data->num_domains; i++) {
> > > +               if (genpd == pd_data->domains[i]) {
> > > +                       dev_dbg(scp->dev, "%d. %s = %d\n",
> > > +                               i, genpd->name, state);
> > > +                       break;
> > > +               }
> > > +       }
> >
> > Do we need a sanity check here, if i == pd_data->num_domains?
> Oops. It needed, thanks for remind.
> >
> > > +
> > > +       scpe.event_type = MTK_SCPSYS_PSTATE;
> > > +       scpe.genpd = genpd;
> > > +       scpe.domain_id = i;
> > > +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
> > > +                                          struct dev_pm_opp *opp)
> > > +{
> > > +       struct device_node *np;
> > > +       unsigned int state;
> > > +
> > > +       np = dev_pm_opp_get_of_node(opp);
> > > +
> > > +       if (of_property_read_u32(np, "mtk,level", &state))
> > > +               return 0;
> > > +
> > > +       of_node_put(np);
> > > +
> > > +       return state;
> > > +}
> > > +
> > >  static struct scp *init_scp(struct platform_device *pdev,
> > >                         const struct scp_domain_data *scp_domain_data, int num,
> > >                         const struct scp_ctrl_reg *scp_ctrl_reg,
> > > @@ -659,6 +716,9 @@ static struct scp *init_scp(struct platform_device *pdev,
> > >                 genpd->power_on = scpsys_power_on;
> > >                 if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
> > >                         genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> > > +
> > > +               genpd->set_performance_state = mtk_pd_set_performance;
> > > +               genpd->opp_to_performance_state = mtk_pd_get_performance;
> > >         }
> > >
> > >         return scp;
> > > diff --git a/drivers/soc/mediatek/mtk-scpsys.h b/drivers/soc/mediatek/mtk-scpsys.h
> > > new file mode 100644
> > > index 0000000..c1e8325
> > > --- /dev/null
> > > +++ b/drivers/soc/mediatek/mtk-scpsys.h
> > > @@ -0,0 +1,22 @@
> > > +/* SPDX-License-Identifier: GPL-2.0
> > > + *
> > > + * Copyright (c) 2018 MediaTek Inc.
> > > + */
> > > +
> > > +#ifndef __MTK_SCPSYS_H__
> > > +#define __MTK_SCPSYS_H__
> > > +
> > > +struct scp_event_data {
> > > +       int event_type;
> > > +       int domain_id;
> > > +       struct generic_pm_domain *genpd;
> > > +};
> > > +
> > > +enum scp_event_type {
> > > +       MTK_SCPSYS_PSTATE,
> > > +};
> > > +
> > > +int register_scpsys_notifier(struct notifier_block *nb);
> > > +int unregister_scpsys_notifier(struct notifier_block *nb);
> > > +
> > > +#endif /* __MTK_SCPSYS_H__ */
> > > --
> > > 1.9.1
> > >
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
