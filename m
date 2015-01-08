From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 8 Jan 2015 12:18:19 +0100
Subject: [PATCH] ARM: mediatek: dts: Add UART dts for MT8127 and MT8135
 boards
In-Reply-To: <1420460918-24380-1-git-send-email-eddie.huang@mediatek.com>
References: <1420460918-24380-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <CABuKBeLy5pg6GJNsE2ArszaG3k2DX1Ao3RA=1EjT3dHUQxui2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,

2015-01-05 13:28 GMT+01:00 Eddie Huang <eddie.huang@mediatek.com>:
> This patch enable UART for MT8127 moose board and MT8135 evalution board.
> Adding the dts, these two boards can show log and shell prompts.
> This patch base on my previous MT8135/MT8127 SoC UART dtsi patch [1] and
> Matthias's modification to disable SoC UART by default.

I applied this patch deleting this two lines and the reference. From
my understanding this is extra information about the patch depends on
the actual development process and should normally be in the cover
letter but not in the patch description itself.

Thanks,
Matthias

>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/312311.html
>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8127-moose.dts | 4 ++++
>  arch/arm/boot/dts/mt8135-evbp1.dts | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt8127-moose.dts b/arch/arm/boot/dts/mt8127-moose.dts
> index 13cba0e..073e295 100644
> --- a/arch/arm/boot/dts/mt8127-moose.dts
> +++ b/arch/arm/boot/dts/mt8127-moose.dts
> @@ -23,3 +23,7 @@
>                 reg = <0 0x80000000 0 0x40000000>;
>         };
>  };
> +
> +&uart0 {
> +       status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/mt8135-evbp1.dts b/arch/arm/boot/dts/mt8135-evbp1.dts
> index a5adf97..3667738 100644
> --- a/arch/arm/boot/dts/mt8135-evbp1.dts
> +++ b/arch/arm/boot/dts/mt8135-evbp1.dts
> @@ -23,3 +23,7 @@
>                 reg = <0 0x80000000 0 0x40000000>;
>         };
>  };
> +
> +&uart3 {
> +       status = "okay";
> +};
> --
> 1.8.1.1.dirty
>



-- 
motzblog.wordpress.com
