From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jul 2016 22:07:05 +0200
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
In-Reply-To: <20160727104623.e9ca7b708e5c6462f44a5d01@free.fr>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
 <20160727104623.e9ca7b708e5c6462f44a5d01@free.fr>
Message-ID: <20160728200705.GG6682@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 10:46:23AM +0200, Jean-Francois Moine wrote:
> On Tue, 26 Jul 2016 22:30:28 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > ere is the previous A64 patches made by Andre [1], reworked to use
> > the new sunxi-ng clock framework.
> > 
> > This uses the current H3 clock code, as both are really similar. The
> > first patches are just meant to rework slightly the H3 code, before
> > introducing the A64-related patches.
> > 
> > Some WiP stuff have been removed, such as the MMC part, but this serie
> > already has a decent amount of devices supported: uart, i2c, rsb, etc.
> > 
> > Let me know what you think,
> 
> I don't see the interest to have common code for 32bits and 64bits.
> The clock driver of a SoC will never evolve, so, it is simpler to
> copy the source common with the H3 into a clean A64 clock driver.

I'm not sure why 32 bits vs 64 bits matters here. We're going to share
a significant number of drivers already between armv7 and armv8, like
MMC, EMAC, I2C, and so on.

And I expect to share the data in other SoCs for the A10, A13 and A20
for example, or A23/A33, which have a lot of clocks in common too.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160728/0246c7fb/attachment.sig>
