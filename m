From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 11:34:40 +0200
Subject: [PATCH 1/2] ARM: dts: fix RealView EB SMSC ethernet version
In-Reply-To: <1473327032-31852-1-git-send-email-linus.walleij@linaro.org>
References: <1473327032-31852-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <2936732.fO5Ya4c2gz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 11:30:32 AM CEST Linus Walleij wrote:
> -       /* SMSC 9118 ethernet with PHY and EEPROM */
> +       /* SMSC LAN91C111 ethernet with PHY and EEPROM */
>         ethernet: ethernet at 4e000000 {
> -               compatible = "smsc,lan9118", "smsc,lan9115";
> +               compatible = "smsc,lan91c111";
>                 reg = <0x4e000000 0x10000>;
> -               phy-mode = "mii";
>                 reg-io-width = <4>;

The reg-io-width here needs to be 6 or 7, it's a mask of the possible
access widths, and as Russell pointed out it has to include 16-bit
accesses at least, but probably 8-bit access should also be enabled.

	Arnd
