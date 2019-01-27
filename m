Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242D8C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:03:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF06A21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J6T4nQ2q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4QW6D+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF06A21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+gOU6EA+LNqkNYToQjveaIH255j8Hr8aheMW5J/clIY=; b=J6T4nQ2qq46ALw
	JNzE+zcsGgIAZI9MZgfHa/7w8/xkgmkb7N+78Ca+QmRNKrR/+O4Gq+GPSdfpBDqPld5LsMBqt4aoD
	0K/8vpILanuGo57iVgyliIxbPHnvMMmuZRwXBWClO6a1KSRTa6JnIR3QWYokgTqxkNV76KbdKkLlv
	XjCW8Yy044gR4sKxp5D54VT/NRvDtm36hCYEQvCQstn6oSib/AzMcyQPqTWABrWweMtLf4nB13QjT
	BofyvVDwacpGYEHSPQ+Ygt+LGSxK77FvOpEOOa+jvl5tHNzDc27Kte1BCF7rqZbkLPuWm5bumh8od
	l/cAaM5XDXKo5rtLz68Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnl1n-00037R-3q; Sun, 27 Jan 2019 14:03:15 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnl1i-00036U-Il
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 14:03:12 +0000
Received: by mail-it1-x141.google.com with SMTP id i145so16982091ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 06:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DvjaMtoCZExGiMT2FyI4koJ0UPtbXCHbovdkZaR21eY=;
 b=G4QW6D+uRzus557flxpuGp2rsJyR6ogM1bdSJq1LRTH1dcdrcrHX42d7KgcqiUtQVT
 flmZoW4bGOBvQDmfvS+B/Z19MYnP0RC1e8Ss2YxeHG8ZUpVjdcC8PJ8pw1yy3QR2hCb3
 ernizcjiehGIVShXhf7ySJu4E8YJTTRDP7LI4rurlBnBFIZSvigb6w2tflUcPIeUMpSs
 JHaZ2xDX0dvsAqAFWNU39Am4iK4/0hsq8NEnqIoE6TmluLZzzMXuw61YyZ8pVjNawrrD
 fgD7YMDK2OEQULYQzzl+cfD9AzTgWzVb/H3OOZFFbJ0pk86PzmqeuR6w0T9/FdBi+uWe
 trsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DvjaMtoCZExGiMT2FyI4koJ0UPtbXCHbovdkZaR21eY=;
 b=XAuZiJQL3YEPtGP4N4t4FYCWBrbnOFE98C1EdK259zURwFcdyHF/Qs+XrafpUL2p07
 8Psax7j4uIcxOcqsUO5peV0SrJS2WwS73E5gRZInH1SbPAXCb1JSHsxbCWhg8m6rM0rp
 3PeUmYjvQSSqMUDo+WVvzuW1VCHm1WjpjXSWanOPDtIICKYziRfvFBnI8PrDw8eGq0+9
 B8C3JLuCk8xH3UfkyaZ/fdnm9tA8rHerqvD6chbGTGqxq3MbJyKFLyMI5hRQiUfxHLC8
 CqGvIHcIsZ2kdBIbhNcA1ZZl0BVLUNnCA7vOSZ4KkbCvZfX8atDdHg/68W6c/bO1rOzV
 vysQ==
X-Gm-Message-State: AJcUukcDjaWRFF9Z+zET62rGL150QQWFJ8Hp9AmOhhdd/mkxdZ25pCRv
 zLGlE3GGk3NIRVSye67hGli1m9ThfBnSZylU5QosMI5w
X-Google-Smtp-Source: ALg8bN5iCtsmN/4SlgXENnzc/k2k8wl3zCFITXp1H4qgjh9zJXXUEOpa8+LMxDlBJqko4opDB85ofIFsGfHRrdEBOR4=
X-Received: by 2002:a24:65c8:: with SMTP id u191mr8511124itb.7.1548597788745; 
 Sun, 27 Jan 2019 06:03:08 -0800 (PST)
