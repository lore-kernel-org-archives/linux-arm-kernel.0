Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92542C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:15:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6501321924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lN/F+Cmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6501321924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NZsDc6uAha+7lfs0jycBkEs/AUgNl+I+pSmlM85QMa0=; b=lN/F+CmdEonfO/
	g6FfCzpKU5A86fWpxVWfolLMe8BndV3VjuKosxVScQdryENs7bfr423gLrSmmQZ/Jac0Uh+Lr42yC
	K85wCDzsg0TNF+Iu4Tj6um0FCWzo5tb5mBOuuJ2m0XOo51tSxfewLTpajszb2PLvtpP81ajRxTwHs
	wAAmQ/l+f2IobgMVYoxtlrUuMCrXpB/3B9wysxjT/KutZWy9RsNb2H5xPPM+mF5GnlCtcuIIfD96r
	6QTavzRlKH54He/Ka96owFGk5aVndnw0PCyjknibqamRSDdHlMEZBBLh2SteuU/WmnSGV3qYWrg/j
	M1Ss6A+BSd90jhNHZTjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaOOu-0001Yx-MB; Fri, 21 Dec 2018 17:15:52 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaOOq-0001Xp-H9
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 17:15:50 +0000
Received: by mail-ed1-f66.google.com with SMTP id o10so5224792edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 09:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8KHM75/LxO6Dbrl+LQVIoiBh2oQpzco7U1Zt/XhGp8E=;
 b=oZ4k+86POvyOw3u9SQiIwQLmPvBKzKHN1VUPKRfN2sdMHztCvGQEB8CS5aDkdYna0x
 KiaRMHxhI9U6Ihv9/hpVQXTu/hzZnWOhV1h36eQF+XymrGqIR2a8EeQ22jdszle6jdL8
 mAfbZ21PDKLzr5rTIrO6N2BRoLiWzbE62eWuWw1e441mDaWh9/ZuyPI4u8/VRnw6iCh/
 nF/jLCUYSWxWbvFrNVJFxfbXXSQTiQKbEwU6F+3osVXP0WskZ1QCI8RuVLfOPLg3yRqO
 0cucy78FtwT3b8z8ITACBdb2KQcdbHcKHIu+m3aSQ6fDBHSzOcUqfCRHyOtD8UQna23n
 OQaw==
X-Gm-Message-State: AA+aEWbAT5j5usGKOB5p5m9wfSnNjds0dLmH6QJNrHVDcvvZt7QUUZFu
 9UgbXsOQ8RIHz+DG5wV/x3wKkGHYdrk=
X-Google-Smtp-Source: AFSGD/Vx0H9/S2Vr9UI3o4kI3tZMYCca6cabB58tznE2VWid518qNqk4iT/DENLBshKM1PrxIq1UwQ==
X-Received: by 2002:a50:a5b8:: with SMTP id a53mr3081411edc.199.1545412536786; 
 Fri, 21 Dec 2018 09:15:36 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com.
 [209.85.221.54])
 by smtp.gmail.com with ESMTPSA id a11sm7232615edc.28.2018.12.21.09.15.35
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 09:15:36 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id v13so6024074wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 09:15:35 -0800 (PST)
X-Received: by 2002:adf:b608:: with SMTP id f8mr3356702wre.120.1545412535646; 
 Fri, 21 Dec 2018 09:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-4-codekipper@gmail.com>
 <CAGb2v67LyDW6kmDrahzLYsY7q9mSJimrZ=jMO3PrPQ=mcxy0qw@mail.gmail.com>
