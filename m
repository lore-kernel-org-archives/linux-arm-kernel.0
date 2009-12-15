From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 16 Dec 2009 09:24:21 +1300
Subject: GPIO support for HTC Dream
In-Reply-To: <20091215194725.GH24406@elf.ucw.cz>
References: <20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EA@mi8nycmail19.Mi8.com>
	<20091214064545.GK5114@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE19090200E9E6@mi8nycmail19.Mi8.com>
	<20091215194725.GH24406@elf.ucw.cz>
Message-ID: <4B27F075.5000908@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> Hi!
> 
>>> +int gpio_to_irq(unsigned gpio)
>>> +{
>>> +	return -EINVAL;
>>> +}
>> This should probably just be an inline function in
>> arch/arm/mach-msm/include/mach/gpio.h
> 
> Well, it is not performance critical in any way and it is likely to
> change in future. I'd leave it here.

If this function eventually does do something interesting, it would be
useful to have it as a macro in arch/arm/mach-msm/include/mach/gpio.h
since it can be used for static/define declarations, ie:

#define SOME_GPIO_IRQ gpio_to_irq(SOME_GPIO)

>>> +extern int gpio_to_irq(unsigned gpio);
>> This should probably be an inline as mentioned above.
>>
>> For completeness you should probably also add:
>>
>> static inline int irq_to_gpio(unsigned irq)
>> {
>> 	return -EINVAL;
>> }
> 
> I'd say that would be overdoing it.

You should implement this if you have gpio_to_irq because it is part of
the API, see include/linux/gpio.h

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
