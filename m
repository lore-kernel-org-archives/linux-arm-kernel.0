From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 16 Jul 2015 19:46:03 +0530
Subject: [RFC PATCH] pinctrl-single: Use of pinctrl-single for external
 device over I2C
In-Reply-To: <CACRpkdZwucqETn3OkX1GPO43JpwWL67OB1FExHFD5CzWTA3D5g@mail.gmail.com>
References: <1435855992-10312-1-git-send-email-vaibhav.hiremath@linaro.org>
 <CACRpkdZwucqETn3OkX1GPO43JpwWL67OB1FExHFD5CzWTA3D5g@mail.gmail.com>
Message-ID: <55A7BCA3.2010607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 16 July 2015 06:28 PM, Linus Walleij wrote:
> On Thu, Jul 2, 2015 at 6:53 PM, Vaibhav Hiremath
> <vaibhav.hiremath@linaro.org> wrote:
>
>> In some usecases, the external device (in my case it PMIC over I2C)
>> does support pin in multiple configuration, we may need to control/configure them
>> during boot or runtime.
>
> What is missing from this patch is an explanation why pinctrl-single should
> be used for this PMIC.
>
> Repeat: pinctrl-single: when you have exactly one register per pin, and
> the description of the pins is delivered in an opaque ASIC-specific format
> without developers knowing much about how the hardware actually works,
> just "set these magic values".
>
> I strongly prefer that this PMIC has its own pin controller using standard
> bindings with groups and functions, see eg. drivers/pinctrl/nomadik/pinctrl-ab*
> for a PMIC pinctrl driver.
>

Thanks for the reference, good to know this.
Let me check this driver before commenting anything further on this.

Thanks,
Vaibhav

> Yours,
> Linus Walleij
>
