Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66111C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:22:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3789A21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GnEprFPQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yWgd0+UO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3789A21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8pUHm6kzKMD5Fg13QmN3T0w+sVuQbb0d9rqR+s9JSGk=; b=GnEprFPQPia1Dk
	Aqsr+V6mJsggkhjR6NUUNGff9q9EzhzyA7WtdnG58nbQgp5kGREBJDRyavkOUZfvb98GOKC6jHPTR
	bx1agN2JQ8H4+GhkG0cJRFPw6VIA5cgKo196VKeDghSzanP4tNNdjDAoQs5DSKgM/1c2KNBLmdrcC
	CLlrGkq/JcjItJHkxMMvVLB316WJ9ZMVDNsJwmNt+2g0DgVooHGj+fZ2YGMihD6PfYhQrJKK2+3iK
	rpbXKwa8NYCk8XXogijFyLrmaW6UIqny8YiJB8xlVK2dc94s7VTHG9MiktFT9lbK0Us6tTlBoQ/G3
	5fOl1Ai7lsS1N/W3KRWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsVNz-0007RY-K9; Sat, 09 Feb 2019 16:21:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsVNt-0007RC-5z
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 16:21:42 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D7C621773;
 Sat,  9 Feb 2019 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549729300;
 bh=b+KHT29ZeKLsTBAEvpCqPqqPmSZcaSy2thRyQaseod8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=yWgd0+UOoHooGSYlqa0T7782h063nHtNFqk3yc9RAF0/PwzvnDG9e9EX+QJrC0MXH
 Au40D7x4/ywMkPZLWphXxBlBOfLOhpK2bg4UuTXF3JvAQPpIKwvUPwQIZCL3OyN97Y
 MI16IhG68l7cfteEYPSvhFCEYsdq+g7Ic7Nlge28=
Date: Sat, 9 Feb 2019 16:21:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 4/4] iio: counter: stm32-lptimer: Add power management
 support
Message-ID: <20190209162133.65e6fd93@archlinux>
In-Reply-To: <1549370429-19116-5-git-send-email-fabrice.gasnier@st.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_082141_260313_BD04FC59 
X-CRM114-Status: GOOD (  17.80  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, vilhelm.gray@gmail.com,
 thierry.reding@gmail.com, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 5 Feb 2019 13:40:29 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add suspend/resume PM sleep ops. When going to low power, disable
> active counter. Only active counter should be resumed: don't touch
> disabled counter, as it may be used by other LPTimer MFD child driver.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I think this looks fine.  I'm not totally sure if patches 3,4 are
separable from 1,2 though so please let me know whether I should take
these now, or let all 4 go in together via some path?

Thanks,

Jonathan

> ---
>  drivers/iio/counter/stm32-lptimer-cnt.c | 55 +++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
> index 42fb8ba..2a49cce 100644
> --- a/drivers/iio/counter/stm32-lptimer-cnt.c
> +++ b/drivers/iio/counter/stm32-lptimer-cnt.c
> @@ -14,6 +14,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/mfd/stm32-lptimer.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  
>  struct stm32_lptim_cnt {
> @@ -23,6 +24,7 @@ struct stm32_lptim_cnt {
>  	u32 preset;
>  	u32 polarity;
>  	u32 quadrature_mode;
> +	bool enabled;
>  };
>  
>  static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
> @@ -50,6 +52,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
>  
>  	if (!enable) {
>  		clk_disable(priv->clk);
> +		priv->enabled = false;
>  		return 0;
>  	}
>  
> @@ -79,6 +82,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
>  		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
>  		return ret;
>  	}
> +	priv->enabled = true;
>  
>  	/* Start LP timer in continuous mode */
>  	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
> @@ -361,6 +365,56 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int stm32_lptim_cnt_suspend(struct device *dev)
> +{
> +	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Only take care of enabled counter: don't disturb other MFD child */
> +	if (priv->enabled) {
> +		ret = stm32_lptim_setup(priv, 0);
> +		if (ret)
> +			return ret;
> +
> +		ret = stm32_lptim_set_enable_state(priv, 0);
> +		if (ret)
> +			return ret;
> +
> +		/* Force enable state for later resume */
> +		priv->enabled = true;
> +	}
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int stm32_lptim_cnt_resume(struct device *dev)
> +{
> +	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->enabled) {
> +		priv->enabled = false;
> +		ret = stm32_lptim_setup(priv, 1);
> +		if (ret)
> +			return ret;
> +
> +		ret = stm32_lptim_set_enable_state(priv, 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(stm32_lptim_cnt_pm_ops, stm32_lptim_cnt_suspend,
> +			 stm32_lptim_cnt_resume);
> +
>  static const struct of_device_id stm32_lptim_cnt_of_match[] = {
>  	{ .compatible = "st,stm32-lptimer-counter", },
>  	{},
> @@ -372,6 +426,7 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
>  	.driver = {
>  		.name = "stm32-lptimer-counter",
>  		.of_match_table = stm32_lptim_cnt_of_match,
> +		.pm = &stm32_lptim_cnt_pm_ops,
>  	},
>  };
>  module_platform_driver(stm32_lptim_cnt_driver);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
