From: jenskuske@gmail.com (Jens Kuske)
Date: Sat, 09 May 2015 11:17:51 +0200
Subject: [PATCH 3/6] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <1430986247.8171.37.camel@x220>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>	
 <1430904693-1404-4-git-send-email-jenskuske@gmail.com>
 <1430986247.8171.37.camel@x220>
Message-ID: <554DD0BF.9080108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/05/15 10:10, Paul Bolle wrote:
> On Wed, 2015-05-06 at 11:31 +0200, Jens Kuske wrote:
>> --- a/drivers/pinctrl/sunxi/Kconfig
>> +++ b/drivers/pinctrl/sunxi/Kconfig
>  
>> +config PINCTRL_SUN8I_H3
>> +	def_bool MACH_SUN8I
>> +	select PINCTRL_SUNXI_COMMON
> 
>> --- a/drivers/pinctrl/sunxi/Makefile
>> +++ b/drivers/pinctrl/sunxi/Makefile
> 
>> +obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
> 
> PINCTRL_SUN8I_H3 is a bool symbol, so pinctrl-sun8i-h3.o will never be
> part of a module, right?
> 
> (Note that PINCTRL_SUN8I_H3 appears to be an alias for MACH_SUN8I. Ie,
> these two symbols operate in lockstep.)
> 
>> --- /dev/null
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
> 
>> +#include <linux/module.h>
> 
>> +MODULE_DEVICE_TABLE(of, sun8i_h3_pinctrl_match);
> 
>> +MODULE_AUTHOR("Jens Kuske <jenskuske@gmail.com>");
>> +MODULE_DESCRIPTION("Allwinner H3 pinctrl driver");
>> +MODULE_LICENSE("GPL");
> 
> This adds some module specific boilerplate. Was it perhaps your
> intention to make PINCTRL_SUN8I_H3 a tristate symbol?
> 

I don't know to be honest, I just followed the pattern of all the other
pinctrl-sun?i-*.c files. But it sounds logical that this is needless
in the current state.

Looks like it got introduced when splitting up the driver:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/251712.html

Maybe there were plans to use separate modules some day. If not, we
should remove it from the other files as well I guess. Maxime, could
you please comment on that?

Regards,
Jens
