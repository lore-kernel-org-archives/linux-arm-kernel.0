From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jan 2014 19:58:57 +0100
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <1390190215-22700-2-git-send-email-olof@lixom.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
Message-ID: <201401201958.57997.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 January 2014, Olof Johansson wrote:
> 
> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
> +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
> +  - clock with name "card_ext_clock": External clock provided to the card

I wonder whether the reset line should use the generic reset controller binding
rather than the gpio binding. There has been a recent discussion about a
gpio-reset driver, which should generalize this at the reset level, and
it would make it possible to use reset controllers that are not gpio driven.
In general, any gpio can be used as a reset, but not every reset line can
be a gpio. I don't know whether anyone would use an internal reset-controller
for an external SDIO chip though, so maybe your approach is sufficient.

	Arnd
