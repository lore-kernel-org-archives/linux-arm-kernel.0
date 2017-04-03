From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 03 Apr 2017 08:44:16 -0700
Subject: [PATCH v3 0/4] tty/serial: meson_uart: add support for core clock
 handling
In-Reply-To: <20170331165437.26227-1-hgkr.klein@gmail.com> (Helmut Klein's
 message of "Fri, 31 Mar 2017 18:54:33 +0200")
References: <20170331165437.26227-1-hgkr.klein@gmail.com>
Message-ID: <m2lgrha433.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Helmut Klein <hgkr.klein@gmail.com> writes:

> To be able to use the three none AO uarts of the meson gx SoCs (uart_A,

s/none/non/

> uart_B & uart_C), the core clock has to be enabled (see chapter 22.3 of
> the public s905 data sheet).
> At least the u-boot of my s905 based media player (netxeon minimx-g)
> doesn't do this. so the driver must enable the clock.

FYI: even if a booloader enablesq clocks, it's important that the kernel
enable clocks that it uses so the kernel can be independent of any
bootloader.

> This patch set does:
> - exposes the UART clock ids to the dtb
> - adds documentation for the dt-bindings of meson_uart
> - adds the core clock handling to the driver
> - adds the core clock handling to meson-gxbb.dtsi and meson-gxl.dtsi
>
> The patchset is based on the branch "master" of the repository in [1]

The master branch in my tree just tracks mainline master branch.

To avoid conflicts with other on-going DT changes, the DT patches should
probably be based on top of my v4.12/dt64 branch.

Kevin
