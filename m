Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80074C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:28:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3E02084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hKCN0pNw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Np6rTVgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3E02084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AYOo8XxY//1zQ/EGD2QFbf3/HukiS7gMas3MsgNdFLg=; b=hKCN0pNwZag732
	Pvnp00Wgm6vRWfXsvxOhwDSLZ9h3yBB3VtJss/yVO8+nVXMsqJdZkOC2c+hBiS1deqw6av2b/j9id
	3i3Pvxl6+NypP+bCxc1JokNO9TGAb81HqvBE/tjkU1dipy/NYteBRfCbAF/FhCgflyG4KProtrWQq
	7lW8eOZAlW49xO4DJr76SjPpF0exe90cmLFsrkuPOBNXIuvPqryiZceLLesAwYvDM64XIwkHtu22Q
	6CSpvJ/l8byYNrqn85oauStyBWPP93pliCNSl4pC8CVVJnT734ojuLOJdkDRlAwLVMtcwPycFQMpk
	LPE7hBM4aU9N/2R0HJng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWktS-0003k4-1N; Tue, 11 Dec 2018 16:28:22 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWktN-0003e0-75
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:28:19 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so14721770wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=f7K6GN5/aa8DCXT+gCMZwybLJkMHYSJQth2S97vanzo=;
 b=Np6rTVgqPxvJka6+7brT/Eim4w/Hd2CraROFW2i6SrUrrtDFf+5dxyKFNR3HTU+Zgt
 +vCWjDHnZGc+F2olDiYddyTEFyE/GNi7dXqazkNISskFklqX+tdSVgwQx266peIz9ct7
 ePiHh0fyp/cbKyR8yoQ4JWkKDUdxboWNTu/CO7Kbc+hPD0HikMWm5UZWPVkPYk6KshBt
 TVAN4io2nE8969uKqKTlM9HJeuZ9HHUQjRUln6G/cYZK4DZW7daog3ijzWsGzvI107jG
 echLmz0tB9thiCWCCAyAPjjj65fhYTyfmOvQecfFe+330PeTTAP6+VfsaquG/0Z/GKzF
 cpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=f7K6GN5/aa8DCXT+gCMZwybLJkMHYSJQth2S97vanzo=;
 b=Z9bYxzh6wpJPDCEZGbJKTyET1Eq0u0dAXyriaJku8aPRonaYufHxMynaiO2iBka3d3
 KDfbLPynbnTUuoMyp5a0AEh/SwaQ7LZ1Hlskri0CfUimmcFlVk9nSuXhyLGfpVLwRC7A
 DiloD60BpkxInnugyNHpK/Zv+E4BIGQpIZmi8UdrFN4C3TSt+zswlfV2dPVNdOiFjZph
 SKTN0Cv9CcctVerqQgHZ2j32sj4K6ovGXl1qMwdZueCvuKL/YoY81i8L+x3OTOnz04yi
 K2S6EyrSryyrCFdNljJdkkEfo+Y8qc56hY1HIjOHz8I+dQUunrQ0Q+s1z5etxBo6EYz6
 Qiww==
X-Gm-Message-State: AA+aEWbPlZUW49khC6F7MuhJMM/T4FUwtc5+G9Q2VVyLIOmT+jUadOAt
 h0uM6FhGDtaqhudHf3e+ACu0ww==
X-Google-Smtp-Source: AFSGD/UXMlaOEMcHHY+QljpOlM8+FZoMmIr7+8jsqKzy6aCccOZYqm9qFkRhYtZH8/ETWEHMRXDEXA==
X-Received: by 2002:adf:ce86:: with SMTP id r6mr14862307wrn.257.1544545683894; 
 Tue, 11 Dec 2018 08:28:03 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 y34sm44330957wrd.68.2018.12.11.08.28.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 08:28:02 -0800 (PST)
Message-ID: <8e1c711b477eeee60809f33926cf9c6a52f530cd.camel@baylibre.com>
Subject: Re: [PATCH RESEND v7 1/4] clk: meson: add emmc sub clock phase
 delay driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jianxin Pan <jianxin.pan@amlogic.com>, Neil Armstrong
 <narmstrong@baylibre.com>
