Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA50C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:44:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C01021916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RrQY0iMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C01021916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rt0/O2G1tMcqPSQd1kAN9zZqIlzaChohRsiVg7XSXGQ=; b=RrQY0iMiJG2vfi
	9jugaGxQkLt1IMtCq9DOXCo1xSj2LxHMpAo8A12PVfXTRtIq3gkKtcv5dNhx818Nw6kKKHOwBfU/G
	EeMZXOHeHAF4vGw6nVXvU7Xe0mTGuX1SBCAgno7EYihbYda8jtbXDQDAYMUzD22tYrm0Vwf+Gjr82
	ot3p0kSAcyPoJJwdwHKKBvDur6kt2HlneXoOZj69RMqJRc4TGFdYnNdUCKyE5QF/8XeMtBcfeBX5z
	XqE6PKJyOB8rt1FY7uSXz8FiEyGHYgzZS8P4iL8n1H1ZARFYei3chL2KiSkAMWV5D3OuNuADhckfP
	XvSosrAgtxR5JvOYN/jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaNue-0005tm-Ej; Fri, 21 Dec 2018 16:44:36 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaNua-0005so-NS
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 16:44:34 +0000
Received: by mail-ed1-f68.google.com with SMTP id f23so5185306edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 08:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bV0KAnk3tQchKK12t/V41YVSjxMoTHWPpGkNXrDUEIk=;
 b=XmmvlHeJr6biGNCDz/d8DKJqiFDc04eJJfnyTz4z+cxGu0AodHuHeyGU97TFB9017V
 uxiryV1Bcwis3c5Rek7LYqqxE7T3EAXaxlnenJWPlSEW1cyYZ384dJkcFb0Mx8A0Wcrc
 miAhRYI120ibAN8Xd0fmFzHssnK1qtjDzX/B4+MuDtZT5JoW7OA9bNrbyTpA3dsOWA5a
 xHkMDynQD5menb8715EIXqfSeBR97L2eYNlbDXELDC0gloHeQOCrihR6BeuU51JKuwqh
 taWpNk/b6ItRVsLBJqEogiB7y9OtCpIK8M7KvOtsWDn1IzsCk4QFbUplhBwCw0CPVNLy
 hp9A==
X-Gm-Message-State: AA+aEWbRjz/iBr3YeO08Qh+v9/s3zJLeMMAIjA3nWM32GXaNRmGY+8I7
 neTqchtuPMGo3GQKwGaAKvZDqIuOFd8=
X-Google-Smtp-Source: AFSGD/XTd7mQiRKJ/maUGtS/vGFJZnv2yL/n/tzGsh7uaj+BrlgqeVaLCfWxFvo3rYqABP7zWgC63Q==
X-Received: by 2002:a17:906:f108:: with SMTP id
 gv8-v6mr2530175ejb.173.1545410659977; 
 Fri, 21 Dec 2018 08:44:19 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com.
 [209.85.128.49])
 by smtp.gmail.com with ESMTPSA id r18-v6sm3640308ejz.22.2018.12.21.08.44.19
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 08:44:19 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id y185so14615124wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 08:44:19 -0800 (PST)
X-Received: by 2002:a1c:2382:: with SMTP id j124mr3483733wmj.14.1545410659115; 
 Fri, 21 Dec 2018 08:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
In-Reply-To: <20181221152110.17982-2-codekipper@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 22 Dec 2018 00:44:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
Message-ID: <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap settings
To: Code Kipper <codekipper@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_084432_765329_F2ED1030 
X-CRM114-Status: GOOD (  22.64  )
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

On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> to reflect this.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index d5ec1a20499d..64d073cb2aee 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -548,9 +548,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>  {
>         /* Flush RX FIFO */
> +       regcache_cache_bypass(i2s->regmap, true);
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> +       regcache_cache_bypass(i2s->regmap, false);

IIRC the flush cache bit is self-clearing. So you likely want to mark
this register as volatile. If it is marked as volatile, then all access
to that register bypasses the cache, so the regcache_cache_bypass calls
are unneeded.

However, looking at the code, the write would seem to be ignored if the
regmap is in the cache_only state. We only set this when the bus clock
is disabled. Under such a condition, bypassing the cache and forcing a
write would be unwise, as the system either drops the write, or stalls
altogether.

>
>         /* Clear RX counter */
>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> @@ -569,9 +571,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>  static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
>  {
>         /* Flush TX FIFO */
> +       regcache_cache_bypass(i2s->regmap, true);
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> +       regcache_cache_bypass(i2s->regmap, false);
>
>         /* Clear TX counter */
>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> @@ -703,13 +707,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
>
>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
>  {
> -       switch (reg) {
> -       case SUN4I_I2S_FIFO_TX_REG:
> -               return false;
> -
> -       default:
> -               return true;
> -       }
> +       return true;

I don't understand why this is relevant. Do you need to read back from the TX
FIFO?

If so, just drop the call-back altogether. If no callback is provided and no
rd_table is provided either, it defaults to all registers under max_register
(if max_register < 0) are readable.

However this seems like it deserves to be a separate patch (where you explain
in the commit log why it's needed).

Regards
ChenYu

>  }
>
>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> @@ -728,6 +726,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  {
>         switch (reg) {
>         case SUN4I_I2S_FIFO_RX_REG:
> +       case SUN4I_I2S_FIFO_TX_REG:
> +       case SUN4I_I2S_FIFO_STA_REG:
>         case SUN4I_I2S_INT_STA_REG:
>         case SUN4I_I2S_RX_CNT_REG:
>         case SUN4I_I2S_TX_CNT_REG:
> @@ -738,23 +738,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>         }
>  }
>
> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> -{
> -       switch (reg) {
> -       case SUN8I_I2S_FIFO_TX_REG:
> -               return false;
> -
> -       default:
> -               return true;
> -       }
> -}
> -
>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>  {
>         if (reg == SUN8I_I2S_INT_STA_REG)
>                 return true;
>         if (reg == SUN8I_I2S_FIFO_TX_REG)
> -               return false;
> +               return true;
>
>         return sun4i_i2s_volatile_reg(dev, reg);
>  }
> @@ -809,7 +798,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
>         .reg_defaults   = sun8i_i2s_reg_defaults,
>         .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
>         .writeable_reg  = sun4i_i2s_wr_reg,
> -       .readable_reg   = sun8i_i2s_rd_reg,
> +       .readable_reg   = sun4i_i2s_rd_reg,
>         .volatile_reg   = sun8i_i2s_volatile_reg,
>  };
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
