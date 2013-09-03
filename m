From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 4 Sep 2013 00:17:44 +0900
Subject: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
In-Reply-To: <201309010315.49763.sergei.shtylyov@cogentembedded.com>
References: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
 <201309010315.49763.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoQFYFva9msdoEWdU2Z7_=jOtZwvXgL7OqUKhVMO3NOPzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 1, 2013 at 8:15 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the generic R8A777x part of the Ether device node.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/boot/dts/r8a7778.dtsi |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7778.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7778.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7778.dtsi
> @@ -98,4 +98,15 @@
>                 reg = <0xfffc000 0x118>;
>                 #gpio-range-cells = <3>;
>         };
> +
> +       ether: ethernet at fde00000 {
> +               device_type = "network";
> +               compatible = "renesas,ether-r8a7779";

Hi Sergei,

Thanks for your patch. What's the reason behind the r8a7778 SoC using
a compatible string for r8a7779 like "renesas,ether-r8a7779"?

It seems that you assume that the r8a7778 ethernet controller is 100%
compatible with r8a7779. Is that really true? For earlier versions the
sh_eth hardware documentation was anything but accurate, so it seems
to me that it must be more safe that r8a7778 would be using
"renesas,ether-r8a7778". What do you think?

Thanks,

/ magnus
