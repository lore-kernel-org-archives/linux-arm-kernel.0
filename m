From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 14 Mar 2018 18:17:17 +0300
Subject: [PATCH v2 2/3] arm64: dts: renesas: salvator-common: Configure
 PMIC for DDR Backup Power
In-Reply-To: <1521029386-29975-3-git-send-email-geert+renesas@glider.be>
References: <1521029386-29975-1-git-send-email-geert+renesas@glider.be>
 <1521029386-29975-3-git-send-email-geert+renesas@glider.be>
Message-ID: <9c6289e4-23dd-c79b-bd1f-058d843739d2@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 03/14/2018 03:09 PM, Geert Uytterhoeven wrote:

> On Salvator-X(S), all of the DDR0, DDR1, DDR0C, and DDR1C power rails
> need to be kept powered when backup mode is enabled.  Reflect this in
> the "rohm,ddr-backup-power" property for the BD9571MWV PMIC node.
> 
> The accessory power switch (SW23) is a toggle switch, hense specify
> "rohm,rstbmode-level".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add rohm,rstbmode-level.
> ---
>  arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> index 2a7f36abd2dd85c6..80794c38c2669d75 100644
> --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> @@ -376,6 +376,8 @@
>  		#interrupt-cells = <2>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		rohm,ddr-backup-power = <15>;

  Why not 0xf if those are all bit flags?

[...]

MBR, Sergei
