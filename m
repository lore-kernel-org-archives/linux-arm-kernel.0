From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Apr 2015 22:35:59 -0600
Subject: [PATCH 3/9] ARM: Make a copy of the 2835 dts for the 2836.
In-Reply-To: <1429639796-2169-4-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-4-git-send-email-eric@anholt.net>
Message-ID: <5539C82F.7000002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 12:09 PM, Eric Anholt wrote:
> This is not hooked up to anything yet, but it means that our later
> 2836-specific changes will be more obvious.  The bcm2836-rpi-2-b.dts
> actually comes from bcm2835-rpi-2-b-plus, which apparently is the
> closest.

>  arch/arm/boot/dts/bcm2836-rpi-2-b.dts | 30 +++++++++++++++++++++
>  arch/arm/boot/dts/bcm2836-rpi.dtsi    | 51 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm2836.dtsi        | 31 +++++++++++++++++++++

So we obviously need a new top-level bcm2836-rpi-2-b.dts for the new
board, and a new bcm2836.dtsi for the new SoC. However, do we really
need to duplicate bcm2836-rpi.dtsi? It should be identical between the
bcm2835/6 RPis, so I'd expect to just rename it to bcm283x-rpi.dtsi and
share it? The include of the SoC .dtsi file could be moved one level up
since that's the one difference?

Eventually, I'd like to get around to revamping the bcm283x DTs so
there's a DT for each separate board model, which would match the DT
filenames that U-Boot is looking for. Still, that's separate from these
patches.
