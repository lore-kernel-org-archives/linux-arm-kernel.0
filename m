From: joel@jms.id.au (Joel Stanley)
Date: Tue, 20 Sep 2016 16:52:36 +0930
Subject: [PATCH v3 3/3] ARM: dts: aspeed: Enable BT IPMI BMC device
In-Reply-To: <1474354900-5618-4-git-send-email-clg@kaod.org>
References: <1474354900-5618-1-git-send-email-clg@kaod.org>
 <1474354900-5618-4-git-send-email-clg@kaod.org>
Message-ID: <CACPK8XdTTuFSTEn7TkNfOBSMgNK-OYxXuS5Mc+CSN749Hb2GXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 4:31 PM, C?dric Le Goater <clg@kaod.org> wrote:
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Acked-by: Joel Stanley <joel@jms.id.au>

I'll put this in my tree to send to Arnd.

Cheers,

Joel

> ---
>
>  Changes since v1:
>
>  - added the soc name ast2400 in the compatible cell
>
>  arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 22dee5937d5c..7bb00b6f13d8 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -82,6 +82,12 @@
>                                 clocks = <&clk_apb>;
>                         };
>
> +                       ibt: ibt at 1e789140 {
> +                               compatible = "aspeed,ast2400-bt-bmc";
> +                               reg = <0x1e789140 0x18>;
> +                               interrupts = <8>;
> +                       };
> +
>                         wdt1: wdt at 1e785000 {
>                                 compatible = "aspeed,wdt";
>                                 reg = <0x1e785000 0x1c>;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index dd94d9361fda..1d8f81b548b3 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -86,6 +86,12 @@
>                                 clocks = <&clk_apb>;
>                         };
>
> +                       ibt: ibt at 1e789140 {
> +                               compatible = "aspeed,ast2400-bt-bmc";
> +                               reg = <0x1e789140 0x18>;
> +                               interrupts = <8>;
> +                       };
> +
>                         wdt1: wdt at 1e785000 {
>                                 compatible = "aspeed,wdt";
>                                 reg = <0x1e785000 0x1c>;
> --
> 2.7.4
>
