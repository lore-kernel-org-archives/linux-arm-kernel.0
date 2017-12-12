From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Dec 2017 23:24:05 +0000
Subject: [PATCH] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register
In-Reply-To: <874lovg095.fsf@belgarion.home>
References: <E1eOTFj-0008MB-Fj@rmk-PC.armlinux.org.uk>
 <874lovg095.fsf@belgarion.home>
Message-ID: <20171212232405.GG10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 09:27:34PM +0100, Robert Jarzmik wrote:
> Russell King <rmk+kernel@armlinux.org.uk> writes:
> 
> > Add a gpio driver for the lubbock miscellaneous write IO register so we
> > can take advantage of subsystems modelled around gpiolib, rather than
> > having to provide platform specific callbacks.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Hi Russell and Linux,
> 
> It looks certainly good to me. It's unfortunate in the current status of
> linux-next I have, gpio-reg.c seems broken (that one is for Linus in [1] and
> [2]), and therefore I can't test it live.

It won't do much on its own without some patches to make use of the new
GPIOs... but it will be used as the direct register write becomes a
call to gpio-reg's ->set_multiple() method.

Further patches will be switching various bits over to using gpiod
stuff for some sa11x0/pxa bits, and on some platforms completely
eliminating the legacy "board control register" manipulations and
hacks spread around the kernel tree.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
