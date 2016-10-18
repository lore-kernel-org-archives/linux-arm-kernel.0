From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 18 Oct 2016 12:23:19 -0400
Subject: [BUG] LPC32xx gpio driver broken by commit 762c2e46 in 4.9-rc1
Message-ID: <1476807799.10214.25.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir, Linus, Alexandre,

the current LPC32xx GPIO driver is broken by commit 762c2e46
(gpio: of: remove of_gpiochip_and_xlate() and struct gg_data).

A call to "of_get_named_gpio" to retrieve the GPIO will
always return -EINVAL, except for the first GPIO bank.

Prior to this commit, the driver was working properly
because of the side-effect of the match function called by
"gpiochip_find" inside "of_get_named_gpiod_flags" function.

I think, the proper long-term solution is to replace the
LPC32xx GPIO driver; an initial version was previously
submitted, by Vladimir Zapolskiy, to the mailing list:
http://www.spinics.net/lists/linux-gpio/msg09746.html

Is there any short-term solution that can be done with
the existing driver to keep the LPC32xx platform working
properly in the 4.9 mainline kernel?


Regards,
Sylvain Lemieux


 
