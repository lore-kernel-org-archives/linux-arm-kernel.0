From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Dec 2016 16:13:36 -0600
Subject: [PATCH 6/6] watchdog: ts4600: add driver for TS-4600 watchdog
In-Reply-To: <20161214231237.17496-7-sebastien.bourdelin@savoirfairelinux.com>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
 <20161214231237.17496-7-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20161219221336.cnvcxin34hdasndp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 06:12:36PM -0500, Sebastien Bourdelin wrote:
> This watchdog is instantiated in a FPGA and can only be access using a
> GPIOs bit-banged bus, called the NBUS by Technologic Systems.
> The watchdog is made of only one register, called the feed register.
> Writing to this register will re-arm the watchdog for a given time (and
> enable it if it was disable). It can be disabled by writing a special
> value into it.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
>  .../devicetree/bindings/watchdog/ts4600-wdt.txt    |  16 ++
>  arch/arm/boot/dts/imx28-ts4600-common.dtsi         |   5 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/watchdog/Kconfig                           |  10 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/ts4600_wdt.c                      | 213 +++++++++++++++++++++
>  5 files changed, 245 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
>  create mode 100644 drivers/watchdog/ts4600_wdt.c
