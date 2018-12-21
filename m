Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63039C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:55:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3336221916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="si7afThb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3336221916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7KCAHUtxOz8Mrij2jXFQYkT7dn25Z4g+tijYq3pKyt4=; b=si7afThb0YZ+zI
	NZN8K2pVFYwaLpo4L+vmMfjDJCgCbqJUma88zpZ52sLIQdn0XJYhZjTOThZurJ+TYk5QdQ48cMwou
	Nk0UL61WNWIbOw7Zr6RopM6x6wMcB5GwXvl+YTfibzBGzT+6rbx/H6BQIsR1ZlF0VPLZ5wHXwIYQl
	fYdB71T7E/c0jNnfB9pQ2isvoNXxoODVmIC5+y2L+EPx3UY2cCMSeLRLeqAdoTYX01Bsxmwchl0FQ
	kTSVoBNXpIslF9VC1wGZXQq5PsYX2tgNFz9ROUKknmCJ7PsIULyZi2GXnUafa5GsTiS1SP00l+Trm
	Vs8Oh222SiIiQBSTu4Xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaO4x-0002er-14; Fri, 21 Dec 2018 16:55:15 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaO4t-0001P7-Ig
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 16:55:12 +0000
Received: by mail-ed1-f65.google.com with SMTP id d39so5169009edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 08:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xply796OrFTbPbKOInlOGea+sluCH6NYMVhwCZIZIu4=;
 b=QIajORNGiSHKIkQorirtq/rxH4zl+qm1Apuh67iDFHKbA2+xwk1TOwq4epOLLrQNyk
 sAP3QUV1ev9ubmm8H4JLqsYADkD1pcYj1IHg4cAbFwAWsFzfN0g3o+j8Qt4bZ60eb9a2
 qzzSmeExlxj1+XJIEd6y4mYsdKL5vzsYiLmdKlzlVS/k0HMv8M+ioWJh4Tt/79l8989S
 S439Y5PxMlU862KyoEzYGL8dQ3g7oDdqwA4pk9IGZCqQ322wK7GKjYvbXPV25wjax1Vh
 d2bqUg3XXaHtFyFTfgK9ogZ8XH/fpBYqvFb+YEnRF0ARDVanzugECsAwYIJ2OVq9na8T
 akYg==
X-Gm-Message-State: AA+aEWauC8C3y4DmUFrsnNkKY7QBWRs9t451KCJdoyjP+UcENRDEz4gs
 UI7R7Qu0uwylHdifsCtRlYQFOm3mN/0=
X-Google-Smtp-Source: AFSGD/VkLzz7XqlgvMvmmpRK1p2cev7bqCzs+G0jsdSg4uSvpf1wpQPw0wVmz0yRL2p1PDpkGjUCFA==
X-Received: by 2002:a50:9063:: with SMTP id z32mr2975568edz.133.1545411300084; 
 Fri, 21 Dec 2018 08:55:00 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47])
 by smtp.gmail.com with ESMTPSA id c11-v6sm3620330ejm.67.2018.12.21.08.54.59
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 08:54:59 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id t6so5948243wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 08:54:59 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr3535599wrv.188.1545411299075; 
 Fri, 21 Dec 2018 08:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-5-codekipper@gmail.com>
In-Reply-To: <20181221152110.17982-5-codekipper@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 22 Dec 2018 00:54:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
Message-ID: <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] ASoC: sun4i-i2s: Fix offset mask
To: Code Kipper <codekipper@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_085511_620582_F251AE8B 
X-CRM114-Status: GOOD (  15.96  )
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
> Also add offset to RX channel select
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Commit log seems a bit lacking. You could probably explain how you
found this, either when comparing datasheet macros, or some actual
error manifested and you "heard" it. You could also state what the
fixed outcome should be.

Also please add a fixes tag.

The RX channel select offset should be added as a separate patch,
also with an explanation on how you found this missing, and a fixes
tag.

ChenYu

> ---
>  sound/soc/sunxi/sun4i-i2s.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index adb988ae9ac5..93a484d7e228 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -110,7 +110,7 @@
>
>  #define SUN8I_I2S_TX_CHAN_MAP_REG      0x44
>  #define SUN8I_I2S_TX_CHAN_SEL_REG      0x34
> -#define SUN8I_I2S_TX_CHAN_OFFSET_MASK          GENMASK(13, 11)
> +#define SUN8I_I2S_TX_CHAN_OFFSET_MASK          GENMASK(13, 12)
>  #define SUN8I_I2S_TX_CHAN_OFFSET(offset)       (offset << 12)
>  #define SUN8I_I2S_TX_CHAN_EN_MASK              GENMASK(11, 4)
>  #define SUN8I_I2S_TX_CHAN_EN(num_chan)         (((1 << num_chan) - 1) << 4)
> @@ -482,6 +482,10 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                 regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
>                                    SUN8I_I2S_TX_CHAN_OFFSET_MASK,
>                                    SUN8I_I2S_TX_CHAN_OFFSET(offset));
> +
> +               regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
> +                                  SUN8I_I2S_TX_CHAN_OFFSET_MASK,
> +                                  SUN8I_I2S_TX_CHAN_OFFSET(offset));
>         }
>
>         regmap_field_write(i2s->field_fmt_mode, val);
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
