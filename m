Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9107C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:17:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05F52171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mJrjLcQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05F52171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HId0SRd4wVOxtPynZzKaXqWa474eVGQXYg+MdzWW7nM=; b=mJrjLcQ8BpAIdt
	R/Ln5/aBUIXhpiQwfWllOf0+Kp+vuTvV5Umz7WujTIVG4gvRw9qB+8AQq3clBJpiFGq18+ZdeqMqy
	dZUDHuzgHta4rxNGggBQfv2MTnAcEFMStFMMC3jr9ljs7mJiSl8LLhE4Izxjj9VqADdpPEdmdmAHg
	DczpWFcP+a+U0InogMOIjDKd5T08gkAaYJ92LbjhNf8Ugs3+S6dbfSN6b0czXrBNNiwC01FGBtIwa
	z5QWOwWsG22doLrX03FpICXHy0VYHdaCarHBXrkI7omnxYT2DSPJpDmCx2iyXxNE58FzRhylCn1/Y
	zoBUC2RcLJSlQ2nJ43Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gauGG-0000zW-Mo; Sun, 23 Dec 2018 03:17:04 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gauGC-0000yy-Gt
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 03:17:02 +0000
Received: by mail-ed1-f66.google.com with SMTP id o10so7759447edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 22 Dec 2018 19:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gJ1a/RovdMq+kGU6VszUmQBpA6rs5fOk8P6blwkOLPE=;
 b=HN8dFP3tpZIVx9zJqWf3odI4ExoR9Z0sjcQVG1lArhGaZ6APs+TgMZxRL1FuMyXwpr
 N019YBU7B18Xv8POIMMoHIaGaJGP1SnwbR8nyvIEP4NOY59gaCGaeW72AckLP2pbCxb+
 XLty8MEr0mJFcfN6YlZLSpSE3iVONYq4cHnWCZbhg+BtRTHwhhGIIepzA7z1M0SoZTaF
 gRtKQjJ16pWQ54DGudInt59bFD9iXzKQW1IhPwoM6EE3tMVXW9B+g4qGeCFW4L6ja0RV
 UvSIZeZnL9AnNiLFhR/uvOTRwFBjOlkHBupDUWPjJHhfqwbDC6+FgmpyJqw5BewEg7rl
 hB5A==
X-Gm-Message-State: AA+aEWaYijNeC3nWFqeC9e/mKvbw7WY1QXnhqubBkZVZW4ASICIayIiR
 rA1KmmAUV5OLiZ5t360clRbqQEfXYEk=
X-Google-Smtp-Source: AFSGD/XsJCazLF0ERUpx3xb/+BT4EEBlPuZrcgikt2sFSekx30zRhXdfSmJULwEkCoc0wHFdYC+VnA==
X-Received: by 2002:a50:a086:: with SMTP id 6mr6599041edo.88.1545535004940;
 Sat, 22 Dec 2018 19:16:44 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com.
 [209.85.221.48])
 by smtp.gmail.com with ESMTPSA id x30sm8213135edd.30.2018.12.22.19.16.43
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 22 Dec 2018 19:16:43 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id t6so8841157wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 22 Dec 2018 19:16:43 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr7510916wrs.44.1545535003147; 
 Sat, 22 Dec 2018 19:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
 <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
In-Reply-To: <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 23 Dec 2018 11:16:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
Message-ID: <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap
 settings
To: Jonas Karlman <jonas@kwiboo.se>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_191700_563735_2ABFC384 
X-CRM114-Status: GOOD (  34.49  )
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
 "Andrea Venturi \(pers\)" <be17068@iperbole.bo.it>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 23, 2018 at 6:12 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2018-12-21 17:44, Chen-Yu Tsai wrote:
