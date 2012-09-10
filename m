From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Sep 2012 13:23:20 -0600
Subject: [PATCH 2/2] ARM: dts: exynos4: allow i2c0 bus to be configured
 using pinctrl interface
In-Reply-To: <CAJuYYwSC6nvs4eJ7GOTD2Ti8EvcTPPGZ7Fj7reT2eY65nvq22Q@mail.gmail.com>
References: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
 <1346923381-14144-3-git-send-email-thomas.abraham@linaro.org>
 <5320531.svfjn4BD9X@amdc1227>
 <CAJuYYwSC6nvs4eJ7GOTD2Ti8EvcTPPGZ7Fj7reT2eY65nvq22Q@mail.gmail.com>
Message-ID: <504E3E28.8030004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 05:14 AM, Thomas Abraham wrote:
> On 6 September 2012 15:43, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Thomas,
>>
>> On Thursday 06 of September 2012 14:53:01 Thomas Abraham wrote:
>>>               compatible = "samsung,s3c2440-i2c";
>>>               reg = <0x13860000 0x100>;
>>>               interrupts = <0 58 0>;
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&i2c0_bus>;
>>
>> If pinctrl-names property is omitted then the state index is used as a name
>> (e.g. pinctrl-0 would be named "0"). Maybe it would be better to use this
>> approach (with respective adjustment in first patch)? What do you think?
> 
> I tend to prefer to name the states because it is easier to
> cross-reference code and dts files. i2c was a simple one, but for mmc
> controllers, there will 1-bit state, 4-bit state and 8-bit state, and
> it will be nicer to name then accordingly. So I prefer to use names
> but if there is wider consensus on not using names, we can drop names.

I would only expect to see multiple states defined in a single board
.dts file /if/ runtime muxing is required. Given MMC doesn't runtime
mux, I wouldn't expect there to be multiple states for different bus
widths; it's just that the "default" state would point at whatever
single configuration is appropriate for the board.
