From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Wed, 23 Jan 2013 14:06:12 -0300
Subject: [PATCH v2 1/3] arm: mvebu: Add support for USB host controllers
 in Armada 370/XP
In-Reply-To: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CALF0-+W8dVLHF66VKni+5ZsQpFd=cGDXE0TD=dRc1B=ptrAMUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Wed, Jan 23, 2013 at 12:26 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> The Armada 370 and Armada XP SoC has an Orion EHCI USB controller.
> This patch adds support for this controller in Armada 370
> and Armada XP SoC common device tree files.
>
> Cc: Lior Amsalem <alior@marvell.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Tested-by: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Changes from v1:
>  * Remove uneeded USB_ARCH_HAS_EHCI selection as noted by Florian.
>
>  arch/arm/boot/dts/armada-370-xp.dtsi |   15 +++++++++++++++
>  arch/arm/boot/dts/armada-370.dtsi    |    9 +++++++++
>  arch/arm/boot/dts/armada-xp.dtsi     |   17 +++++++++++++++++
>  3 files changed, 41 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 28276fe..fa025c4 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -145,6 +145,21 @@
>                         clocks = <&gateclk 17>;
>                         status = "disabled";
>                 };
> +
> +               usb at d0050000 {
> +                       compatible = "marvell,orion-ehci";
> +                       reg = <0xd0050000 0x500>;
> +                       interrupts = <45>;
> +                       status = "disabled";
> +               };
> +
> +               usb at d0051000 {
> +                       compatible = "marvell,orion-ehci";
> +                       reg = <0xd0051000 0x500>;
> +                       interrupts = <46>;
> +                       status = "disabled";
> +               };
> +
>         };
>  };
>
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 88f9bab..8188d13 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -144,5 +144,14 @@
>                                 dmacap,memset;
>                         };
>                 };
> +
> +               usb at d0050000 {
> +                       clocks = <&coreclk 0>;
> +               };
> +
> +               usb at d0051000 {
> +                       clocks = <&coreclk 0>;
> +               };
> +
>         };
>  };
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 2e37ef1..c22a0c8 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -134,5 +134,22 @@
>                                 dmacap,memset;
>                         };
>                 };
> +
> +               usb at d0050000 {
> +                       clocks = <&gateclk 18>;
> +               };
> +
> +               usb at d0051000 {
> +                       clocks = <&gateclk 19>;
> +               };
> +
> +               usb at d0052000 {
> +                       compatible = "marvell,orion-ehci";
> +                       reg = <0xd0052000 0x500>;
> +                       interrupts = <47>;
> +                       clocks = <&gateclk 20>;
> +                       status = "disabled";
> +               };
> +
>         };
>  };
> --
> 1.7.8.6
>

Do you think we're still in time to get this series into v3.9 (given
we decide soon on the OpenBlocks issue)?

Thanks,

-- 
    Ezequiel
