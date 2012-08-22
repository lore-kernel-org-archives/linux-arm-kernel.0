From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 22 Aug 2012 10:08:48 +0530
Subject: [PATCH v2 3/4] gpio: exynos4: skip gpiolib registration if
 pinctrl driver is used
In-Reply-To: <CACRpkdYc-iMgKBNfRmxUFftK78G77qQ8h_Rr5td1-95NGo7wZg@mail.gmail.com>
References: <1345060656-32201-1-git-send-email-thomas.abraham@linaro.org>
 <1345060656-32201-4-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdYc-iMgKBNfRmxUFftK78G77qQ8h_Rr5td1-95NGo7wZg@mail.gmail.com>
Message-ID: <CAJuYYwSaV9=DiAnv_s0yJJGLYUQrEk+P4s0EyX00-P0ae-WEBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 August 2012 17:35, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 15, 2012 at 9:57 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>
>> Pinctrl driver, when enabled, registers all the gpio pins and hence the
>> registration of gpio pins by this driver can be skipped.
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>
>> +#ifdef CONFIG_OF
>
> Wouldn't it be better to use
> #ifdef CONFIG_PINCTRL_SAMSUNG?

Yes, this would be better. I will fix this.

>
> Yours,
> Linus Walleij

Thanks,
Thomas.
