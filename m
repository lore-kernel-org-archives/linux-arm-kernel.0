From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 7 Aug 2014 13:01:43 +0900
Subject: [PATCH] ARM: shmobile: koelsch: add VIN1/ADV7180 DT support
In-Reply-To: <2131152.vMTPsJUYLQ@wasted.cogentembedded.com>
References: <201408020402.14560.sergei.shtylyov@cogentembedded.com>
 <2131152.vMTPsJUYLQ@wasted.cogentembedded.com>
Message-ID: <CANqRtoQhr-7RjZTxdk_e--if7ruSPQzyoGOR7VEy2saih64duw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thanks for your patch.

On Thu, Aug 7, 2014 at 3:38 AM,  <sergei.shtylyov@cogentembedded.com> wrote:
> Define the Koelsch board dependent part of the VIN1 device node. Add the device
> node for Analog  Devices ADV7180  video decoder to  I2C2 bus. Add the necessary
> subnodes to interconnect VIN1 and ADV7180 devices.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against the 'renesas-devel-v3.16-20140804' tag of Simon Horman's
> 'renesas.git' repo. It requires the 'soc_camera' and 'rcar_vin' device tree
> support patches (already merged to the 'media_tree.git' repo) in order to work.
>
>  arch/arm/boot/dts/r8a7791-koelsch.dts |   35 ++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -289,6 +289,11 @@
>                 renesas,groups = "usb1";
>                 renesas,function = "usb1";
>         };
> +
> +       vin1_pins: vin1 {
> +               renesas,groups = "vin1_data8", "vin1_clk";
> +               renesas,function = "vin1";
> +       };
>  };

Quick question: Does this pin description match to the board layout? I
suspect that clock and data by themselves are not enough.

I'm not sure about Koelsch, but  in case of older SoCs using the CEU
there were signals used like horizontal and vertical sync and
sometimes even something that was used to determine interlace.

Thanks,

/ magnus
