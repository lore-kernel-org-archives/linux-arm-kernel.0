From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 17 Jun 2014 18:37:04 +0200
Subject: [PATCH 2/2] ARM: dts: Add cros_ec to exynos5420-peach-pit and
 exynos5800-peach-pi
In-Reply-To: <1402683213-23120-2-git-send-email-dianders@chromium.org>
References: <1402683213-23120-1-git-send-email-dianders@chromium.org>
 <1402683213-23120-2-git-send-email-dianders@chromium.org>
Message-ID: <53A06EB0.909@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2014 08:13 PM, Doug Anderson wrote:
> This adds cros_ec to exynos5420-peach-pit and exynos5800-peach-pi,
> including:
> * The keyboard
> * The i2c tunnel
> * The tps65090 under the i2c tunnel
> * The battery under the i2c tunnel
> 
> To add extra motivation, it should be noted that tps65090 is one of
> the things needed to get display-related FETs turned on for pit and
> pi.
> 
> Note that this relies on a few outstanding changes:
> * Needs "cros-ec-keyboard.dtsi" in order to compile properly.  See
>   (ARM: dts: Create a cros-ec-keyboard fragment) at
>   <https://patchwork.kernel.org/patch/4297451/>.
> * Needs (mfd: cros_ec: spi: Fix end of transfer on devices with no
>   spi-msg-delay) from this series to work properly.
> * Needs (spi: s3c64xx: fix broken "cs_gpios" usage in the driver) and
>   (spi: s3c64xx: for DT platofrms always get the chipselect info from
>   DT node) to work properly and match the documented bindings.  See
>   <https://patchwork.kernel.org/patch/4346701/> and
>   <https://patchwork.kernel.org/patch/4346711/>
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 146 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 146 +++++++++++++++++++++++++++++
>  2 files changed, 292 insertions(+)
> 

After applying all the dependencies and this patch, I see that cros-ec-spi
driver is probed and also the keyboard is working on my Peach pit when testing
with: $ evtest /dev/input/event0

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
