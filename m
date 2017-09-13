From: horms@verge.net.au (Simon Horman)
Date: Wed, 13 Sep 2017 09:36:03 +0200
Subject: [PATCH 0/5] ARM: dts: rcar-gen2: Add reset control properties
In-Reply-To: <1505135399-24840-1-git-send-email-geert+renesas@glider.be>
References: <1505135399-24840-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170913073602.GD6756@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 11, 2017 at 03:09:54PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series describes the reset topology on all R-Car Gen2 Socs, like
> was done before for R-Car Gen3 and RZ/G1.
> 
> Resets usually match the corresponding module clocks.  Exceptions are:
>   - The audio module has resets for the Serial Sound Interfaces only,
>   - The display module has only a single reset for all DU channels, but
>     adding reset properties for the display is postponed upon request from
>     Laurent.
> 
> Note that this patch series contains hardware description only.
> Actual reset policy is to be defined and implemented separately.
> Also, this is an optional feature, to be enabled explicitly using
> CONFIG_RESET_CONTROLLER=y.  When enabled, an on-SoC device can be reset
> easily using device_reset(), or by using the reset_control_*() API when
> more fine-grained control is desired.
> 
> Possible use cases are (not exhaustive):
>   - Reset a device before use, to make sure it's in a predefined state, and
>     doesn't depend on earlier configuration by e.g. the boot loader,
>   - Reset a device after detecting an anomaly,
>   - Reset a device to verify suspend/resume is handled correctly by the
>     driver in case the device would be part of a power domain on a
>     different/future SoC.
> 
> This has been tested on r8a7790/lager, r8a7791/koelsch, r8a7792/blanche,
> and r8a7794/alt (r8a7793/gose was offline).
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (5):
>   ARM: dts: r8a7790: Add reset control properties
>   ARM: dts: r8a7791: Add reset control properties
>   ARM: dts: r8a7792: Add reset control properties
>   ARM: dts: r8a7793: Add reset control properties
>   ARM: dts: r8a7794: Add reset control properties

Thanks, applied.
