From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 May 2015 11:18:22 +0200
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <1432285588.3929.28.camel@pengutronix.de>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <2282066.NWoIT9ZyLc@wuerfel>
 <CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>
 <13641152.Yt4ZI3oT6L@wuerfel>
 <CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>
 <1432285588.3929.28.camel@pengutronix.de>
Message-ID: <20150522091822.GF8557@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 11:06:28AM +0200, Philipp Zabel wrote:
> > In the probe function, it would check the number of reg resources.
> > If a single resource is passed, it would take it, else it would look
> > the one named "reset".
> > The driver and bindings would be the same for the two families, and
> > the bindings would be backward compatible with sunxi ones.
> > 
> > Philip, Arnd, what do you think?
> 
> I'm not a fan of describing the register layout in the device tree as
> detailed as the sunxi bindings do. I'd prefer the reg property to
> describe the device's register address space with one entry per
> contiguous block of registers.

That's exactly what we do.

> Unifying the mostly identical drivers is a good idea though, and reusing
> preexisting bindings is better than inventing new ones. I favor the
> socfpga binding, but I still like the sunxi bindings and this proposal
> better than encoding the register offset in the reset index.

I don't really get the difference between the socfpga and our bindings
actually. Would you mind to explain a bit further what you don't like
about it ?

Maxime
-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/fa7eac4f/attachment.sig>
