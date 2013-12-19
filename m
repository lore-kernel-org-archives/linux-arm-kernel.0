From: sre@ring0.de (Sebastian Reichel)
Date: Thu, 19 Dec 2013 18:17:33 +0100
Subject: [PATCH/RFC] ARM: omap3: Split the pinmux core device
In-Reply-To: <1386177110-26424-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1386177110-26424-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20131219171732.GB24230@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 06:11:50PM +0100, Laurent Pinchart wrote:
> The omap3_pmx_core pinmux device in the device tree handles the system
> controller module (SCM) PADCONFS fonction. Its control registers are
> split in two distinct areas, with other SCM registers in-between. Those
> other registers can't thus be requested by other drivers as the memory
> region gets reserved by the pinmux driver.
> 
> Split the omap3_pmx_core device tree node in two for the two memory
> regions.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts | 45 ++++++++++++++++++++++++++++-------
>  arch/arm/boot/dts/omap3-beagle.dts    | 28 +++++++++++++++-------
>  arch/arm/boot/dts/omap3-igep0020.dts  | 26 ++++++++++----------
>  arch/arm/boot/dts/omap3-zoom3.dts     | 19 ++++++++++-----
>  arch/arm/boot/dts/omap3.dtsi          | 13 +++++++++-
>  5 files changed, 95 insertions(+), 36 deletions(-)
> 
> While working on the OMAP3 ISP driver I've run into a failure to request a
> memory region already requested by the pinctrl-single driver. This patch is an
> attempt to fix the problem. An alternative approach would be to support
> multiple reg values in the pinctrl-single driver, but that might not be much
> cleaner. I'm open to suggestions.

Acked-By: Sebastian Reichel <sre@debian.org>

I haven't checked the board dts files, but the change in omap3.dtsi is
needed to "fix a external abort on non-linefetch" when doing

cat /sys/kernel/debug/pinctrl/.../pins

on my Nokia N900.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131219/5d083b77/attachment.sig>