MIME-Version: 1.0
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
 <1548413675.28802.45.camel@pengutronix.de>
In-Reply-To: <1548413675.28802.45.camel@pengutronix.de>
From: Dong Aisheng <dongas86@gmail.com>
Date: Sun, 27 Jan 2019 22:02:57 +0800
Message-ID: <CAA+hA=SSP8eF6hikBgBqAxv29W4J2+szyvsLS2MXSMvxRv9wDw@mail.gmail.com>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_060310_674880_FA192080 
X-CRM114-Status: GOOD (  20.06  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 6:55 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> > One irqsteer channel can support up to 8 output interrupts.
> >
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/irqchip/irq-imx-irqsteer.c | 39 +++++++++++++++++++++++++++-----------
> >  1 file changed, 28 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> > index 1bebf0a..54802fa 100644
> > --- a/drivers/irqchip/irq-imx-irqsteer.c
> > +++ b/drivers/irqchip/irq-imx-irqsteer.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/spinlock.h>
> >
> > @@ -21,10 +22,13 @@
> > >  #define CHAN_MINTDIS(t)            (CTRL_STRIDE_OFF(t, 3) + 0x4)
> > >  #define CHAN_MASTRSTAT(t)  (CTRL_STRIDE_OFF(t, 3) + 0x8)
> >
> > > +#define CHAN_MAX_OUTPUT_INT        0x8
> > +
> >  struct irqsteer_data {
> > > >   void __iomem            *regs;
> > > >   struct clk              *ipg_clk;
> > > > - int                     irq;
> > > > + int                     irq[CHAN_MAX_OUTPUT_INT];
> > > > + int                     irq_count;
> > > >   raw_spinlock_t          lock;
> > > >   int                     reg_num;
> > > >   int                     channel;
> > @@ -117,7 +121,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> > >     struct device_node *np = pdev->dev.of_node;
> > >     struct irqsteer_data *data;
> > >     struct resource *res;
> > > -   int ret;
> > > +   int i, ret;
> >
> > >     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > >     if (!data)
> > @@ -130,12 +134,6 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> > >             return PTR_ERR(data->regs);
> > >     }
> >
> > > -   data->irq = platform_get_irq(pdev, 0);
> > > -   if (data->irq <= 0) {
> > > -           dev_err(&pdev->dev, "failed to get irq\n");
> > > -           return -ENODEV;
> > > -   }
> > -
> > >     data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> > >     if (IS_ERR(data->ipg_clk)) {
> > >             ret = PTR_ERR(data->ipg_clk);
> > @@ -177,8 +175,23 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
> > >             return -ENOMEM;
> > >     }
> >
> > > -   irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
> > > -                                    data);
> > +     data->irq_count = of_irq_count(np);
>
> We normally don't validate stuff that comes from the DT, but I guess it
> might be helpful to validate that the number of output irqs specified
> matches what the number of input irqs, i.e. there is one output irqs
> specified for each group of 64 inputs.
>

Sound like a good idea.
I think we can calculate the irq_count from irqs number instead of of_irq_count.
Then the following irq_of_parse_and_map() will validate them automatically.

However, i think we'd better to keep the irq_count range check as well.

> > +     if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
> > > +           clk_disable_unprepare(data->ipg_clk);
> > > +           return -EINVAL;
> > > +   }
> > +
> > > +   for (i = 0; i < data->irq_count; i++) {
> > > +           data->irq[i] = irq_of_parse_and_map(np, i);
> > > +           if (!data->irq[i]) {
> > > +                   clk_disable_unprepare(data->ipg_clk);
> > > +                   return -EINVAL;
> > > +           }
> > +
> > > +           irq_set_chained_handler_and_data(data->irq[i],
> > > +                                            imx_irqsteer_irq_handler,
> > +                                              data);
>
> We really want some data about the output irq being passed here, so we
> can cut down the number of register reads in the irq handler to the
> maximum of 2 status registers per group.
>

Will implement it and resend.

Regards
Dong Aisheng

> Regards,
> Lucas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
