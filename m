From: robh+dt@kernel.org (Rob Herring)
Date: Sun, 13 Nov 2016 18:07:59 -0600
Subject: [PATCH v2 06/19] ARM: dts: armada-370-xp: Fixup bootrom DT warning
In-Reply-To: <20161113212402.3060-7-gregory.clement@free-electrons.com>
References: <20161113212402.3060-1-gregory.clement@free-electrons.com>
 <20161113212402.3060-7-gregory.clement@free-electrons.com>
Message-ID: <CAL_JsqKDrbGOhbNqQT5Wq-MQOOuAbq1Z0JzzSGgCfrx5Ex8K0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2016 at 3:23 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> bootrom has a reg property so the unit name should contain an address.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370.dtsi | 2 +-
>  arch/arm/boot/dts/armada-xp.dtsi  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 079494e52554..7598fb013355 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -65,7 +65,7 @@
>         soc {
>                 compatible = "marvell,armada370-mbus", "simple-bus";
>
> -               bootrom {
> +               bootrom at 01_e0_0 {

Please add documentation as to what the unit address format is.
Really, since you claim compatibility with simple-bus, you should not
deviate from the simple-bus format.

Drop the leading zero and use ',' not '_'. I know the DT spec / ePAPR
allows more, but convention is more restricted.

Rob

>                         compatible = "marvell,bootrom";
>                         reg = <MBUS_ID(0x01, 0xe0) 0 0x100000>;
>                 };
