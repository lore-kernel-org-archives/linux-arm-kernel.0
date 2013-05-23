From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 23 May 2013 06:27:08 +0000
Subject: [PATCH 02/11] gpio: davinci: coding style correction
In-Reply-To: <519CC142.7050301@cogentembedded.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-3-git-send-email-avinashphilip@ti.com>
 <519CC142.7050301@cogentembedded.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EAC7AE3@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 18:29:46, Sergei Shtylyov wrote:
> Hello.
> 
> On 22-05-2013 11:10, Philip Avinash wrote:
> 
> > 1. Corrects coding and commenting styles
> > 2. Variables name change to meaningful name
> > 3. Remove unnecessary variable usage
> > 4. Add BINTEN macro definition
> >
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> > ---
> >   drivers/gpio/gpio-davinci.c |  182 +++++++++++++++++++++----------------------
> >   1 file changed, 89 insertions(+), 93 deletions(-)
> 
> > diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> > index 17df6db..d308955 100644
> > --- a/drivers/gpio/gpio-davinci.c
> > +++ b/drivers/gpio/gpio-davinci.c
> [...]
> > @@ -31,10 +31,11 @@ struct davinci_gpio_regs {
> >   	u32	intstat;
> >   };
> >
> > +#define BINTEN	0x08 /* GPIO Interrupt Per-Bank Enable Register */
> 
>     Empty line needed here.

Ok, I will add.

> 
> >   #define chip2controller(chip)	\
> >   	container_of(chip, struct davinci_gpio_controller, chip)
> >
> [...]
> > @@ -98,8 +94,8 @@ static int davinci_direction_in(struct gpio_chip *chip, unsigned offset)
> >   	return __davinci_direction(chip, offset, false, 0);
> >   }
> >
> > -static int
> > -davinci_direction_out(struct gpio_chip *chip, unsigned offset, int value)
> > +static int davinci_direction_out(struct gpio_chip *chip, unsigned offset,
> > +		int value)
> 
>      This line should be aligned under the next character after (.

Will remove this change as Russel pointed out.

> 
> [...]
> > @@ -113,22 +109,22 @@ davinci_direction_out(struct gpio_chip *chip, unsigned offset, int value)
> [...]
> >   /*
> >    * Assuming the pin is muxed as a gpio output, set its output value.
> >    */
> > -static void
> > -davinci_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> > +static void davinci_gpio_set(struct gpio_chip *chip, unsigned offset,
> > +		int value)
> 
>      Same here.

I will remove this change as Russel pointed out.

> 
> [...]
> > @@ -368,16 +363,16 @@ static int __init davinci_gpio_irq_setup(void)
> [...]
> >   	for (gpio = 0, bank = 0; gpio < ngpio; bank++, gpio += 32) {
> > -		chips[bank].chip.to_irq = gpio_to_irq_banked;
> > -		chips[bank].irq_base = soc_info->gpio_unbanked
> > -			? -EINVAL
> > -			: (soc_info->intc_irq_num + gpio);
> > +		ctlrs[bank].chip.to_irq = gpio_to_irq_banked;
> > +		ctlrs[bank].irq_base = soc_info->gpio_unbanked ?
> > +			-EINVAL : (soc_info->intc_irq_num + gpio);
> 
>     () not needed here.

Ok will remove in next version ().

Thanks
Avinash

> 
> WBR, Sergei
> 
> 
