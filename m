Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:21:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D718120855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hqp7KBaY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyYfHjiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D718120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A6ZCJzw7gwiHqQMpYUpgJMck0iflhxwI024B/gzd4Uo=; b=hqp7KBaYH63/Im
	vUybUxBsv9TPdGjHo5DGOyxlvrgmZAJKigVv2xYaZoqO7AU3RDhaQx3VFM54UCudFJcSowlSa1mb4
	deOBB7hZamO3pL/94t2r6PG2pQ4CTuOXtu+Gq0oK5IPhED0HsRePG5LFJ4XB8THfI6Vl6/pr5ePgG
	ajBAHAL95pBiewFMWw8RjACiGBi2YaOjf7js6/c65bhsZktik6PLXzXMDxMndXTdp4PuVXfvvmkGR
	utl7L7HBtXxOtYDuT8LOJKGO4hnDSEP2DkZcLHjkQL59OsJGymaBFoEmkzzlML0ccIoTj3Z/6K1XT
	sRVbfVoUsETzDwQnlhmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkG1z-0004BD-FE; Thu, 17 Jan 2019 22:20:59 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkG1v-0004Aq-PL
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 22:20:57 +0000
Received: by mail-wm1-x341.google.com with SMTP id d15so2730430wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 14:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UF8iRbEUsqBp0oTF+nxcFGs7DS34F6tG7ACBFlq1xxo=;
 b=XyYfHjiQ9lnr/XEVKDuLmOTJbrpMhChd1vnPcbkqFDPEldh0Nr0BjR3j90u8NeCxbj
 Rnf9wIhygtmvMEe4uPLVfk5DMeMbWQNAveZnfhyGAXZKbfAPo00LWe6e5xqRQlg3rk69
 /luTHolLoTaxeMLqQ0ggIYrDAKqT4J0dzy8+5kPtd0BZgPQc5DinEJlDQ8NGJS4y3/CZ
 93NnSEU+fdXny24JD4+pszL3vvD+H/rPq9vBH5mBjXCICQA1pZwUr+/wK8CmtBBb3yAI
 d7Ux1Xai9PiUQIsUFypyxq9jIhYaAIxuZiG1qQKfsMoThECJirMa7DVaDGASYbUaHGH2
 PMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UF8iRbEUsqBp0oTF+nxcFGs7DS34F6tG7ACBFlq1xxo=;
 b=fzOmnm8VTlmVIjwsqAxAomiPsL5YAcRLcJNz3WdH4vATOYQQ8UlrhFm1vrlXQTGFBO
 /bH862j9J/Wr3PCCm/m+GUnOPgsSOE6rjMGyJS94uG0t9Ipg2LIoHnYadX1ik1VvwHX7
 gVdYANq3hcdFmDi05RWfvdw5D5eoGinT9itj1XAoxQBgQIwvpKBB+O8nIAPhew+37T7W
 TeQmMmEucPC5jPrWXr5viyOhc7s5+vlN+gfbC36vCfiD6wma6yTsTBODr0T/vakcXOEH
 BWt33HxJsXIvu5dJuXJql7KnKUyRArZOSFVppKfuOMoj+B6jpGXbNvmc2LCHBViMFB8i
 Fu+w==
X-Gm-Message-State: AJcUukfj8d8CepFHP3OnEwdpT2rWlwWpyY8nDR8Hj6op4obWNmN7kF4l
 NSCwsU/9IkXUW72SWXU1MPziVp9KqOaDnx8R0VKJCen9
X-Google-Smtp-Source: ALg8bN5tVl6LDZjgovWJDI1z77BzV/TAUOvTfZtSMi1dU0NqM+Gb4egyCQVR3t+MmYJEVw22grMnpfXhr1jydrQ2O6k=
X-Received: by 2002:a1c:760c:: with SMTP id r12mr12662014wmc.127.1547763653775; 
 Thu, 17 Jan 2019 14:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
 <20181220010700.8598-2-andrew.smirnov@gmail.com>
 <1547745380.4009.18.camel@pengutronix.de>
