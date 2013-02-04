From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 3 Feb 2013 20:33:15 -0500
Subject: [PATCH] ARM: kirkwood: of_serial: fix clock gating by removing
 clock-frequency
In-Reply-To: <1359493774-27627-1-git-send-email-jason@lakedaemon.net>
References: <1359493774-27627-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20130204013315.GG14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 09:09:34PM +0000, Jason Cooper wrote:
> When DT support for kirkwood was first introduced, there was no clock
> infrastructure.  As a result, we had to manually pass the
> clock-frequency to the driver from the device node.
> 
> Unfortunately, on kirkwood, with minimal config or all module configs,
> clock-frequency breaks booting because of_serial doesn't consume the
> gate_clk when clock-frequency is defined.
> 
> The end result on kirkwood is that runit gets gated, and then the boot
> fails when the kernel tries to write to the serial port.
> 
> Fix the issue by removing the clock-frequency parameter from all
> kirkwood dts files.
> 
> Booted on dreamplug without earlyprintk and successfully logged in via
> ttyS0.
> 
> Reported-by: Simon Baatz <gmbnomis@gmail.com>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/boot/dts/kirkwood-dns320.dts         | 2 --
>  arch/arm/boot/dts/kirkwood-dns325.dts         | 1 -
>  arch/arm/boot/dts/kirkwood-dockstar.dts       | 1 -
>  arch/arm/boot/dts/kirkwood-dreamplug.dts      | 1 -
>  arch/arm/boot/dts/kirkwood-goflexnet.dts      | 1 -
>  arch/arm/boot/dts/kirkwood-ib62x0.dts         | 1 -
>  arch/arm/boot/dts/kirkwood-iconnect.dts       | 1 -
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts | 1 -
>  arch/arm/boot/dts/kirkwood-km_kirkwood.dts    | 1 -
>  arch/arm/boot/dts/kirkwood-lschlv2.dts        | 1 -
>  arch/arm/boot/dts/kirkwood-lsxhl.dts          | 1 -
>  arch/arm/boot/dts/kirkwood-mplcec4.dts        | 1 -
>  arch/arm/boot/dts/kirkwood-nsa310.dts         | 1 -
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts  | 2 --
>  arch/arm/boot/dts/kirkwood-topkick.dts        | 1 -
>  arch/arm/boot/dts/kirkwood.dtsi               | 2 --
>  16 files changed, 19 deletions(-)

Applied to mvebu/fixes with Simon's Tested-by:

thx,

Jason.
