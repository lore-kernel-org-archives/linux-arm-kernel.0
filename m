From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2018 06:43:30 -0800
Subject: [PATCH v2] ARM: dts: replace gpio-key, wakeup with wakeup-source
 property
In-Reply-To: <20181105134225.24146-1-sudeep.holla@arm.com>
References: <20181105134225.24146-1-sudeep.holla@arm.com>
Message-ID: <20181105144330.5zkg4qkacb6afpcm@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 01:42:25PM +0000, Sudeep Holla wrote:
> Most of the legacy "gpio-key,wakeup" and "enable-sdio-wakeup" boolean
> properties are already replaced with "wakeup-source". However few
> occurrences of old property has popped up again, probably from the
> remnants in downstream trees. Almost all of those were remove couple
> of years back.
> 
> Replace those legacy properties with the unified "wakeup-source"
> property.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Peter Rosin <peda@axentia.se>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 2 +-
>  arch/arm/boot/dts/at91-wb45n.dts            | 2 +-
>  arch/arm/boot/dts/at91-wb50n.dts            | 4 ++--
>  arch/arm/boot/dts/imx6q-pistachio.dts       | 2 +-
>  arch/arm/boot/dts/imx6sll-evk.dts           | 2 +-
>  arch/arm/boot/dts/zynq-zturn.dts            | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> Hi ARM SoC Team,
> 
> Though it's more a cleanup, I prefer if this can be pushed as fix
> to avoid more duplication in downstream as well as having to split into
> 3 different patches.

Is there a reason you're not fixing up xilinx on arm64 while you're at it? Sort
of defeats the purpose of removing all usage of it.


-Olof
