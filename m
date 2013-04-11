From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 11 Apr 2013 16:47:12 -0600
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <4F47AD08.4030504@ti.com>
 <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org>
 <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost>
 <51391F41.5000303@ti.com>
 <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
 <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
 <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com>
 <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
 <515319D5.20105@wwwdotorg.org>
 <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
 <5155C902.7080207@wwwdotorg.org>
 <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org>
 <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
 <51671D7B.5060303@wwwdotorg.org>
 <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
Message-ID: <51673D70.3010503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 04:16 PM, Linus Walleij wrote:
> On Thu, Apr 11, 2013 at 10:30 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 04/10/2013 03:28 PM, Linus Walleij wrote:
> 
>>> So the only reason I'm rambing on about this is that it breaks the
>>
>> I'm not sure I understand this paragraph; what is "it" in the line above.
>>
>> If "it" is this patch, then should "breaks" be re-establishes?
> 
> No I'm replying to Javier Martinez Canillas mail in this thread:
> http://marc.info/?l=linux-arm-kernel&m=136334655902407&w=2
> which is stating a question to grand, and contains the below
> hunk:
> 
>> +static int gpio_irq_request(struct irq_data *d)
>> +{
>> +       struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
>> +
>> +       return gpio_request(irq_to_gpio(bank, d->irq), "gpio-irq");
>> +}
> 
> irq_to_gpio(). Notice that. not my_funny_driver_irq_to_gpio().

OK, right. sorry for being so confused/confusing.

Yes, that code should certainly call e.g. omap_gpio__irq_to_gpio() not
irq_to_gpio(). Probably gpio_irq_request() wants renaming to something
more like omap_gpio__irq_request() too, so the names don't look like
they'd clash with global functions. (__ added for clarity but probably
only one _ at a time)
