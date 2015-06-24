From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 24 Jun 2015 17:34:23 +0530
Subject: Use of pinctrl-single for external device over I2C
In-Reply-To: <55893B2C.1070800@linaro.org>
References: <55893B2C.1070800@linaro.org>
Message-ID: <558A9CC7.6070409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 23 June 2015 04:25 PM, Vaibhav Hiremath wrote:
> Hi,

+ linux-arm-kernel & MFD

Thanks,
Vaibhav
>
> I am working on enabling support for PMIC 88PM860 device in the
> mainline.
>
> In 88PM860 (and family of devices) few pins are labelled as GPIO's, to
> be precise, in 88PM860, we have 8 GPIO's (ana & dig).
>
>
> I was looking at pinctrl-single driver, as it seems it can not handle
> pinmux configuration of external device (in this case its over I2C), as
> it uses raw read/write api's.
>
> I see below lines in the driver,
>
>
> /*
>   * REVISIT: Reads and writes could eventually use regmap or something
>   * generic. But at least on omaps, some mux registers are performance
>   * critical as they may need to be remuxed every time before and after
>   * idle. Adding tests for register access width for every read and
>   * write like regmap is doing is not desired, and caching the registers
>   * does not help in this case.
>   */
>
>
> Should be not have flag for this and use regmap_ variants? If we
> implement flag based approach then same driver can be reused for pinmux
> configuration of external device.
>
>
> Just to give more clarity, Let me describe my use-case below,
>
> The platform which I have is based on PXA1928 and 88PM860 chipsets,
> where 88PM860.GPIO_0 is connected back to PXA1928.EXT_32K_IN.
>
> GPIO_0 need to configured in mode '4'.
>
> As per spec, 88PM860.GPIO_0 can be configured to
>
>   000 = GPIO input mode
>   001 = GPIO output mode
>   010 = SLEEPOUTN mirror mode
>   011 = Buck4 FPWM enable
>   100 = 32 Khz output buffer mode
>   101 = PMICINTN output mode
>   110 = HW_RESET1 mode
>   111 = HW_RESET2 mode
>
>
> Please let me know if there is already an alternative for this, which I
> missed.
>
> Thanks,
> Vaibhav
>
>
>
> Thanks,
> Vaibhav
