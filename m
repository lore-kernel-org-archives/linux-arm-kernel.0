From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Jun 2017 12:05:40 +0200
Subject: [PATCH] gpio: mvebu: fix regmap_update_bits usage
In-Reply-To: <20170609120435.60191c76@free-electrons.com> (Thomas Petazzoni's
 message of "Fri, 9 Jun 2017 12:04:35 +0200")
References: <20170609100318.26450-1-gregory.clement@free-electrons.com>
 <20170609120435.60191c76@free-electrons.com>
Message-ID: <87zidho4qz.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On ven., juin 09 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Fri,  9 Jun 2017 12:03:18 +0200, Gregory CLEMENT wrote:
>
>>  	regmap_update_bits(mvchip->regs, GPIO_IO_CONF_OFF,
>> -			   BIT(pin), 1);
>> +			   BIT(pin), BIT(pin));
>>  
>>  	return 0;
>>  }
>> @@ -364,7 +364,7 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
>>  	mvebu_gpio_set(chip, pin, value);
>>  
>>  	regmap_update_bits(mvchip->regs, GPIO_IO_CONF_OFF,
>> -			   BIT(pin), 0);
>> +			   BIT(pin), BIT(pin));
>
> Are you sure here? We want to clear the bit, so I guess the 0 is
> appropriate, no?

argh!

yes it was a mistake

Gregory

>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
