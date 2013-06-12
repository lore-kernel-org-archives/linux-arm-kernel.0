From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 13:38:49 +0200
Subject: [PATCHv4 0/9] Add I2C support for Allwinner SoCs
In-Reply-To: <3315236.ZNXhyxmCRd@wuerfel>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <3315236.ZNXhyxmCRd@wuerfel>
Message-ID: <20130612113849.GG16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jun 12, 2013 at 01:26:56PM +0200, Arnd Bergmann wrote:
> On Wednesday 12 June 2013 10:07:09 Maxime Ripard wrote:
> > 
> > This patchset adds support for the I2C controller found on most of the
> > Allwinner SoCs, especially the already supported A10 and A13, and the
> > yet to come A31.
> > 
> > This driver leverages the Marvel mv64xxx i2c controller driver, that has
> > an almost identical logic, with a slightly different register layout.
> > 
> > It has been tested on a A13-Olinuxino and an A10s-Olinuxino.
> 
> It doesn't really matter, but can someone clarify why this driver can
> be reused? Did marvell and allwinner license the same hardware block
> or is just a really simple driver that does things in an obvious way?

The Marvell and Allwinner controllers share the exact same logic (which
is definitely not trivial), based on a finite state machine that
triggers interrupts at each change of state, each state being a state in
the I2C protocol (like address sent, data received with an ACK, etc.).

The weird thing is that the only difference between the two controllers
is the register offsets, and that's it. The state numbers, bit index,
etc, are exactly the same.

So yes, I think they both licensed the same IP.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
