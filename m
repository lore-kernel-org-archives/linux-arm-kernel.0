From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 22 Feb 2017 18:32:15 -0500
Subject: [PATCH 1/1] ARM: dts: NSP: Add crypto (SPU) to dtsi
In-Reply-To: <1487798543-34229-1-git-send-email-steven.lin1@broadcom.com>
References: <1487798543-34229-1-git-send-email-steven.lin1@broadcom.com>
Message-ID: <CAC3K-4oaFiP43wGWTqqeB-Hcr0Ov07Xu1RONCi+NAXqf9hr2-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 4:22 PM, Steve Lin <steven.lin1@broadcom.com> wrote:
> Adds crypto hardware (SPU) to Northstar Plus device tree file.
>
> Signed-off-by: Steve Lin <steven.lin1@broadcom.com>

Looks good to me!

Acked-by: Jon Mason <jon.mason@broadcom.com>

>
> ---
> Code changes for this addition were submitted previously by Rob
> Rice: https://git.kernel.org/cgit/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=9d12ba86f818aa9cfe9f01b750336aa441f2ffa2
> ---
>  arch/arm/boot/dts/bcm-nsp.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> index b6142bd..9bac0c8 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -241,6 +241,12 @@
>                         brcm,nand-has-wp;
>                 };
>
> +               crypto at 2f000 {
> +                       compatible = "brcm,spum-nsp-crypto";
> +                       reg = <0x2f000 0x900>;
> +                       mboxes = <&mailbox 0>;
> +               };
> +
>                 gpiob: gpio at 30000 {
>                         compatible = "brcm,iproc-nsp-gpio", "brcm,iproc-gpio";
>                         reg = <0x30000 0x50>;
> --
> 2.1.0
>
