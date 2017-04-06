From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 6 Apr 2017 15:56:40 +0530
Subject: [PATCH 0/2] pmu0 MMIO region for A64 USB PHY
In-Reply-To: <20170405143034.8868-1-icenowy@aosc.io>
References: <20170405143034.8868-1-icenowy@aosc.io>
Message-ID: <dbc88959-57f2-5e6b-0e3d-972dee9e1340@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 05 April 2017 08:00 PM, Icenowy Zheng wrote:
> The USB PHY of A64 contains a "pmu0" MMIO region, which contains some control
> registers for the EHCI0/OHCI0 pair on A64 SoC.
> 
> This pair is not used currently in 4.11, but when enabling it in 4.12, the
> MMIO region is needed.
> 
> In order to prevent device tree compatibility breakage, add this region in
> 4.11.

I feel the binding documentation can go along with the dt changes. Moreover I
have no plans of sending another pull request for this -rc cycle.

FWIW:
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
> 
> Icenowy Zheng (2):
>   dt: bindings: add pmu0 regs for USB PHYs on Allwinner H3/V3s/A64
>   arm64: allwinner: a64: add pmu0 regs for USB PHY
> 
>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 1 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi           | 2 ++
>  2 files changed, 3 insertions(+)
> 
