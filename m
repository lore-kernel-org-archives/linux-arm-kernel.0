From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 13 Oct 2015 10:18:59 +0200
Subject: [PATCH 4/5] arm: dts: lpc32xx: remove unneeded cell settings from
 cpus
In-Reply-To: <1444694045-22000-5-git-send-email-vz@mleia.com>
References: <1444694045-22000-1-git-send-email-vz@mleia.com>
 <1444694045-22000-5-git-send-email-vz@mleia.com>
Message-ID: <CAGhQ9VwBcUxZr7A57feuUNs0OcNpHn4wwmGommVg6e-B0=tsBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 13 October 2015 at 01:54, Vladimir Zapolskiy <vz@mleia.com> wrote:
> There is no addressable devices under cpus device node, remove noisy
> address and size cells properties.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/boot/dts/lpc32xx.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> index dcb52cb..929458d 100644
> --- a/arch/arm/boot/dts/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -18,9 +18,6 @@
>         interrupt-parent = <&mic>;
>
>         cpus {
> -               #address-cells = <0>;
> -               #size-cells = <0>;
> -

According to Documentation/devicetree/bindings/arm/cpus.txt these
properties are required.

Take a look at Example 3 in the doc for it should look like on a ARM
926EJ-S uniprocessor 32-bit system.


regards,
Joachim Eastwood
