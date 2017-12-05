From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 09:19:06 +0100
Subject: [PATCH v2] sunxi-rsb: Include OF based modalias in device uevent
In-Reply-To: <CAGb2v67GF1JTDT9ip2OzycwN6euBu9QqLBLwkyUKD6D8Bs873Q@mail.gmail.com>
References: <53cb17f5-6077-419a-8e5c-6c80f9dfa9dc@rwthex-w2-a.rwth-ad.de>
 <20171128154734.v2yog6lwiombv3io@flea.home>
 <CAGb2v67GF1JTDT9ip2OzycwN6euBu9QqLBLwkyUKD6D8Bs873Q@mail.gmail.com>
Message-ID: <20171205081906.gqafcm4hesiawsvp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 03:28:25PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Nov 28, 2017 at 11:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Nov 27, 2017 at 08:05:34PM +0100, Stefan Br?ns wrote:
> >> Include the OF-based modalias in the uevent sent when registering devices
> >> on the sunxi RSB bus, so that user space has a chance to autoload the
> >> kernel module for the device.
> >>
> >> Fixes a regression caused by commit 3f241bfa60bd ("arm64: allwinner: a64:
> >> pine64: Use dcdc1 regulator for mmc0"). When the axp20x-rsb module for
> >> the AXP803 PMIC is built as a module, it is not loaded and the system
> >> ends up with an disfunctional MMC controller.
> >>
> 
> Tags should be:
> 
> Fixes: d787dcdb9c8f ("bus: sunxi-rsb: Add driver for Allwinner Reduced
> Serial Bus")
> Cc: stable <stable@vger.kernel.org> # 4.4.x 7a3b7cd332db of: device:
> Export of_device_{get_modalias, uvent_modalias} to modules
> 
> >> Cc: stable <stable@vger.kernel.org>
> >> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> >
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> Maxime, could you merge this as a fix to get it in fast?

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/cddf8e2f/attachment.sig>
