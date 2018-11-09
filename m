From: jbrunet@baylibre.com (jbrunet at baylibre.com)
Date: Fri, 09 Nov 2018 14:17:20 +0100
Subject: [PATCH v3 3/3] ARM64: dts: meson-gxl: Add support for the
 Smartlabs SML-5442TW
In-Reply-To: <1541706240-30036-4-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-4-git-send-email-christianshewitt@gmail.com>
Message-ID: <d923e31b63a5d4c4d67a274b8ef9555cd25f8bff.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-11-08 at 23:43 +0400, Christian Hewitt wrote:
> +/* This will enable the bluetooth module */
> +&gpio {
> +       bt-en {
> +               gpio-hog;
> +               gpios = <GPIOX_17 GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "bt-en";
> +       };
> +};

Instead of this, is it possible to use the driver provided by
drivers/bluetooth/hci_qca.c ?
