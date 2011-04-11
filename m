From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 11 Apr 2011 10:53:24 +0200
Subject: [patch 2/2] Add GPIO DT support to s3c24xx
In-Reply-To: <20110411064719.GD4439@angua.secretlab.ca>
References: <20110410152735.338798127@gmail.com>
	<20110410153316.GC27088@dandreoli.com>
	<20110411064719.GD4439@angua.secretlab.ca>
Message-ID: <BANLkTim+CuRa=zFDFS3Qgwov4TW4NDK-Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 8:47 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Sun, Apr 10, 2011 at 05:33:16PM +0200, Domenico Andreoli wrote:
>>
>> ?arch/arm/plat-s3c24xx/gpiolib.c | ? 45 ++++++++++++++++++++++++++++++++++++++++
>> ?1 file changed, 45 insertions(+)
>>
>> Index: b/arch/arm/plat-s3c24xx/gpiolib.c
>> ===================================================================
>> --- a/arch/arm/plat-s3c24xx/gpiolib.c 2011-04-10 16:24:59.000000000 +0200
>> +++ b/arch/arm/plat-s3c24xx/gpiolib.c 2011-04-10 17:12:32.000000000 +0200
>> @@ -19,6 +19,8 @@
>> ?#include <linux/ioport.h>
>> ?#include <linux/io.h>
>> ?#include <linux/gpio.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>>
>> ?#include <plat/gpio-core.h>
>> ?#include <plat/gpio-cfg.h>
>> @@ -97,6 +99,9 @@
>> ? ? ? ? ? ? ? ? ? ? ? .direction_input ? ? ? ?= s3c24xx_gpiolib_banka_input,
>> ? ? ? ? ? ? ? ? ? ? ? .direction_output ? ? ? = s3c24xx_gpiolib_banka_output,
>> ? ? ? ? ? ? ? },
>> +#ifdef CONFIG_OF_GPIO
>> + ? ? ? ? ? ? .dt_compat = "samsung,s3c2410-gpio-a",
>> +#endif
>
> The '-a' bit I suspect is wrong. ?Aren't all the gpio banks of the same type?

no, the first bank is made of output-only gpio.

-----[ Domenico Andreoli, aka cavok
?--[ http://www.dandreoli.com/gpgkey.asc
?? ---[ 3A0F 2F80 F79C 678A 8936? 4FEE 0677 9033 A20E BC50
