From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 06 Jan 2015 18:37:01 -0300
Subject: [PATCH] spi: orion: Add multiple chip select support for Armada
 370 and 375
In-Reply-To: <1420579846-31962-1-git-send-email-ken.wilson@opengear.com>
References: <1420579846-31962-1-git-send-email-ken.wilson@opengear.com>
Message-ID: <54AC557D.1080605@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2015 06:30 PM, Ken Wilson wrote:
> Create a new dt binding for the Armada 375 that supports up to
> 3 chip selects but uses the same prescaler values and algorithm
> as the basic orion binding.
> 
> Update the Armada 370 so that it supports up to 4 chip selects.
> 
> This has been tested on the Armada 375 with multiple SPI-NOR chips.
> 
> Signed-off-by: Ken Wilson <ken.wilson@opengear.com>
> ---
>  .../devicetree/bindings/spi/spi-orion.txt          |  3 ++-
>  arch/arm/boot/dts/armada-375.dtsi                  |  4 +--
>  drivers/spi/spi-orion.c                            | 29 +++++++++++++++++++---

You will have to split this changeset in three patches, given these
three files carry different kind of changes:

1. The driver change itself
2. The devicetree binding documentation change
3. The devicetree dtsi change

Regards,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