In-Reply-To: <1547745380.4009.18.camel@pengutronix.de>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 17 Jan 2019 14:20:42 -0800
Message-ID: <CAHQ1cqHH=pg9QON-PZhr+DDz_JWOUYkzxwcb+xdWvnmB5US8+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] reset: imx7: Add plubming to support multiple IP
 variants
To: Philipp Zabel <p.zabel@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_142055_826368_D5E10F7D 
X-CRM114-Status: GOOD (  18.65  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 9:16 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Wed, 2018-12-19 at 17:06 -0800, Andrey Smirnov wrote:
> > In order to enable supporting i.MX8MQ with this driver, convert it to
> > expect variant specific bits to be passed via driver data.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/reset/reset-imx7.c | 62 +++++++++++++++++++++++++++-----------
> >  1 file changed, 45 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> > index 77911fa8f31d..3a36d5863891 100644
> > --- a/drivers/reset/reset-imx7.c
> > +++ b/drivers/reset/reset-imx7.c
> > @@ -17,14 +17,29 @@
> >
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/mod_devicetable.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reset-controller.h>
> >  #include <linux/regmap.h>
> >  #include <dt-bindings/reset/imx7-reset.h>
> >
> > +struct imx7_src_signal {
> > +     unsigned int offset, bit;
> > +};
> > +
> > +struct imx7_src;
> > +
> > +struct imx7_src_variant {
> > +     const struct imx7_src_signal *signals;
> > +     unsigned int signals_num;
> > +     unsigned int (*prepare)(struct imx7_src *imx7src, unsigned long id,
> > +                             bool assert);
>
> Instead of adding a function pointer indirection, I'd prefer separate
> imx7_reset_ops and imx8m_reset_ops set by the variant, see below.
>
> > +};
> > +
> >  struct imx7_src {
> >       struct reset_controller_dev rcdev;
> >       struct regmap *regmap;
> > +     const struct imx7_src_variant *variant;
>
> This could then replaced with a direct pointer to the respective signals
> array.
>
> >  };
> >
> >  enum imx7_src_registers {
> > @@ -39,10 +54,6 @@ enum imx7_src_registers {
> >       SRC_DDRC_RCR            = 0x1000,
> >  };
> >
> > -struct imx7_src_signal {
> > -     unsigned int offset, bit;
> > -};
> > -
> >  static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
> >       [IMX7_RESET_A7_CORE_POR_RESET0] = { SRC_A7RCR0, BIT(0) },
> >       [IMX7_RESET_A7_CORE_POR_RESET1] = { SRC_A7RCR0, BIT(1) },
> > @@ -72,17 +83,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
> >       [IMX7_RESET_DDRC_CORE_RST]      = { SRC_DDRC_RCR, BIT(1) },
> >  };
> >
> > -static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
> > +static unsigned int
> > +imx7_src_prepare(struct imx7_src *imx7src, unsigned long id, bool assert)
> >  {
> > -     return container_of(rcdev, struct imx7_src, rcdev);
> > -}
> > -
> > -static int imx7_reset_set(struct reset_controller_dev *rcdev,
> > -                       unsigned long id, bool assert)
> > -{
> > -     struct imx7_src *imx7src = to_imx7_src(rcdev);
> > -     const struct imx7_src_signal *signal = &imx7_src_signals[id];
> > -     unsigned int value = assert ? signal->bit : 0;
> > +     const unsigned int bit = imx7src->variant->signals[id].bit;
> > +     unsigned int value = assert ? bit : 0;
> >
> >       switch (id) {
> >       case IMX7_RESET_PCIEPHY:
> > @@ -95,10 +100,32 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
> >               break;
> >
> >       case IMX7_RESET_PCIE_CTRL_APPS_EN:
> > -             value = (assert) ? 0 : signal->bit;
> > +             value = assert ? 0 : bit;
> >               break;
> >       }
> >
> > +     return value;
> > +}
>
> Instead of having a common imx7_reset_set and then calling the custom
> .prepare() through a function pointer, I'd suggest to have custom
> imx7_reset_set and imx8m_reset_set functions that contain the code from
> .prepare() and then call a common function to do the actual register
> access.
>

OK, makes sense, will give it a spin in v5.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
