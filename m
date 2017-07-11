From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 11 Jul 2017 12:38:06 +0900
Subject: [PATCH 9/9] ARM: multi_v7_defconfig: Enable DMA for Renesas
 serial ports
In-Reply-To: <1499693302-25120-10-git-send-email-geert+renesas@glider.be>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
 <1499693302-25120-10-git-send-email-geert+renesas@glider.be>
Message-ID: <CANqRtoSi8x7zqwV3Gp_n0dBe4Uw6LDRvC1Lheu+GrLZNYuxAHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Mon, Jul 10, 2017 at 10:28 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> DMA for (H)SCIF(A|B) serial ports on Renesas R-Car Gen2 and RZ/G1 SoCs
> is considered stable, hence enable it by default.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index ea2075d8e185f7aa..072a455008df9751 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -330,6 +330,7 @@ CONFIG_SERIAL_IMX_CONSOLE=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_SERIAL_SH_SCI_NR_UARTS=20
>  CONFIG_SERIAL_SH_SCI_CONSOLE=y
> +CONFIG_SERIAL_SH_SCI_DMA=y
>  CONFIG_SERIAL_MSM=y
>  CONFIG_SERIAL_MSM_CONSOLE=y
>  CONFIG_SERIAL_VT8500=y

Thanks, FWIW I'm very happy to see DMA enabled for the SCIF driver in mainline.

Since enabling DMA Engine still keeps PIO support around I wonder why
we need this Kconfig at all - other drivers seem to get by without
this kind of thing?
So in my opinion it would also be nice to get rid of SERIAL_SH_SCI_DMA
completely and reducing the number of special per-driver Kconfig
entries.

Cheers,

/ magnus
