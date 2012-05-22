From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 May 2012 09:00:02 +0100
Subject: [PATCH 15/16] ARM: ux500: Add regulator support for nomadik-i2c
 into the db8500 Device Tree
In-Reply-To: <CACRpkdanT17H4VV1AzaYN0wnsFKJTVhw0ZT+o3nP9v=gpKdyAQ@mail.gmail.com>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-16-git-send-email-lee.jones@linaro.org>
 <CACRpkdanT17H4VV1AzaYN0wnsFKJTVhw0ZT+o3nP9v=gpKdyAQ@mail.gmail.com>
Message-ID: <4FBB4782.9090101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/12 22:45, Linus Walleij wrote:
> On Fri, May 18, 2012 at 10:39 AM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Now we have full ab8500 and db8500-prcmu regulator support within DT
>> we can easily reference them from within each of the consumer's nodes.
>> Here we reference the ones used by each of the Nomadic I2C controllers.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> I'm hesitant about this. It seems to be going about things the wrong way
> to have the platform device take a voltage domain regulator.

This doesn't change the behavior of the current system, only DT:s it.

It's just that:

> struct regulator_consumer_supply db8500_vape_consumers[] = {
>         REGULATOR_SUPPLY("v-i2c", "nmk-i2c.0")

In drivers/mfd/db8500-prcmu.c is replaced by:

> v-i2c-supply = <&db8500_vape_reg>;

In the Device Tree.

If we want to start re-working things, can we do it after the DT 
enablement please?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
