From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Aug 2013 12:34:48 +0100
Subject: [PATCH V4 1/4] ARM: dts: exynos5420: add i2s controllers
In-Reply-To: <21180092.af8YMiXtjc@amdc1227>
References: <1376302070-1877-1-git-send-email-padma.v@samsung.com>
 <1376302070-1877-2-git-send-email-padma.v@samsung.com>
 <21180092.af8YMiXtjc@amdc1227>
Message-ID: <20130812113447.GW6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 01:14:20PM +0200, Tomasz Figa wrote:
> On Monday 12 of August 2013 15:37:47 Padmavathi Venna wrote:

> > +	i2s_0: i2s at 03830000 {
> > +		status = "disabled";

> If a node does not require any board-specific properties for the device to 
> operate properly, there is no point in disabling it, just to add a single 
> status property at board level.

I'd expect that to interact badly with the pinmuxing - unless the device
is disabled it'll try to grab its pins on probe which is not going to be
a good idea unless it is actually wired up for use in the system.  Or is
there some other mechanism for handling that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/b14ff50a/attachment.sig>
