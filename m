From: stigge@antcom.de (Roland Stigge)
Date: Sat, 07 Apr 2012 16:19:04 +0200
Subject: [PATCH v2] gpio: Device tree support for LPC32xx
In-Reply-To: <4F80460E.50605@antcom.de>
References: <1333497518-25838-1-git-send-email-stigge@antcom.de>
 <20120407035327.9D7923E246E@localhost> <4F80460E.50605@antcom.de>
Message-ID: <4F804CD8.70803@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/12 15:50, Roland Stigge wrote:
> Hi Grant,
...

> Please consider how the groups are specified in
> drivers/gpio/gpio-lpc32xx.c. They each have different numbers of lines
> and GPIO / GPI / GPO functionality. So they also have different callback
> sets, and we need to do separate gpiochip_add()s which leads to the
> separate gpio-bank specifications in the dtsi file. Separate enabling of
> those banks via OF are a nice by-product.

And BTW: This also corresponds nicely with how the LPC32xx hardware
calls its GPIOs, e.g. GPO 3 for GPO #3 in the gpo group.

Thanks for considering,

Roland
