Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FECC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:36:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435A520850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kmt3W0c7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LwDBkBhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435A520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BtlbfxxOsNOA93agwzYd2hIxhNn5Exv9tTIqcl6i83w=; b=kmt3W0c712M+88
	WYM9YD/eeFWobJDC1n0CtQlcwSZ4MEuLkDML2YkGmqKCyBnSN17ScYwPbmOYQLs5P2ypt06efFJO+
	uu1Mu+o/s0eAIwxGx/9ThflYTUvamjXynDKsb2Vrpz8HLZY4hli6idW4bHJlf1U9cYU4HvFI+gzxm
	zbzMsGLUCSKrE7+mbgYn57URROvizu4Jjm28XixakAwWZTck2dLgpuQLThEuBmzPvBH2rGgQmmWJk
	zi4TCCpwYlhN5ulteeiglhWLOCJ8xgB6tpXeg/wqMPRwg246xChT7cOiWoLvTl0lnnVlgPK356Tnl
	U+kV1vMKuKhnSkwnIPdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlau-0003ED-8k; Mon, 03 Dec 2018 10:36:52 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlap-0003DM-Jy
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:36:50 +0000
Received: by mail-wm1-x343.google.com with SMTP id f81so2674872wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=up5LcSgEp00Z28NCqSzII18i1J7FDVHnKHI1LcaQ96Q=;
 b=LwDBkBhUzLzsiQyW8lPHWGQGrmJiUXwE83VXqUAXoDiQphRD14Eq1+67nHQv+UDsAg
 GOmrIccai+Vj9+3iAPibTN94keNWrOXUSPjj6UpPBouRxFrH52WgCfWcaqD6o7MUzHgv
 j2n2BMpFv8vJNbaeJTm2YTfMP9trEJBL6ZJN9ynSb1IqZkAbNd40U5PxPdN7pwILuoXE
 3IRxGPFPpYqjT+Zp31h3jTpx0fDyNlzrriIRKEi8gB812OqUO5JJVQG9NQxZaEIEsE4d
 a9AmMZcCk+wim8mIQde31fcW+pgno6Oxeo9UeB9ShuroHlP+LaQplnAOwzhLrTGlOjV7
 GG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=up5LcSgEp00Z28NCqSzII18i1J7FDVHnKHI1LcaQ96Q=;
 b=Zo8NCCwhMptnv5tABt40M+M0YUyPhDfQRPD9fz7oIdNAZfey3kW7Gyd8qpq1UkX6u5
 KlJanjFnKqUTbzqrZji9jAPK9XjgNq6KB96F3FSBTiKWCZaXnSAdvSoep6R/xw+VXWDl
 Nkv81O0AeL7cySlLexyPJo6Xc+8NZ+NybCGFdWg2N2Ui4q4+RDF3oBw5w3JO3A1vJZjM
 yzzAYlKAmrizDc8hPWBXGf1ei2VAJdSHtfv3iVcEvRahkuJVTYNxWArzeVYBGxbVnrLb
 Cc2G8VSbv39Z8Bqrf3fzqPscjO7wSjal55RqaiJd3Hto8ZAh0E8uh1C6XiQEoIpT/jfY
 8QNw==
X-Gm-Message-State: AA+aEWYzoDmATFfNEM0ChjY1FtamLyZqEf8RL70N3sCBI+IZ3PFGKxxr
 wAVyCseqccFuXo6DuvbrgY+gqA==
X-Google-Smtp-Source: AFSGD/X5ceD2PIej54vdDDlQaNJ8ZL3HBbzxz9hWOEcqHqqKvssWwQElEL1m32OD4ORNQRaqsLLtYA==
X-Received: by 2002:a1c:9513:: with SMTP id x19mr7527589wmd.112.1543833394984; 
 Mon, 03 Dec 2018 02:36:34 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 k26sm3011479wmi.28.2018.12.03.02.36.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 02:36:34 -0800 (PST)
Message-ID: <f2ceff1edcb2c103d0128a838ff630bb3c147bf5.camel@baylibre.com>
Subject: Re: [PATCH] pinctrl: meson: fix G12A ao pull registers base address
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Xingyu Chen
 <xingyu.chen@amlogic.com>, linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org
Date: Mon, 03 Dec 2018 11:36:32 +0100
In-Reply-To: <a240773f-7b05-d950-e5e9-23d7983c7f35@baylibre.com>
References: <20181203030533.10989-1-xingyu.chen@amlogic.com>
 <a240773f-7b05-d950-e5e9-23d7983c7f35@baylibre.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_023647_656647_1C5D4A67 
