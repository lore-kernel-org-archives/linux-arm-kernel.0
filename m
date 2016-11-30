From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 23:25:26 +0100
Subject: [PATCH v3 0/2] Support for Axentia TSE-850
In-Reply-To: <1480510102-24587-1-git-send-email-peda@axentia.se>
References: <1480510102-24587-1-git-send-email-peda@axentia.se>
Message-ID: <5198068.r9o6jcztHW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 30, 2016 1:48:20 PM CET Peter Rosin wrote:
> Hi!
> 
> changes v2 -> v3
> - document the new compatible strings prefixed with "axentia,".
> 
> changes v1 -> v2
> - squash the fixup into the correct patch, sorry for the noise.
> 
> After finally having all essintial drivers upstreamed (the
> last ones are currently in -next) I would like to have the
> dts and the defconfig also upstreamed.
> 
> Cheers,
> Peter
> 
> Peter Rosin (2):
>   ARM: dts: add devicetree for the Axentia TSE-850
>   ARM: tse850_defconfig: add Axentia TSE-850
> 
>  Documentation/devicetree/bindings/arm/axentia.txt |  19 ++
>  MAINTAINERS                                       |   8 +
>  arch/arm/boot/dts/Makefile                        |   1 +
>  arch/arm/boot/dts/axentia-linea.dtsi              |  53 +++++
>  arch/arm/boot/dts/axentia-tse850-3.dts            | 276 ++++++++++++++++++++++
>  arch/arm/configs/tse850_defconfig                 | 223 +++++++++++++++++
>  6 files changed, 580 insertions(+)

Hi Peter,

I'm a bit confused. Are these just boards using the sama5d31 SoC,
or something else?

Normally, dts files are picked up by the SoC platform maintainers
and named with a prefix for that soc.

Also, we don't normally add a defconfig file for a specific
machine, just add the options you want to sama5_defconfig
and multi_v7_defconfig, and send all patches to the
at91 maitainers.

	Arnd
