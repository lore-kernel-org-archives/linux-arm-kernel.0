From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 28 Aug 2018 17:11:40 +0200
Subject: [PATCH 0/3] arm64: dts: allwinner: a64: pinmux cleanups
In-Reply-To: <20180828100132.12975-1-wens@csie.org>
References: <20180828100132.12975-1-wens@csie.org>
Message-ID: <20180828151140.7vc44czdlv4yhan2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 06:01:29PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> This series does some cleanup of the Allwinner A64 pinmux groups.
> 
> The first addresses a limitation on the A64 where we have the eMMC's
> DS in always muxed in. The DS pin is shared with SPI0's MISO, thereby
> preventing SPI0 from being used. In this patch we split out the DS
> pin into a separate group for boards that actually utilize it to
> select on their own.
> 
> The other two patches just rename pinmux group node names and labels
> from <func>_pins_<[a-z]> to <func>_<pingroup/pin names>_pins. The latter
> is the style we adopted later on, and is easier to know which pins they
> correspond to, i.e. easier to review.
> 
> Please have a look.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

> While I want to do some more cleanup, I realized that the label and/or
> node names might be used by distro (Armbian comes to mind) or personal
> device tree overlay files. Do we need to have these remain fixed? Do
> we or can we provide a fallback? (Is that even possible?)

I wouldn't worry too much about this. We broke it a number of times
already, and we probably will in the future for other stuff, I'm not
sure we have to provide any guarantee there, as long as the old,
compiled, dt still works.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180828/cca1a80d/attachment.sig>
