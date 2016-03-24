From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Mar 2016 13:58:21 +0100
Subject: [PATCH 2/3] ARM64: dts: amlogic: add Hardkernel ODROID-C2
In-Reply-To: <1458758013-11890-2-git-send-email-khilman@baylibre.com>
References: <1458758013-11890-1-git-send-email-khilman@baylibre.com>
 <1458758013-11890-2-git-send-email-khilman@baylibre.com>
Message-ID: <8055578.HDz4P7ZJ9W@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 March 2016 11:33:32 Kevin Hilman wrote:
> +/ {
> +       compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
> +       model = "Hardkernel ODROID-C2";
> +       
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       memory at 0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x80000000>;
> +       };
> +};
> +
> +&uart_AO {
> +       status = "okay";
> +};
> 

Shouldn't this also add the serial0 alias?

It seems that the .dtsi file accidentally sets an alias to a disabled
device, which isn't really valid. Can you fix that when adding the
.dts?

	Arnd
