From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Nov 2013 19:33:02 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <20131121175822.GA9590@quad.lixom.net>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131121162944.F087FC406A3@trevor.secretlab.ca>
 <20131121175822.GA9590@quad.lixom.net>
Message-ID: <201311211933.03106.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 November 2013, Olof Johansson wrote:
> On Thu, Nov 21, 2013 at 04:29:44PM +0000, Grant Likely wrote:
>
> > We are pushing a lot of boundaries and doing things on ACPI that have
> > never been done before. SPI, GPIOs, Clocks, Regulators, composite
> > devices, key-value properties. All brand new territory, and the Linux
> > world is driving a lot of it.
> 
> This is a bit of a surprise and a significant concern.
> 
> The whole point behind ACPI is that it's supposed to abstract away nearly
> all of that, and not expose clocks, regulators and other things to
> the kernel. If we're going to expose it, then we might as well go all
> the way and do it with DT.

I think you are talking about different things here: Grant's example was
about embedded x86 adding these so they can reuse the kernel infrastructure
we already have without changing their entire firmware, which I think is
fine, but he also said in the past that we wouldn't have that on PC-style
ARM servers. Other people are pushing for that though (for SoC-style
ARM servers I suppose), as Russell mentioned earlier.

	Arnd
