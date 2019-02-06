Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95577C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:49:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537502081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bCpXzgQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537502081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HCEnyNxuZQjFqYovLAvc9zQpQU7d7HjtYHcxEZyTUP4=; b=bCpXzgQcmelViv
	Fm6SdXIWNfEYatz1XvA2Y6rtlktXpQKtT7i67pdDP58e6GyjUn4vUHDviGOUZPrl3I912i82fg+Ug
	rs6UEQIQDi84ZSLA+GQV9YDtunfJY4bgN4BWMie9sUUE+UuBHexJu7NvC9hLLoUMOvwhhkZ7cja1f
	ZV329CVsjsNDqut3FsRzVvp5keN1K9GV5bz+Pw7gEbg9wEyJ9G/oQdXupFnq3Nowemw5vZBUOpAKg
	dF/B6BhoCfL8jwGPQA3Ck55owFgv/mJ+4WNM6s63KDqx3edS8BxIFrl6V5RfjJldVpIUI0mjZjG95
	+IowGokyKfwlIIPzzK6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grItK-0006ul-Hy; Wed, 06 Feb 2019 08:49:10 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grIt7-0006kD-Uc
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 08:48:59 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x168f4Qp010305; Wed, 6 Feb 2019 09:48:52 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qfv9j812q-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 06 Feb 2019 09:48:52 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3191F222;
 Wed,  6 Feb 2019 08:42:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E19E1697;
 Wed,  6 Feb 2019 08:42:36 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Feb
 2019 09:42:35 +0100
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
To: Tomasz Duszynski <tduszyns@gmail.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205183005.GA13960@arch>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <60d17322-b3b2-943f-779f-33c47412b7a1@st.com>
Date: Wed, 6 Feb 2019 09:42:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205183005.GA13960@arch>
Content-Language: en-US
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_004858_285582_C6CAF70F 
X-CRM114-Status: GOOD (  20.11  )
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

On 2/5/19 7:30 PM, Tomasz Duszynski wrote:
> On Tue, Feb 05, 2019 at 01:40:27PM +0100, Fabrice Gasnier wrote:
>> Add suspend/resume PM sleep ops. When going to low power, disable
>> active PWM channel. Active PWM channel is resumed, by calling
>> pwm_apply_state(). This is inspired by Thierry's comment in [1].
>> Don't touch inactive channels, as it may be used by other LPTimer MFD
>> child driver.
>> [1]https://lkml.org/lkml/2017/12/5/175
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
>> index 0059b24c..0c40d48 100644
>> --- a/drivers/pwm/pwm-stm32-lp.c
>> +++ b/drivers/pwm/pwm-stm32-lp.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/mfd/stm32-lptimer.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/pinctrl/consumer.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pwm.h>
>>
>> @@ -20,6 +21,8 @@ struct stm32_pwm_lp {
>>  	struct pwm_chip chip;
>>  	struct clk *clk;
>>  	struct regmap *regmap;
>> +	struct pwm_state suspend;
>> +	bool suspended;
>>  };
>>
>>  static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
>> @@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>>  	return pwmchip_remove(&priv->chip);
>>  }
>>
>> +#ifdef CONFIG_PM_SLEEP
> 
> You might consider dropping ifdefs and marking pm functions with
> __maybe_unused instead. In case CONFIG_PM_SLEEP=n then these two guys
> will be removed and pm ops structure will be empty.

Hi Tomasz,

Thanks for this suggestion. I can do this change. I'll wait for more
feedback from Uwe and Thierry before sending a v2 with that.

> 
>> +static int stm32_pwm_lp_suspend(struct device *dev)
>> +{
>> +	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
>> +
> 
> I guess you first need to get platform_device from dev and eventually
> stm32_pwm_lp. Wondering how this works now.

This should be safe for now. This works because the probe routine calls:
	platform_set_drvdata(pdev, priv);

And the underlying call is dev_set_drvdata()
static inline void platform_set_drvdata(struct platform_device *pdev,
					void *data)
{
	dev_set_drvdata(&pdev->dev, data);
}

> 
>> +	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
>> +	priv->suspended = priv->suspend.enabled;
>> +
>> +	/* safe to call pwm_disable() for already disabled pwm */
>> +	pwm_disable(&priv->chip.pwms[0]);
>> +
>> +	return pinctrl_pm_select_sleep_state(dev);
>> +}
>> +
>> +static int stm32_pwm_lp_resume(struct device *dev)
>> +{
>> +	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = pinctrl_pm_select_default_state(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Only restore suspended pwm, not to disrupt other MFD child */
>> +	if (!priv->suspended)
>> +		return 0;
> 
> Would it make sense to use suspend.enabled directly?

I propose to keep priv->suspended. Using 'suspend.enabled' directly
would simply not work as the pwm_disable() call in
stm32_pwm_lp_suspend() routine marks the 'suspend' state.enabled = false.
That's why it's saved in the suspend routine, to be restored upon resume.

Thanks for reviewing,
Best regards,
Fabrice

> 
>> +
>> +	return pwm_apply_state(&priv->chip.pwms[0], &priv->suspend);
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
>> +			 stm32_pwm_lp_resume);
>> +
>>  static const struct of_device_id stm32_pwm_lp_of_match[] = {
>>  	{ .compatible = "st,stm32-pwm-lp", },
>>  	{},
>> @@ -235,6 +272,7 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>>  	.driver	= {
>>  		.name = "stm32-pwm-lp",
>>  		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
>> +		.pm = &stm32_pwm_lp_pm_ops,
>>  	},
>>  };
>>  module_platform_driver(stm32_pwm_lp_driver);
>> --
>> 1.9.1
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
