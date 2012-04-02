From: stigge@antcom.de (Roland Stigge)
Date: Mon, 02 Apr 2012 16:02:17 +0200
Subject: [PATCH 0/7]: arm: lpc32xx: Device tree support
In-Reply-To: <201204021345.04512.arnd@arndb.de>
References: <1333371364-21347-1-git-send-email-stigge@antcom.de>
 <201204021345.04512.arnd@arndb.de>
Message-ID: <4F79B169.5010909@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 04/02/2012 03:45 PM, Arnd Bergmann wrote:
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>
> Looks good overall.

Thanks for your mails, I'm just integrating your suggestions.

> I notice that you are missing the bindings for irq and gpio, which
> tend to be
> quite important. Do you have another tree that has all the lpc32xx
> specific
> parts or are these still under heavy development?

Yes, still under development. GPIO is subject to an open minor issue
(will post an RFC later), and irq is part of the main mach-lpc32xx dt
switch - I have DT-irq already working, but I need to OF'ize lcd and usb
to complete.

> Do you plan to add DT support in parallel to the ATAGS based board you
> already have, or do you plan to move everything over quickly?

For the LPC32xx specific things, including arch/arm/mach-lpc32xx, I will
switch over to DT quickly, eliminating phy3250.c by replacing with a
respective dts file.

The other subsystems changes (pnx*) can and should be dual DT/non-DT to
support other platforms and users who still use it in a non-DT way.

> In the latter case, it might be helpful to get Acks from the subsystem
> maintainers and merge everything through arm-soc.

Yes, sounds reasonable regarding the LPC32xx specific bits like wdt and
adc. Is there sth. I can do about it?

Thanks all,

Roland
