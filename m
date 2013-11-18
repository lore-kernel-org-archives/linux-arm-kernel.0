From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Mon, 18 Nov 2013 13:07:12 -0500
Subject: [PATCHv2 3/8] ARM: dts: Enables SAI ALSA SoC DAI device for
 Vybrid VF610 TOWER board.
In-Reply-To: <1383289495-24523-4-git-send-email-Li.Xiubo@freescale.com> (Xiubo
 Li's message of "Fri, 1 Nov 2013 15:04:50 +0800")
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-4-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <87bo1hk2i7.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On  1 Nov 2013, Li.Xiubo at freescale.com wrote:

> This patch add and enable SAI device.
>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
> arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index 1a58678..e4106dd 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
>>> -57,6 +57,12 @@
> 	status = "okay";
> };

Should we put a comment here that a TWR-AUDIO-SGTL board is needed?  Or
is this better in a menuconfig?  I guess TWR-AUDIO-SGTL is needed as
this codec is not on the VF610-TWR main board?

> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2_1>;
> +	status = "okay";
> +};
> +
