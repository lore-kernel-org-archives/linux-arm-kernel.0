From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 04 Apr 2017 00:54:43 +0200
Subject: [PATCH v2 0/5] Add ARM Mali Midgard device tree bindings and gpu
 node for rk3288
In-Reply-To: <cover.1491118230.git.guillaume.tucker@collabora.com>
References: <cover.1491118230.git.guillaume.tucker@collabora.com>
Message-ID: <1587425.dbD1NUOEYx@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guillaume,

please keep in mind to also add me (as Rockchip maintainer) as recipient in 
further submissions - as also listed by scripts/get_maintainer.pl.


Thanks
Heiko

Am Sonntag, 2. April 2017, 08:59:43 CEST schrieb Guillaume Tucker:
> The ARM Mali Midgard GPU kernel driver is only available
> out-of-tree and is not going to be merged in its current form.
> However, it would be useful to have its device tree bindings
> merged.  In particular, this would enable distributions to create
> working driver packages (dkms...) without having to patch the
> kernel.
> 
> The bindings for the earlier Mali Utgard GPU family have already
> been merged, so this is essentially the same scenario but for
> newer GPUs (Mali-T604 ~ Mali-T880).
> 
> This series of patches first imports the bindings from the latest
> driver release with some clean-up then adds a gpu node for the
> rk3288 SoC.  This was successfully tested on Radxa Rock2 Square,
> Firefly, Veyron Minnie and Jerry boards board using Mali kernel
> driver r16p0 and r12p0 user-space binary.
> 
> Changes since v1:
> - enabled gpu on rk3288-veyron boards
> 
> Enric Balletbo i Serra (1):
>   ARM: dts: rockchip: enable ARM Mali GPU on rk3288-veyron
> 
> Guillaume Tucker (4):
>   dt-bindings: gpu: add bindings for the ARM Mali Midgard GPU
>   ARM: dts: rockchip: add ARM Mali GPU node for rk3288
>   ARM: dts: rockchip: enable ARM Mali GPU on rk3288-rock2-som
>   ARM: dts: rockchip: enable ARM Mali GPU on rk3288-firefly
> 
>  .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 53
> ++++++++++++++++++++++ arch/arm/boot/dts/rk3288-firefly.dtsi              |
>  5 ++
>  arch/arm/boot/dts/rk3288-rock2-som.dtsi            |  5 ++
>  arch/arm/boot/dts/rk3288-veyron.dtsi               |  5 ++
>  arch/arm/boot/dts/rk3288.dtsi                      | 23 ++++++++++
>  5 files changed, 91 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> 
> --
> 2.11.0
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
