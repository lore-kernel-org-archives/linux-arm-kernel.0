From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 5 Jun 2017 14:13:42 +0900
Subject: [PATCH v5 12/20] ARM: dts: uniphier: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <20170523133448.4794-13-javier@dowhile0.org>
References: <20170523133448.4794-1-javier@dowhile0.org>
 <20170523133448.4794-13-javier@dowhile0.org>
Message-ID: <CAK7LNATDvesYLKimY=aKfT6kAiidq6Ufd=kCWGQcCZ_Xy-27tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

2017-05-23 22:34 GMT+09:00 Javier Martinez Canillas <javier@dowhile0.org>:
> The at24 driver allows to register I2C EEPROM chips using different vendor
> and devices, but the I2C subsystem does not take the vendor into account
> when matching using the I2C table since it only has device entries.
>
> But when matching using an OF table, both the vendor and device has to be
> taken into account so the driver defines only a set of compatible strings
> using the "atmel" vendor as a generic fallback for compatible I2C devices.
>
> So add this generic fallback to the device node compatible string to make
> the device to match the driver using the OF device ID table.
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>
> ---
>
> Changes in v5:
> - Only replace atmel variant but keep other EEPROM vendors (Geert Uytterhoeven).
>
> Changes in v4:
> - Only use the atmel manufacturer in the compatible string instead of
>   keeping the deprecated ones (Rob Herring).
>
> Changes in v3: None
> Changes in v2: None
>
>  arch/arm/boot/dts/uniphier-pro4-ace.dts    | 2 +-
>  arch/arm/boot/dts/uniphier-pro4-sanji.dts  | 2 +-
>  arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)


Why didn't you touch
arch/arm/boot/dts/uniphier-ref-daughter.dtsi ?



BTW, has the driver change merged?



-- 
Best Regards
Masahiro Yamada
