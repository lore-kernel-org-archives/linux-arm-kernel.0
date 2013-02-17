From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 17 Feb 2013 18:00:44 +0800
Subject: [PATCH v8 06/12] pinctrl: single: create new gpio function range
In-Reply-To: <20130213183931.GL7144@atomide.com>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-7-git-send-email-haojian.zhuang@linaro.org>
 <20130213183931.GL7144@atomide.com>
Message-ID: <CAD6h2NTWonSVAgnnz70FwB50yKejKj1zVFjUzqn2SmQBzb0VpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 February 2013 02:39, Tony Lindgren <tony@atomide.com> wrote:
> * Haojian Zhuang <haojian.zhuang@linaro.org> [130211 09:15]:
>> Since gpio driver could create gpio range in DTS, it could invokes
>> pinctrl_request_gpio(). In the pinctrl-single driver, it needs to
>> configure pins with gpio function mode.
>
> Minor typo above: s/invokes/invoke/
>
I'll fix it.

>> A new gpio function range should be created in DTS file in below.
>>
>> pinctrl-single,gpio-range = <phandle pin_offset nr_pins gpio_func>;
>>
>> range: gpio-range {
>>       #pinctrl-single,gpio-range-cells = <3>;
>> };
>>
>> The gpio-ranges property is used in gpio driver and the
>> pinctrl-single,gpio-range property is used in pinctrl-single driver.
>>
>> 1. gpio-ranges = <phandle gpio_offset_in_chip pin_offset nr_pins>
>>       gpio-ranges = < &pmx0 0 89 1 &pmx0 1 89 1 &pmx0 2 90 1
>>                       &pmx0 3 90 1 &pmx0 4 91 1 &pmx0 5 92 1>;
>
> I think the second gpio-ranges above should be really
> pinctr-single,gpio-range instead of gpio-ranges?
>

No, it's not pinctrl-single,gpio-range property. I list both two properties are
here, since I need to explain the difference between gpio-ranges &
pinctrl-single,gpio-range.

Thanks
Haojian

>> 2. gpio driver could get pin offset from gpio-ranges property.
>>    pinctrl-single driver could get gpio function mode from gpio_func
>>    that is stored in @gpiofuncs list in struct pcs_device.
>>    This new pinctrl-single,gpio-range is used as complement for
>>    gpio-ranges property in gpio driver.
>
> Other than that looks OK to me. Assuming the other related GPIO patches
> are fine and don't cause changes to this:
>
> Acked-by: Tony Lindgren <tony@atomide.com>
