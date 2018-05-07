From: robh@kernel.org (Rob Herring)
Date: Mon, 7 May 2018 11:36:19 -0500
Subject: [PATCH V2 4/8] ARM: dts: stm32: Add syscfg on stm32mp1
In-Reply-To: <1525270723-18241-5-git-send-email-christophe.roullier@st.com>
References: <1525270723-18241-1-git-send-email-christophe.roullier@st.com>
 <1525270723-18241-5-git-send-email-christophe.roullier@st.com>
Message-ID: <20180507163619.GB15212@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 04:18:39PM +0200, Christophe Roullier wrote:
> System configuration controller is mainly used to manage
> the compensation cell and other IOs and system related
> settings.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  arch/arm/boot/dts/stm32mp157c.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index bc3eddc..86421ba 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -167,6 +167,11 @@
>  			#reset-cells = <1>;
>  		};
>  
> +		syscfg: system-config at 50020000 {
> +			compatible = "syscon";
> +			reg = <0x50020000 0x400>;
> +		};

NAK as explained in the documentation patch.

Rob
