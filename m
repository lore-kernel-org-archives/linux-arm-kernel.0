From: greg@kroah.com (Greg KH)
Date: Sat, 20 May 2017 10:45:31 +0200
Subject: [PATCH 2/2] ARM: dts: am335x-sl50: Fix cannot claim requested
 pins for spi0
In-Reply-To: <20170519165144.11508-2-enric.balletbo@collabora.com>
References: <20170519165144.11508-1-enric.balletbo@collabora.com>
 <20170519165144.11508-2-enric.balletbo@collabora.com>
Message-ID: <20170520084531.GB4284@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 06:51:44PM +0200, Enric Balletbo i Serra wrote:
> We don't need to bitbang these pins anymore, instead we muxed these
> pins as SPI, after this change, done in commit 6c69f726, we introduced
> the following error:
> 
>  pinctrl-single 44e10800.pinmux: pin PIN85 already requested \
>  by 44e10800.pinmux; cannot claim for 48030000.spi
>  pinctrl-single 44e10800.pinmux: pin-85 (48030000.spi) status -22
> 
> Fixes: 6c69f726 ("ARM: dts: am335x-sl50: Enable SPI0 interface and Flash Memory")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  arch/arm/boot/dts/am335x-sl50.dts | 4 ----
>  1 file changed, 4 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
