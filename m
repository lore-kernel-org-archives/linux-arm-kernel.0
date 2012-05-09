From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 09 May 2012 11:22:46 +0100
Subject: [PATCH 02/15] ARM: ux500: Remove unused i2c platform_data
 initialisation code
In-Reply-To: <CACRpkdZ70FasMuTTgBe68xaePB-4UNZ0W44BCxDve7fqXYT+vg@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ70FasMuTTgBe68xaePB-4UNZ0W44BCxDve7fqXYT+vg@mail.gmail.com>
Message-ID: <4FAA4576.1020106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/12 09:46, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Now that u5500 is obsolete, u8500 is the only user of the Nomadik
>> i2c driver.
>
> Well actually arch/arm/mach-nomadik has this block too,
> but it's not making use of it right now, so why not.
>
>> As such there is no requirement to differentiate between
>> initialisation values. By the time a new SoC is released, almost all
>> of the ux500 platform will be DT:ed, so we can make decisions based
>> on the compatible property instead.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> So why not copy the contents of arch/arm/plat-nomadik/include/plat/i2c.h
> into drivers/i2c/busses/i2c-nomadik.c and delete that header from
> plat at the same time?
>
> Then there sure is no way for platforms to sneak in any platform
> data any other way.

I have no problem in doing that. Can I submit a separate patch?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
