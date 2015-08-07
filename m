From: dianders@chromium.org (Doug Anderson)
Date: Fri, 7 Aug 2015 14:31:02 -0700
Subject: [PATCH v2 1/2] ARM: dts: rockchip: reserve unusable memory region
 on rk3288
In-Reply-To: <1763907.pckMEaRNPs@diego>
References: <1763907.pckMEaRNPs@diego>
Message-ID: <CAD=FV=Vo0tQO-KdCLbcJF-yYEgwGbjEx3qvvnv7jgAKcVA4p+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Thu, Aug 6, 2015 at 10:33 AM, Heiko St?bner <heiko@sntech.de> wrote:
> The all current Rockchip SoCs supporting 4GB of ram have problems accessing
> the memory region 0xfe000000~0xff000000. This also seems to includes the
> rk3368 arm64 soc.
>
> All current code handling dma memory oddities I could find, seem to involve
> soc-specific code (zone-dma or so) while this issue is shared between arm32
> and arm64 socs from Rockchip, which would need to have this described in
> the soc devicetree on both socs.
>
> Limiting the dma-zone alone also does not solve the issue and as the
> dma-masks need to be a power-of-two in the kernel, the next lower dma-mask
> brings memory usable for dma down to 2GB.
>
> So as a stop-gap block off the affected region to prevent its use by
> devices with 4GB of memory, like some recent Chromebooks.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v1:
> - expand reasons for the reserved memory
>
>  arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

As discussed earlier, I'm now convinced that this is an appropriate
stopgap.  ...and the description looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
