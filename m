From: joel@jms.id.au (Joel Stanley)
Date: Wed, 14 Dec 2016 19:32:15 +1030
Subject: [PATCH linux v1 4/4] arm: dts: Add dt-binding to support seven
 segment display on zaius
In-Reply-To: <1481702104-8617-5-git-send-email-jaghu@google.com>
References: <1481702104-8617-1-git-send-email-jaghu@google.com>
 <1481702104-8617-5-git-send-email-jaghu@google.com>
Message-ID: <CACPK8Xd0znB0C+P8mstjjSgJWN2T_a0h2jJYG77gVbiZghtCyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jagha,

On Wed, Dec 14, 2016 at 6:25 PM, Jaghathiswari Rankappagounder
Natarajan <jaghu@google.com> wrote:
> Add clock, data and clear signal GPIO lines to control seven segment display on
> zaius platform.
>
> Signed-off-by: Jaghathiswari Rankappagounder Natarajan <jaghu@google.com>

The Zaius device tree is not upstream. I suggest you submit it through
the Aspeed maintainer's tree (me!) for inclusion in the next merge
window.

For the time being, drop this patch from your series as it will not
apply to the upstream kernel.

As a general rule make sure you're basing the patches you send
upstream on a tag from an upstream tree. Linus' v4.9 tag would be the
best one at this point in time.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
> index 8ef4ece..ccb8147 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
> @@ -43,6 +43,14 @@
>                         gpios = <&gpio ASPEED_GPIO(H, 7) GPIO_ACTIVE_LOW>;
>                 };
>         };
> +
> +       seven-seg-disp {
> +               compatible = "seven-seg-gpio-dev";
> +               refresh-interval-ms = "1000";
> +               clock-gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_HIGH>;
> +               data-gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_HIGH>;
> +               clear-gpios = <&gpio ASPEED_GPIO(J, 1) GPIO_ACTIVE_HIGH>;
> +       };
>  };
>
>  &fmc {
> --
> 2.8.0.rc3.226.g39d4020
>
