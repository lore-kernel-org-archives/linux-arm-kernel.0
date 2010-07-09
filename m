From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Fri, 9 Jul 2010 17:16:52 +0200
Subject: [PATCH 3/5] U6715 gpio platform driver This driver is
	U6XXX	platform generic
In-Reply-To: <20100709115748.GD22845@n2100.arm.linux.org.uk>
References: <1278316742-11219-1-git-send-email-philippe.langlais@stericsson.com>
	<1278316742-11219-4-git-send-email-philippe.langlais@stericsson.com>
	<20100709115748.GD22845@n2100.arm.linux.org.uk>
Message-ID: <4C373D64.9050905@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Ok, Now I use the IOMEM macro like omap do, it's better.
Just after I send the three U6715 impacted patches.

Thanks

On 07/09/10 13:57, Russell King - ARM Linux wrote:
> On Mon, Jul 05, 2010 at 09:59:00AM +0200, Philippe Langlais wrote:
>    
>> +static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
>> +{
>> +	u32 reg = bank->gpio_base;
>>      
> Virtual addresses are pointers not integers and should be of type
> void __iomem *.  It's unfortunate that writel() and friends don't
> warn about this - but making them do so ends up generating more
> code with some GCC versions.
>
> As I've already suggested, you can get around adding lots of casts
> to void __iomem * to the code by defining an IOMEM macro, which you
> can then use when you define things like GPIOA_PINS_REG.
>    
