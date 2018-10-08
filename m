From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Mon, 8 Oct 2018 09:27:43 +0200
Subject: [PATCH v2 2/6] ARM: dts: axp81x: add AC power supply subnode
In-Reply-To: <20181006211836.28253-3-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-3-oskari@lemmela.net>
Message-ID: <20181008072743.ecjb75nixm6wbp6b@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:32AM +0300, Oskari Lemmela wrote:
> Add AC power supply subnode for AXP81X PMIC.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  arch/arm/boot/dts/axp81x.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
> index 043c717dcef1..67c17151b584 100644
> --- a/arch/arm/boot/dts/axp81x.dtsi
> +++ b/arch/arm/boot/dts/axp81x.dtsi
> @@ -69,6 +69,11 @@
>  		};
>  	};
>  
> +	ac_power_supply: ac-power-supply {
> +		compatible = "x-powers,axp813-ac-power-supply";
> +		status = "disabled";
> +	};
> +

IIRC, when it's a DT node of something that has no address (register or
bus address), we order alphabetically the DT nodes within the same
parent node. So here, we would put it before axp_adc.

Thanks,
Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/dd269fd7/attachment-0001.sig>
