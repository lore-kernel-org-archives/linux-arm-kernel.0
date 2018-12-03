Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B4AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:13:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC27B20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ez6ZmX5f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tB+qce/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC27B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=heMw29prOsEKhc6AWbwB7dDJGq7393x+QTxeTcwkcCM=; b=Ez6ZmX5fMVdcg7
	19HGqCRwa6EMHs56kmRAeAq+8riZrxnQgfb4Rq7n5ungPKRIFISV0JFK/cbBe9ZB1+wpsF4gO0hg4
	YbnxbyOyKoKR7B/6ooeaAr0nAq4VacRJQ5KeWMOYqCL6h9iWi1XSep83IMnKA8JqLiVDfqe92MeHI
	bwX5FDWEhMrymoYtyz+SPH0AB2/sdNSAy4BsI6DiLS6FyLPUHCyjUpxHEcapE977QwmRAevUpwI7f
	sYw2WgGeghkt4VCfoQhpjp0FWpRXfveN0p9LO5T7pOXDa3VDMD22shdn6B0h5IFsyet8/41HEoyY/
	abiXXpQVktkg9GFdYMEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtf5-0007jg-9M; Mon, 03 Dec 2018 19:13:43 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtf1-0007gL-OF
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:13:41 +0000
Received: by mail-pf1-x441.google.com with SMTP id z9so6864754pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 11:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qnASkkUVzay1X6I35mt8jop4Y9+o9JyVXsgOZofm6Vs=;
 b=tB+qce/ZOpXQCRdc+/4AQjwVDx3uZd+nOn9OZLXHCNkt8aGZuI0s67M62/wQnE+XzS
 eLkFJUhJR+HjUZr6KyM2eog2yjYavGX/dngEuM7pyQhAlSYC/J3sPhKUQBiWS/Q3DCQW
 NKgWKmksWjqLGlzPbItwUDniedVS5jlQS68VLYnEr3kQAY8dZ0cG6/6Sb9cNS2VN1Nqu
 1+/qVhMz/7Hl1xGIFjhkR2D6Grjg2ZAmtWU7IEHp5l88lqb7mJ0/NWh8U3EZdrlseZ3n
 zTbUdM9mRYkThjEgyHRVyeeJg2Wd9RjKBR2y6Og+8IDJZAkWc4cIHJJlofpjU6QQNfby
 C/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qnASkkUVzay1X6I35mt8jop4Y9+o9JyVXsgOZofm6Vs=;
 b=pC7W6FP6VTmSGqjKCyz1DKzy/jJkdeK2WWg9CpWoyE5G+B+8Yy/LEe4s6+ooaE3CA5
 LtWAiT6aAYB0PNYo/FF3qWUkQWFrWv85Cs1gmXgqFS3A9CoF33R5nEJAVNpdjmnqRlsg
 R1A+OgOkQA2bZzyhAef+NNdCvW4RPOQqssfSJjEx2ZuDNwHdnaONgRdVd5t0XgTirABu
 44O0x+C64wIQLu5y9c7B3K9dnJzVAAO6Soxj8rCTjt9h2TRcgeBRtPqIKsVKSS1d11oh
 yU3p/rgOSADrd93SmqL5xN7+ib+UV+UU/IbtZjvjSGSv5YOriOziIGRz1YVabHiVcIxs
 1PLQ==
X-Gm-Message-State: AA+aEWYG2pmuurXaVr3iWZC0I2vcANDb1seH2wx6nWR47o/cNDXapp/J
 HfrKZ8SxOxEMrIOukVZVJC8=
X-Google-Smtp-Source: AFSGD/WhMTQSZ7N26qIrRlb9gM8kTEWwLXOXVFT8mH3d+bAe+R+FzC0Qvvo6vZJ9GTaYEXhjJXcDwQ==
X-Received: by 2002:a63:a401:: with SMTP id c1mr14336354pgf.403.1543864407902; 
 Mon, 03 Dec 2018 11:13:27 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id d129sm23610379pfc.31.2018.12.03.11.13.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 11:13:26 -0800 (PST)