X-CRM114-Status: GOOD (  27.29  )
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
Cc: robh@kernel.org, jianxin.pan@amlogic.com,
 martin.blumenstingl@googlemail.com, khilman@baylibre.com,
 linux-kernel@vger.kernel.org, carlo@caione.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2018-12-03 at 11:27 +0100, Neil Armstrong wrote:
> Hi Xingyu,
> 
> 
> On 03/12/2018 04:05, Xingyu Chen wrote:
> > Since Meson G12A SoC, Introduce new ao registers AO_RTI_PULL_UP_EN_REG
> > and AO_GPIO_O.
> > 
> > These bits of controlling output level are remapped to the new register
> > AO_GPIO_O, and the AO_GPIO_O_EN_N support only controlling output enable.
> > 
> > These bits of controlling pull enable are remapped to the new register
> > AO_RTI_PULL_UP_EN_REG, and the AO_RTI_PULL_UP_REG support only controlling
> > pull type(up/down).
> > 
> > The new layout of ao gpio/pull registers is as follows:
> > - AO_GPIO_O_EN_N        [offset: 0x9 << 2]
> > - AO_GPIO_I             [offset: 0xa << 2]
> > - AO_RTI_PULL_UP_REG    [offset: 0xb << 2]
> > - AO_RTI_PULL_UP_EN_REG [offset: 0xc << 2]
> > - AO_GPIO_O             [offset: 0xd << 2]
> > 
> > From above, we can see ao GPIO registers region has been separated by the
> > ao pull registers. In order to ensure the continuity of the region on
> > software, the ao GPIO and ao pull registers use the same base address, but
> > can be identified by the offset.
> > 
> > Fixes: 29ae0952e85f ("pinctrl: meson-g12a: add pinctrl driver support")
> > Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> > Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> > ---
> >  drivers/pinctrl/meson/pinctrl-meson.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/meson/pinctrl-meson.c
> > b/drivers/pinctrl/meson/pinctrl-meson.c
> > index 53d449076dee..7ff40cd7a0cb 100644
> > --- a/drivers/pinctrl/meson/pinctrl-meson.c
> > +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> > @@ -31,6 +31,9 @@
> >   * In some cases the register ranges for pull enable and pull
> >   * direction are the same and thus there are only 3 register ranges.
> >   *
> > + * Since Meson G12A SoC, the ao register ranges for gpio, pull enable
> > + * and pull direction are the same, so there are only 2 register ranges.
> > + *
> >   * For the pull and GPIO configuration every bank uses a contiguous
> >   * set of bits in the register sets described above; the same register
> >   * can be shared by more banks with different offsets.
> > @@ -487,23 +490,22 @@ static int meson_pinctrl_parse_dt(struct
> > meson_pinctrl *pc,
> >  		return PTR_ERR(pc->reg_mux);
> >  	}
> >  
> > -	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
> > -	if (IS_ERR(pc->reg_pull)) {
> > -		dev_err(pc->dev, "pull registers not found\n");
> > -		return PTR_ERR(pc->reg_pull);
> > +	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
> > +	if (IS_ERR(pc->reg_gpio)) {
> > +		dev_err(pc->dev, "gpio registers not found\n");
> > +		return PTR_ERR(pc->reg_gpio);
> >  	}
> >  
> > +	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
> > +	/* Use gpio region if pull one is not present */
> > +	if (IS_ERR(pc->reg_pull))
> > +		pc->reg_pull = pc->reg_gpio;
> > +
> >  	pc->reg_pullen = meson_map_resource(pc, gpio_np, "pull-enable");
> >  	/* Use pull region if pull-enable one is not present */
> >  	if (IS_ERR(pc->reg_pullen))
> >  		pc->reg_pullen = pc->reg_pull;
> >  
> > -	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
> > -	if (IS_ERR(pc->reg_gpio)) {
> > -		dev_err(pc->dev, "gpio registers not found\n");
> > -		return PTR_ERR(pc->reg_gpio);
> > -	}
> > -
> >  	return 0;
> >  }
> >  
> > 
> Doesn't it need an update of the bindings ?

Going even further, shouldn't we stop trying make multiple regions out of
this, and have just one ? 

On all the Amlogic SoC we have seen so far, all the regions a very (VERY)
close to each other. It seems very unlikely that there something unrelated to
GPIO in between.

It looks like everything is mostly there in the driver to deal with offset, so
change would be minimal.

Of course, for  DT stability we will need to carry the legacy, but for newer
SoC, such as the g12, does it really makes sense to have multiple regions ?

> 
> Neil
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
