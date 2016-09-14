From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 14 Sep 2016 23:30:06 +0200
Subject: [PATCH v2 3/6] phy: meson: add USB2 PHY support for Meson8b and
 GXBB
In-Reply-To: <20160911134111.31141-4-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-4-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCAJnhOSt8KHcPn4Wpc1DL6S3EUWViQxbsjw7Cv0TDNBPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 11, 2016 at 3:41 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> This is a new driver for the USB PHY found in Meson8b and GXBB SoCs.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/phy/Kconfig          |  11 ++
>  drivers/phy/Makefile         |   1 +
>  drivers/phy/phy-meson-usb2.c | 280 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 292 insertions(+)
>  create mode 100644 drivers/phy/phy-meson-usb2.c
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 19bff3a..6ad87ec 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -453,4 +453,15 @@ config PHY_NS2_PCIE
>         help
>           Enable this to support the Broadcom Northstar2 PCIe PHY.
>           If unsure, say N.
> +
> +config PHY_MESON_USB2
> +       tristate "Meson USB2 PHY driver"
> +       default ARCH_MESON
> +       depends on OF && (ARCH_MESON || COMPILE_TEST)
> +       select GENERIC_PHY
as pointed out by Arnd Bergmann (see [0]) this is missing a "select
USB_COMMON", just like the PHY_SUN4I_USB and PHY_SUN9I_USB drivers as
we use of_usb_get_dr_mode_by_phy() to get the mode of the USB
controller (as the PHY needs special configuration for host-mode).

I will send an update on Sunday.


Regards,
Martin


[0] http://marc.info/?l=linux-usb&m=147386117604824&w=2