Date: Tue, 11 Dec 2018 17:28:00 +0100
In-Reply-To: <1544457877-51301-2-git-send-email-jianxin.pan@amlogic.com>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
 <1544457877-51301-2-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_082817_342374_9B6A1F90 
X-CRM114-Status: GOOD (  20.58  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
> From: Yixun Lan <yixun.lan@amlogic.com>
> 
> Export the emmc sub clock phase delay ops which will be used
> by the emmc sub clock driver itself.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/clk/meson/Makefile          |  2 +-
>  drivers/clk/meson/clk-phase-delay.c | 64
> +++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/clkc.h            | 13 ++++++++
>  3 files changed, 78 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/clk-phase-delay.c
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 72ec8c4..39ce566 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Meson specific clk
>  #
>  
> -obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o
> +obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o clk-
> phase-delay.o
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
>  obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
> diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-
> phase-delay.c
> new file mode 100644
> index 0000000..84e7b63
> --- /dev/null
> +++ b/drivers/clk/meson/clk-phase-delay.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include "clkc.h"
> +
> +static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_delay_data *ph;
> +	unsigned long period_ps, p, d;
> +	int degrees;
> +
> +	ph = meson_clk_get_phase_delay_data(clk);
> +	p = meson_parm_read(clk->map, &ph->phase);
> +	degrees = p * 360 / (1 << (ph->phase.width));
> +
> +	period_ps = DIV_ROUND_UP(NSEC_PER_SEC * 1000,
> +				 clk_hw_get_rate(hw));
> +
> +	d = meson_parm_read(clk->map, &ph->delay);
> +	degrees += d * ph->delay_step_ps * 360 / period_ps;
> +	degrees %= 360;
> +
> +	return degrees;
> +}
> +
> +static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_delay_data *ph;
> +	unsigned long period_ps, d = 0, r;
> +
> +	ph = meson_clk_get_phase_delay_data(clk);
> +	period_ps = DIV_ROUND_UP(NSEC_PER_SEC * 1000, clk_hw_get_rate(hw));
> +
> +	/*
> +	 * First compute the phase index (p), the remainder (r) is the
> +	 * part we'll try to acheive using the delays (d).
> +	 */
> +	r = do_div(degrees, 360 / 1 << (ph->phase.width));
> +	d = DIV_ROUND_CLOSEST(r * period_ps,
> +			      360 * ph->delay_step_ps);
> +	d = min(d, PMASK(ph->delay.width));
> +
> +	meson_parm_write(clk->map, &ph->phase, degrees);
> +	meson_parm_write(clk->map, &ph->delay, d);
> +	return 0;
> +}
> +
> +const struct clk_ops meson_clk_phase_delay_ops = {
> +	.get_phase = meson_clk_phase_delay_get_phase,
> +	.set_phase = meson_clk_phase_delay_set_phase,
> +};
> +EXPORT_SYMBOL_GPL(meson_clk_phase_delay_ops);
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 6b96d55..30470c6 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -105,6 +105,18 @@ struct clk_regmap _name = {				
> 		\
>  	},								\
>  };
>  
> +struct meson_clk_phase_delay_data {
> +	struct parm			phase;
> +	struct parm			delay;
> +	unsigned int			delay_step_ps;
> +};
> +
> +static inline struct meson_clk_phase_delay_data *
> +meson_clk_get_phase_delay_data(struct clk_regmap *clk)
> +{
> +	return clk->data;
> +}

This is only usefull in the related clock driver, no need to export it

> +
>  /* clk_ops */
>  extern const struct clk_ops meson_clk_pll_ro_ops;
>  extern const struct clk_ops meson_clk_pll_ops;
> @@ -112,5 +124,6 @@ struct clk_regmap _name = {				
> 		\
>  extern const struct clk_ops meson_clk_mpll_ro_ops;
>  extern const struct clk_ops meson_clk_mpll_ops;
>  extern const struct clk_ops meson_clk_phase_ops;
> +extern const struct clk_ops meson_clk_phase_delay_ops;
>  
>  #endif /* __CLKC_H */



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
