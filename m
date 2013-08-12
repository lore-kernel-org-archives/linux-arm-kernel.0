From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Aug 2013 14:12:36 +0100
Subject: [PATCH V4 1/4] ARM: dts: exynos5420: add i2s controllers
In-Reply-To: <3916118.YsNJ4NTaJS@amdc1227>
References: <1376302070-1877-1-git-send-email-padma.v@samsung.com>
 <21180092.af8YMiXtjc@amdc1227>
 <20130812113447.GW6427@sirena.org.uk> <3916118.YsNJ4NTaJS@amdc1227>
Message-ID: <20130812131235.GX6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 01:41:23PM +0200, Tomasz Figa wrote:
> On Monday 12 of August 2013 12:34:48 Mark Brown wrote:

> > I'd expect that to interact badly with the pinmuxing - unless the device
> > is disabled it'll try to grab its pins on probe which is not going to be
> > a good idea unless it is actually wired up for use in the system.  Or is
> > there some other mechanism for handling that?

> Ah, good point. Now I wonder whether pinctrl nodes shouldn't be considered 
> board-specific and specified in board-level dts instead?

It seems a bit cleaner to use the current mechanism in that it stops the
device appearing at all and hence repeated efforts to probe, plus a
simple enable is less error prone, the way these SoCs are designed you
don't have to pick which pinmux is in use for most of the IPs.  Where
there are multiple options it does seem like a good approach though.

Tastes may differ though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/80389ac4/attachment-0001.sig>
