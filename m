From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Nov 2012 11:24:26 +0000
Subject: [PATCH 3/3] Input: bu21013_ts - Add support for Device Tree
 booting
In-Reply-To: <20121129100808.GW2013@gmail.com>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-4-git-send-email-lee.jones@linaro.org>
 <20121128070332.GC23378@core.coreip.homeip.net>
 <20121128085731.GH2013@gmail.com>
 <20121128163105.GA28698@sirena.org.uk>
 <20121129100808.GW2013@gmail.com>
Message-ID: <20121129112058.GH32691@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 10:08:08AM +0000, Lee Jones wrote:
> On Wed, 28 Nov 2012, Mark Brown wrote:

> > The I2C subsystem guesses at a compatible string by default but it's
> > much better to explicitly set one as conflicts do arise from time to
> > time (eg, Wolfson parts are called WMxxxx but the WM prefix is also used
> > by at least WonderMedia).

> It uses the exact device name, rather than guessing. I don't think
> you're allowed to have duplicate device names in the system, or there
> would be clashes at registration time.

> The system is the same for platform data and DT alike.

Right, which is why this mostly works, but it's still better to provide
an actual compatible string which we can be 100% certain will avoid
conflicts.  This is very low cost when one is already defining DT
bindings.

> Hence, there should be no need to have a compatible string in any i2c
> driver registration information.

We're getting away with it at present (and frankly nobody's going to
build in two different drivers for a chip of the same name for practical
systems anyway).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121129/999bdc18/attachment.sig>
