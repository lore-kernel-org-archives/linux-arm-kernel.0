From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 6 Mar 2017 17:12:52 +0100
Subject: [PATCH 0/3] Khadas VIM support (Amlogic Meson GXL S905X)
In-Reply-To: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
References: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
Message-ID: <ffcba782-4200-4a7e-af67-2e23432de1e9@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2017 10:51 PM, Martin Blumenstingl wrote:
> This series adds support for the Khadas VIM and Khadas VIM Pro boards
> (both are provided through a single .dts as the only two differences are
> the eMMC size and different SDIO WIFI chips - both are Broadcom brcmfmac
> based though).
> More details can be found on the official website: [0]
> 
> I have tested this on a Khadas VIM Pro board. It would be nice if someone
> with a non-Pro board could give it a try as well.
> 
> 
> This patchset depends on:
> - "ARM64: defconfig: enable the leds-pwm driver and default-on trigger"
>   see [1] - already merged in v4.12/defconfig of Kevin's Amlogic tree
> - "meson-gxl pinctrl - add the missing PWM pins" see [2]
> - "brcmfmac: add support for BCM43455 with modalias sdio:c00v02D0dA9BF"
>   see [3], this is NOT a direct dependency (it's only required to get
>   WIFI working on the Khadas VIM Pro) and it's already merged for v4.11
>   (commit a62a77881b1b6708ffeddd9bf0529494f7b199e3)
> 
>   
> [0] http://khadas.com/vim/
> [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-February/002474.html
> [2] http://lists.infradead.org/pipermail/linux-amlogic/2017-March/002658.html
> [3] https://www.spinics.net/lists/linux-mmc/msg41627.html
> 
> Martin Blumenstingl (3):
>   devicetree: add vendor prefix for Khadas
>   dt-bindings: amlogic: add the Khadas VIM
>   ARM64: dts: meson-gxl: add support for the Khadas VIM board
> 
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   2 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     | 114 +++++++++++++++++++++
>  4 files changed, 118 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> 

Thanks for the work,
I just tested and it works on a non-pro version,

Tested-by: Neil Armstrong <narmstrong@baylibre.com>

BTW, you should list the other dependencies like the p212 patch.

Neil