> > On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
> >> From: Marcus Cooper <codekipper@gmail.com>
> >>
> >> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> >> to reflect this.
> >>
> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >> ---
> >>  sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
> >>  1 file changed, 9 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> >> index d5ec1a20499d..64d073cb2aee 100644
> >> --- a/sound/soc/sunxi/sun4i-i2s.c
> >> +++ b/sound/soc/sunxi/sun4i-i2s.c
> >> @@ -548,9 +548,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> >>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
> >>  {
> >>         /* Flush RX FIFO */
> >> +       regcache_cache_bypass(i2s->regmap, true);
> >>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> >> +       regcache_cache_bypass(i2s->regmap, false);
> > IIRC the flush cache bit is self-clearing. So you likely want to mark
> > this register as volatile. If it is marked as volatile, then all access
> > to that register bypasses the cache, so the regcache_cache_bypass calls
> > are unneeded.
>
> I helped test this together with Marcus and when I tested with this
> register marked
> as volatile audio started to stutter, still unclear why audio starts to
> stutter.

Sounds like we're missing something. However the only other time we
update this register is to set the FIFO mode.

> Without this cache bypass the flush TX/RX bits gets cached and flush
> happens unexpectedly
> resulting in multi channel audio getting mapped to wrong speaker.

This sounds like the flush is happening after DMA transfers and/or I2S
operations have started, disrupting the order of the audio samples. I
think that might be the case since the regcache is synced sequentially,
and the FIFO control register is after the enable bits. That would imply
that the device is taken out of runtime suspend after the .start_capture
or .start_playback callbacks. Not sure if that's the case, but that would
mean the bus clocks are still off at this point, and bypassing the cache
and updating the bits is basically moot.

I think there's something else happening here, but we need to figure it
out instead of papering over it with something that "just works" but
we don't know why it works.

> Other ASoC codecs and fsl_spdif.c seems to use similar cache bypass for
> reset/flush.

fsl_spdif.c does it when forcing a soft reset, which would reset all the
registers. It then does a cache sync, restoring any values set up. That's
not what we're doing here.

> >
> > However, looking at the code, the write would seem to be ignored if the
> > regmap is in the cache_only state. We only set this when the bus clock
> > is disabled. Under such a condition, bypassing the cache and forcing a
> > write would be unwise, as the system either drops the write, or stalls
> > altogether.
> >
> >>         /* Clear RX counter */
> >>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> >> @@ -569,9 +571,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
> >>  static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
> >>  {
> >>         /* Flush TX FIFO */
> >> +       regcache_cache_bypass(i2s->regmap, true);
> >>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> >> +       regcache_cache_bypass(i2s->regmap, false);
> >>
> >>         /* Clear TX counter */
> >>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> >> @@ -703,13 +707,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
> >>
> >>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
> >>  {
> >> -       switch (reg) {
> >> -       case SUN4I_I2S_FIFO_TX_REG:
> >> -               return false;
> >> -
> >> -       default:
> >> -               return true;
> >> -       }
> >> +       return true;
> > I don't understand why this is relevant. Do you need to read back from the TX
> > FIFO?
>
> This change was inspired by c66234cfedfc "ASoC: rockchip: i2s: fix
> playback after runtime resume" [1]
> On resume a cached sample would be written to FIFO_TX_REG unless it is
> marked volatile,
> the rockchip commit indicated that read is needed for volatile regs.
>
> [1]
> https://github.com/torvalds/linux/commit/c66234cfedfc3e6e3b62563a5f2c1562be09a35d

What about simply marking the FIFO registers as both unreadable and
unwritable, thus excluding them from the regmap? That should get rid
of any unwanted syncs. We are doing DMA transfers to/from them. Do we
need regmap access?

Either way this context should be provided in the commit log.

Regards
ChenYu

> >
> > If so, just drop the call-back altogether. If no callback is provided and no
> > rd_table is provided either, it defaults to all registers under max_register
> > (if max_register < 0) are readable.
> >
> > However this seems like it deserves to be a separate patch (where you explain
> > in the commit log why it's needed).
> >
> > Regards
> > ChenYu
> >
> >>  }
> >>
> >>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> >> @@ -728,6 +726,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >>  {
> >>         switch (reg) {
> >>         case SUN4I_I2S_FIFO_RX_REG:
> >> +       case SUN4I_I2S_FIFO_TX_REG:
> >> +       case SUN4I_I2S_FIFO_STA_REG:
> >>         case SUN4I_I2S_INT_STA_REG:
> >>         case SUN4I_I2S_RX_CNT_REG:
> >>         case SUN4I_I2S_TX_CNT_REG:
> >> @@ -738,23 +738,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >>         }
> >>  }
> >>
> >> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> >> -{
> >> -       switch (reg) {
> >> -       case SUN8I_I2S_FIFO_TX_REG:
> >> -               return false;
> >> -
> >> -       default:
> >> -               return true;
> >> -       }
> >> -}
> >> -
> >>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >>  {
> >>         if (reg == SUN8I_I2S_INT_STA_REG)
> >>                 return true;
> >>         if (reg == SUN8I_I2S_FIFO_TX_REG)
> >> -               return false;
> >> +               return true;
> >>
> >>         return sun4i_i2s_volatile_reg(dev, reg);
> >>  }
> >> @@ -809,7 +798,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
> >>         .reg_defaults   = sun8i_i2s_reg_defaults,
> >>         .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
> >>         .writeable_reg  = sun4i_i2s_wr_reg,
> >> -       .readable_reg   = sun8i_i2s_rd_reg,
> >> +       .readable_reg   = sun4i_i2s_rd_reg,
> >>         .volatile_reg   = sun8i_i2s_volatile_reg,
> >>  };
> >>
> >> --
> >> 2.20.1
> >>
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
