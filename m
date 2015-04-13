From: dianders@chromium.org (Doug Anderson)
Date: Mon, 13 Apr 2015 16:44:59 -0700
Subject: [PATCH] ARM: socfpga: dts: Add a ciu clock node for sdmmc
In-Reply-To: <1428699386-2622-1-git-send-email-dinguyen@opensource.altera.com>
References: <1428699386-2622-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <CAD=FV=XunJQ=DMvQrJo3f8A67yrwL6-kwcEcUC9=WqM4+Lx4Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 10, 2015 at 1:56 PM,  <dinguyen@opensource.altera.com> wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> The CIU(Card Interface Unit) clock is used by the dw_mmc IP to clock an SD
> card. The ciu_clk is the sdmmc_clk passed through a fixed divider of 4. This patch
> adds the ciu_clk node and makes the sdmmc_clk it's parent.
>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index d9176e6..25418ee 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -451,6 +451,14 @@
>                                                 clk-phase = <0 135>;
>                                         };
>
> +                                       ciu_clk: ciu_clk {

Can't say I'm an expert on socfpga, but seems like this clock is only
for sdmmc, right?  ...so its name ought to have sdmmc in its name?

-Doug