In-Reply-To: <CAGb2v67LyDW6kmDrahzLYsY7q9mSJimrZ=jMO3PrPQ=mcxy0qw@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 22 Dec 2018 01:15:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v652h5hpujBxF5r3_g_tj2cOjULkUBhazi_5Xd6kvC2ZPw@mail.gmail.com>
Message-ID: <CAGb2v652h5hpujBxF5r3_g_tj2cOjULkUBhazi_5Xd6kvC2ZPw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
To: Code Kipper <codekipper@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_091548_561778_AD32BBFC 
X-CRM114-Status: GOOD (  23.43  )
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "Andrea Venturi \(pers\)" <be17068@iperbole.bo.it>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 22, 2018 at 12:48 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
> >
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Extend the functionality of the driver to include support of 20 and
> > 24 bits per sample for the earlier SoCs.
> >
> > Newer SoCs can also handle 32bit samples.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 41 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 80bf29e0cc86..adb988ae9ac5 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -399,6 +399,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >         case 16:
> >                 width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> >                 break;
> > +       case 20:
> > +       case 24:
> > +       case 32:
> > +               width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +               break;
> >         default:
> >                 dev_err(dai->dev, "Unsupported physical sample width: %d\n",
> >                         params_physical_width(params));
> > @@ -411,7 +416,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >                 sr = 0;
> >                 wss = 0;
> >                 break;
> > -
> > +       case 20:
> > +               sr = 1;
> > +               wss = 1;
> > +               break;
> > +       case 24:
> > +               sr = 2;
> > +               wss = 2;
> > +               break;
> > +       case 32:
> > +               sr = 4;
> > +               wss = 4;
> > +               break;
> >         default:
> >                 dev_err(dai->dev, "Unsupported sample width: %d\n",
> >                         params_width(params));
> > @@ -687,6 +703,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> >         return 0;
> >  }
> >
> > +#define SUN4I_FORMATS  (SNDRV_PCM_FMTBIT_S16_LE | \
> > +                        SNDRV_PCM_FMTBIT_S20_3LE | \
> > +                        SNDRV_PCM_FMTBIT_S24_LE)
>
> IIRC SNDRV_PCM_FMTBIT_S24_LE and SNDRV_PCM_FMTBIT_S32_LE with .sig_bits = 24
> are different things, in regards to how the sample is aligned in a 4 byte
> space. Have you checked that things actually work as expected? This was
> something that did not work using SNDRV_PCM_FMTBIT_S24_LE on sun4i-codec.

OK. I see the I2S driver is using FIFO mode 1, which expects the sample
to be in the lower portion of the 4 bytes. However it looks like you would
want SNDRV_PCM_FMTBIT_S20_LE (20 bits LSB justified in 4 bytes) instead of
SNDRV_PCM_FMTBIT_S20_3LE (20 bits LSB justified in 3 bytes).

ChenYu


> > +
> > +#define SUN8I_FORMATS  (SUN4I_FORMATS | \
> > +                        SNDRV_PCM_FMTBIT_S32_LE)
> > +
> >  static struct snd_soc_dai_driver sun4i_i2s_dai = {
> >         .probe = sun4i_i2s_dai_probe,
> >         .capture = {
> > @@ -694,14 +717,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
> >                 .channels_min = 2,
> >                 .channels_max = 2,
> >                 .rates = SNDRV_PCM_RATE_8000_192000,
> > -               .formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +               .formats = SUN4I_FORMATS,
> >         },
> >         .playback = {
> >                 .stream_name = "Playback",
> >                 .channels_min = 2,
> >                 .channels_max = 2,
> >                 .rates = SNDRV_PCM_RATE_8000_192000,
> > -               .formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +               .formats = SUN4I_FORMATS,
> >         },
> >         .ops = &sun4i_i2s_dai_ops,
> >         .symmetric_rates = 1,
> > @@ -1106,6 +1129,18 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
> >         i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
> >         i2s->capture_dma_data.maxburst = 8;
> >
> > +       soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
> > +                              sizeof(*soc_dai), GFP_KERNEL);
> > +       if (!soc_dai) {
> > +               ret = -ENOMEM;
> > +               goto err_pm_disable;
> > +       }
> > +
> > +       if (i2s->variant->has_fmt_set_lrck_period) {
>
> This condition deserves a comment, particularly as to why you use it
> in place of having a separate quirk field to represent 32 bit support.
>
> Regards
> ChenYu
>
> > +               soc_dai->playback.formats = SUN8I_FORMATS;
> > +               soc_dai->capture.formats = SUN8I_FORMATS;
> > +       }
> > +
> >         pm_runtime_enable(&pdev->dev);
> >         if (!pm_runtime_enabled(&pdev->dev)) {
> >                 ret = sun4i_i2s_runtime_resume(&pdev->dev);
> > --
> > 2.20.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
