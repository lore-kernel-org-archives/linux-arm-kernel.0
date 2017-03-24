From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Mar 2017 09:21:32 -0500
Subject: [PATCH v3 02/11] IIO: Add DT bindings for sigma delta adc
 modulator
In-Reply-To: <1489759704-30217-3-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-3-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20170324142131.cm72er2cc2kggxco@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 03:08:15PM +0100, Arnaud Pouliquen wrote:
> Add documentation of device tree bindings to support
> sigma delta modulator in IIO framework.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V2 -> V3 :
> 	-Rename to suppress "simple"
>         - add "ads1201" compatibility
>  
>  .../devicetree/bindings/iio/adc/sigma-delta-modulator.txt   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> new file mode 100644
> index 0000000..27f04a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> @@ -0,0 +1,13 @@
> +Device-Tree bindings for sigma delta modulator
> +
> +Required properties:
> +- compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
> +	as a generic SD modulator if modulator not specified in compatible list.
> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
> +
> +Example node:
> +
> +	ads1202: simple_sd_adc at 0 {

adc at ...

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "sd-modulator";
> +		#io-channel-cells = <1>;
> +	};
> -- 
> 1.9.1
> 