Date: Mon, 3 Dec 2018 11:13:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 6/9] Input: goodix - Add vcc-supply regulator support
Message-ID: <20181203191324.GA257010@dtor-ws>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203101547.16835-6-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_111339_801758_8E6DC076 
X-CRM114-Status: GOOD (  21.36  )
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
Cc: devicetree@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 03:45:44PM +0530, Jagan Teki wrote:
> vcc-supply property is need for some Goodix CTP controller like GT5663
> where 3.3V external pull-up regulator connected via controller VCC pin.
> 
> So, enable the regulator for those it attached the vcc-supply.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/input/touchscreen/goodix.c | 39 ++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index f2d9c2c41885..7adcf1491609 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -27,6 +27,7 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> @@ -47,6 +48,7 @@ struct goodix_ts_data {
>  	struct touchscreen_properties prop;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> +	struct regulator *vcc;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
>  	u16 id;
> @@ -58,6 +60,7 @@ struct goodix_ts_data {
>  
>  #define GOODIX_GPIO_INT_NAME		"irq"
>  #define GOODIX_GPIO_RST_NAME		"reset"
> +#define GOODIX_VCC_CTP_NAME		"vcc"
>  
>  #define GOODIX_MAX_HEIGHT		4096
>  #define GOODIX_MAX_WIDTH		4096
> @@ -525,12 +528,24 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
>  {
>  	int error;
>  	struct device *dev;
> +	struct regulator *regulator;
>  	struct gpio_desc *gpiod;
>  
>  	if (!ts->client)
>  		return -EINVAL;
>  	dev = &ts->client->dev;
>  
> +	regulator = devm_regulator_get(dev, GOODIX_VCC_CTP_NAME);
> +	if (IS_ERR(regulator)) {
> +		error = PTR_ERR(regulator);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get vcc regulator: %d\n",
> +				error);
> +		return error;
> +	}
> +
> +	ts->vcc = regulator;
> +
>  	/* Get the interrupt GPIO pin number */
>  	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
>  	if (IS_ERR(gpiod)) {
> @@ -786,25 +801,34 @@ static int goodix_ts_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> +	/* power the controller */
> +	if (ts->vcc) {

ts->vcc is never NULL.

> +		error = regulator_enable(ts->vcc);
> +		if (error) {
> +			dev_err(&client->dev, "Controller fail to enable vcc\n");
> +			return error;
> +		}
> +	}
> +
>  	if (ts->gpiod_int && ts->gpiod_rst) {
>  		/* reset the controller */
>  		error = goodix_reset(ts);
>  		if (error) {
>  			dev_err(&client->dev, "Controller reset failed.\n");
> -			return error;
> +			goto error;
>  		}
>  	}
>  
>  	error = goodix_i2c_test(client);
>  	if (error) {
>  		dev_err(&client->dev, "I2C communication failure: %d\n", error);
> -		return error;
> +		goto error;
>  	}
>  
>  	error = goodix_read_version(ts);
>  	if (error) {
>  		dev_err(&client->dev, "Read version failed.\n");
> -		return error;
> +		goto error;
>  	}
>  
>  	ts->chip = goodix_get_chip_data(ts->id);
> @@ -823,17 +847,22 @@ static int goodix_ts_probe(struct i2c_client *client,
>  			dev_err(&client->dev,
>  				"Failed to invoke firmware loader: %d\n",
>  				error);
> -			return error;
> +			goto error;
>  		}
>  
>  		return 0;
>  	} else {
>  		error = goodix_configure_dev(ts);
>  		if (error)
> -			return error;
> +			goto error;
>  	}
>  
>  	return 0;
> +
> +error:
> +	if (ts->vcc)
> +		regulator_disable(ts->vcc);

Same here.

> +	return error;
>  }
>  
>  static int goodix_ts_remove(struct i2c_client *client)

You need to disable regulator on removal as well.

Thanks.

-- 
Dmitry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
