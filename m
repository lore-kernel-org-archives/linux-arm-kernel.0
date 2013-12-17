From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 17 Dec 2013 15:57:16 -0800
Subject: [PATCH v5 2/2] ARM: mach-moxart: add MOXA ART SoC device tree
 files
In-Reply-To: <1387294714-12872-3-git-send-email-jonas.jensen@gmail.com>
References: <1387294714-12872-1-git-send-email-jonas.jensen@gmail.com>
 <1387294714-12872-3-git-send-email-jonas.jensen@gmail.com>
Message-ID: <532508e4-1b5f-46ba-9519-7a3e019e251b@CH1EHSMHS014.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonas,

On Tue, Dec 17, 2013 at 04:38:34PM +0100, Jonas Jensen wrote:
> Add a generic (dtsi) include file for MOXA ART SoCs.
> 
> Also add a file for UC-7112-LX.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/moxart.txt |  12 ++
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/moxart-uc7112lx.dts            |  93 +++++++++++++
>  arch/arm/boot/dts/moxart.dtsi                    | 167 +++++++++++++++++++++++
>  4 files changed, 273 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/moxart.txt
>  create mode 100644 arch/arm/boot/dts/moxart-uc7112lx.dts
>  create mode 100644 arch/arm/boot/dts/moxart.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/moxart.txt b/Documentation/devicetree/bindings/arm/moxart.txt
> new file mode 100644
> index 0000000..11087ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/moxart.txt
> @@ -0,0 +1,12 @@
> +MOXA ART device tree bindings
> +
> +Boards with the MOXA ART SoC shall have the following properties:
> +
> +Required root node property:
> +
> +compatible = "moxa,moxart";
> +
> +Boards:
> +
> +- UC-7112-LX: embedded computer
> +  compatible = "moxa,moxart-uc-7112-lx", "moxa,moxart"
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c55a22d..ae3d7db 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -319,6 +319,7 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
>  dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb \
>  	zynq-zc706.dtb \
>  	zynq-zed.dtb
> +dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
I think these targets are sorted alphabetically. You should insert the
MOXART target at the appropriate location a little further up.

	S?ren
