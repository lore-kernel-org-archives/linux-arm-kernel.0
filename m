From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Feb 2016 11:50:38 -0600
Subject: [PATCH v2 4/4] Documentation: atmel-pmc: add DT bindings for
 fast startup
In-Reply-To: <1454571471-4434-5-git-send-email-wenyou.yang@atmel.com>
References: <1454571471-4434-1-git-send-email-wenyou.yang@atmel.com>
 <1454571471-4434-5-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160208175038.GA10074@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 03:37:51PM +0800, Wenyou Yang wrote:
> Add DT bindings to configurate the PMC_FSMR and PMC_FSPR registers
> to trigger a fast restart signal to PMC.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v2:
>  - change the property name and property description.
> 
>  .../devicetree/bindings/arm/atmel-pmc.txt          |   63 ++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-pmc.txt b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
> index 795cc78..1b3833b 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
> @@ -12,3 +12,66 @@ Examples:
>  		compatible = "atmel,at91rm9200-pmc";
>  		reg = <0xfffffc00 0x100>;
>  	};
> +
> +PMC Fast Startup Signals
> +
> +The PMC Fast Start Signals are used as the wake up source to trigger the PMC
> +to wake up the system from the ULP1 mode.
> +
> +required properties:
> +- compatible: Should be "atmel,sama5d2-pmc-fast-startup".
> +
> +optional properties:
> +- atmel,wkup-trigger: boolean, WKUP input can trigger a fast restart signal.
> +- atmel,secumod-trigger: boolean, SECUMOD can trigger a fast restart signal.
> +- atmel,piobu0-trigger: boolean, PIOBU0 input can trigger a fast restart signal.
> +- atmel,piobu1-trigger: boolean, PIOBU1 input can trigger a fast restart signal.
> +- atmel,piobu2-trigger: boolean, PIOBU2 input can trigger a fast restart signal.
> +- atmel,piobu3-trigger: boolean, PIOBU3 input can trigger a fast restart signal.
> +- atmel,piobu4-trigger: boolean, PIOBU4 input can trigger a fast restart signal.
> +- atmel,piobu5-trigger: boolean, PIOBU5 input can trigger a fast restart signal.
> +- atmel,piobu6-trigger: boolean, PIOBU6 input can trigger a fast restart signal.
> +- atmel,piobu7-trigger: boolean, PIOBU7 input can trigger a fast restart signal.
> +- atmel,gmac-wol-trigger: boolean, GMAC_WOL can trigger a fast restart signal.
> +- atmel,rtc-alarm-trigger: boolean, RTC alarm can trigger a fast restart signal.
> +- atmel,usb-resume-trigger: boolean, USB resume can trigger a fast restart
> +  signal.
> +- atmel,sdmmc-cd-trigger: boolean, SDMMC card detect can trigger a fast
> +  restart signal.
> +- atmel,rxlp-match-trigger: boolean, Matching condition on RXLP can trigger
> +  a fast restart signal.
> +- atmel,acc-comparison-trigger: boolean, ACC comparison can trigger a fast
> +  restart signal.
> +
> +- atmel,wkup-trigger-level: string, defines the active polarity of the wake-up
> +  input. Supported values are: "high" or "low".

Use 0 and 1, not strings.
