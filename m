From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 23 May 2013 06:27:09 +0000
Subject: [PATCH 02/11] gpio: davinci: coding style correction
In-Reply-To: <20130522144042.GG18614@n2100.arm.linux.org.uk>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-3-git-send-email-avinashphilip@ti.com>
 <20130522144042.GG18614@n2100.arm.linux.org.uk>
Message-ID: <518397C60809E147AF5323E0420B992E3EAC7AE8@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 20:10:42, Russell King - ARM Linux wrote:
> On Wed, May 22, 2013 at 12:40:25PM +0530, Philip Avinash wrote:
> >  /*
> >   * Assuming the pin is muxed as a gpio output, set its output value.
> >   */
> > -static void
> > -davinci_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> > +static void davinci_gpio_set(struct gpio_chip *chip, unsigned offset,
> > +		int value)
> 
> This kind of stuff is just churn.  If you read Documentation/CodingStyle:
> 
> Statements longer than 80 columns will be broken into sensible chunks, unless
> exceeding 80 columns significantly increases readability and does not hide
> information. Descendants are always substantially shorter than the parent and
> are placed substantially to the right. The same applies to function headers
> with a long argument list. However, never break user-visible strings such as
> printk messages, because that breaks the ability to grep for them.
> 
> "broken into sensible chunks".  Here's the question: is the former a
> sensible format?  Arguably it is because it results in all the arguments
> fitting on one line at the expense of missing the return value.
> 
> The latter is also a sensible format - but breaks the arguments instead
> of the return value.
> 
> Both formats can be found in their entirety by grep by function name alone:
> 
> 	grep -1 davinci_gpio_set
> 
> or if you prefer to type some more then you end up with more specific
> 
> 	grep -A1 davinci_gpio_set
> or
> 	grep -B1 davinci_gpio_set
> 
> depending on the version.
> 
> Where there's no clear advantage one way or the other, let the authors
> preference stand.

Ok I understood and I will remove these changes in next version.

Thanks
Avinash

> 
