From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Nov 2013 21:45:29 +0100
Subject: [PATCH RESEND 3/5] ARM: brcmstb: add misc. DT bindings for brcm,
 brcmstb
In-Reply-To: <52910BFD.2010900@gmail.com>
References: <529003BB.9030604@gmail.com> <201311231937.38235.arnd@arndb.de>
 <52910BFD.2010900@gmail.com>
Message-ID: <201311232145.30203.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 November 2013, Marc C wrote:
> Hello Arnd,
> 
> > Normally the "compatible" string identifies the register layout and
> > you keep the offsets in the device driver. Do you have strong reasons to do it
> > differently here?
> 
> The register block that contains the reset registers also contains other
> ?general purpose? registers, which can potentially scoot the positions
> of both ?sw-master-reset? and ?reset-source-enable?. Although we do
> stress to the H/W designers that consistency between chips is important,
> and that relative offsets of those registers should remain the same
> between chip revisions, there is no guarantee that this will happen.
> 
> Now, rather than handling N revisions of the ?sun-top-ctrl? register
> block at both the boot loader and kernel levels (N could get very large
> as we continue to port support for more chips), I feel that a more
> flexible solution would be to rely on the self-describing nature of the DT.

Ok, I see. I guess it's not even a uniform layout within the registers
then, right? Otherwise you could reference the number of the reset
register through the reset-api, but it gets kind of ugly when passing
the wrong value for a reset line touches a completely unrelated register
rather than "just" resetting the wrong device.

	Arnd
