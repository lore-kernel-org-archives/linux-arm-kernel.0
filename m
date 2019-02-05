Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77BDC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:30:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55182184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LUqDzx6V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRrDIofH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55182184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=45ibtopst3bQaFXB+VeUnTvoi/40qqjQi6RHuCBa+Lk=; b=LUqDzx6V2nT4na
	w+18ZEDQvpsFrJxOkO4usC9zMm/mAOshbIIKTs2fIaw4iPGhCqKr22okkqjv/cTe993CJupQ+oEiD
	xXjj7xC+hrn8HKHPzB/xrAhJno+Ry9Ykf/GlYpEjDDhfRJfXF9EwIeq5WxRAKG49Xx7fnG/ffxGfW
	m9DfcrazXqmGmmiC+pPUTGQHJYQV3b2sfCsPAHcobrYg+x5BJs41XeWvgavclQeT3dHXyPXGOQ3Rz
	uVjWnOGkl3YweTA/Aa/EnhWnAGx+JJL2zlwPZ90kNRQRS8EdOf/Lyg7xcOAZiOa1b4+S0djhgDjCh
	gjnkms/nft/Ws31IP8hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr5UV-0004dr-DW; Tue, 05 Feb 2019 18:30:39 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr5UR-0004d1-MR
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 18:30:37 +0000
Received: by mail-lj1-x241.google.com with SMTP id c19-v6so3767221lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 10:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zsRpKuqcR4XzY4cG+nYq+fp6x32HO8rPZGifUy0n3uE=;
 b=KRrDIofHM71yRNsLZ7jpn+e6X12IbCkgCBBaa2bvKOb2bvdAgrY1+cUWqtJCAjxDLN
 9yA8N7lABhKFvfldJUJcusYAmbOIoAVTuq558gp6BJtAMAd0csDujiNivmzI5AZ2JGQD
 XnhaOXwV6I8eDWTu8fj4aNuG5dcchlyzY47YmbqyyOi4W8Yes2IOHzXCEPRrW0pslXSG
 VtYZYFso7akSqObNfQJJgoLeaMYX20lpsiGATfhJhkia6of8UPVDj2WRO1iQWIQLpCd4
 VSrTMmWvbhB5OugzxzfpfYo/77RMLTdnNfPTavZtp4plf+x6jMjuu8hqorQ2bVUCZL98
 StVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zsRpKuqcR4XzY4cG+nYq+fp6x32HO8rPZGifUy0n3uE=;
 b=ePB3RdsQ8S08uckFhy3zW9R9nObI4MbbzxSD0SH5+BLNaob6VALuHZDpshKKZHjB12
 2E7Wku6fo1IBtGH/X1pwi9ma94XjqlPKws8SXeyKPKslxKOEQnFU5hF6QU/lOhu/GF4A
 Dk+EmlxfLygpDbrpy63nv3DJ2y5l/RPDQlxhMSocsVhju5RVrz6t8RtoIlWndKd+4OBJ
 80tFz0EQJcQD/QTsoF8yoTseGQH9LS45WUWY/LZU6YHsvmAkPufCyEvdW5R/a7L9o3ox
 u61Z55XHc31zJavmskaCIRZtx5o7NgFndZarLP7ht7EqSYWlSnfGKH6zl5ugdudXza1S
 U44A==
X-Gm-Message-State: AHQUAuYMyEIwBR6Roi7gVmyEWUfTAvx5CxE5y9KizGEHnpx6cBraEN1V
 aIePjgOF/UehQL6iI6sj5Rk=
X-Google-Smtp-Source: AHgI3IZnjfpGALi+7YoLdPdkNEl3xKVY0NcGochiM0myzR4+z+nChy6WjgpHUgR/c98++SCjEsTl1g==
X-Received: by 2002:a2e:2a06:: with SMTP id q6-v6mr3603183ljq.37.1549391433209; 
 Tue, 05 Feb 2019 10:30:33 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
 by smtp.gmail.com with ESMTPSA id r29-v6sm3339904ljd.44.2019.02.05.10.30.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Feb 2019 10:30:32 -0800 (PST)
Date: Tue, 5 Feb 2019 19:30:09 +0100
From: Tomasz Duszynski <tduszyns@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Message-ID: <20190205183005.GA13960@arch>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_103035_743706_CA78569B 
X-CRM114-Status: GOOD (  21.28  )
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
 linux-kernel@vger.kernel.org, vilhelm.gray@gmail.com, robh+dt@kernel.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
 jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 01:40:27PM +0100, Fabrice Gasnier wrote:
> Add suspend/resume PM sleep ops. When going to low power, disable
> active PWM channel. Active PWM channel is resumed, by calling
> pwm_apply_state(). This is inspired by Thierry's comment in [1].
> Don't touch inactive channels, as it may be used by other LPTimer MFD
> child driver.
> [1]https://lkml.org/lkml/2017/12/5/175
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 0059b24c..0c40d48 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -13,6 +13,7 @@
>  #include <linux/mfd/stm32-lptimer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>
> @@ -20,6 +21,8 @@ struct stm32_pwm_lp {
>  	struct pwm_chip chip;
>  	struct clk *clk;
>  	struct regmap *regmap;
> +	struct pwm_state suspend;
> +	bool suspended;
>  };
>
>  static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
> @@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>  	return pwmchip_remove(&priv->chip);
>  }
>
> +#ifdef CONFIG_PM_SLEEP

You might consider dropping ifdefs and marking pm functions with
__maybe_unused instead. In case CONFIG_PM_SLEEP=n then these two guys
will be removed and pm ops structure will be empty.

> +static int stm32_pwm_lp_suspend(struct device *dev)
> +{
> +	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
> +

I guess you first need to get platform_device from dev and eventually
stm32_pwm_lp. Wondering how this works now.

> +	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
> +	priv->suspended = priv->suspend.enabled;
> +
> +	/* safe to call pwm_disable() for already disabled pwm */
> +	pwm_disable(&priv->chip.pwms[0]);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int stm32_pwm_lp_resume(struct device *dev)
> +{
> +	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Only restore suspended pwm, not to disrupt other MFD child */
> +	if (!priv->suspended)
> +		return 0;

Would it make sense to use suspend.enabled directly?

> +
> +	return pwm_apply_state(&priv->chip.pwms[0], &priv->suspend);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
> +			 stm32_pwm_lp_resume);
> +
>  static const struct of_device_id stm32_pwm_lp_of_match[] = {
>  	{ .compatible = "st,stm32-pwm-lp", },
>  	{},
> @@ -235,6 +272,7 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>  	.driver	= {
>  		.name = "stm32-pwm-lp",
>  		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
> +		.pm = &stm32_pwm_lp_pm_ops,
>  	},
>  };
>  module_platform_driver(stm32_pwm_lp_driver);
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
