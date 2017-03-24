From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Mar 2017 09:46:03 -0500
Subject: [PATCH v3 08/11] ASoC: Add bindings for DMIC codec driver
In-Reply-To: <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20170324144603.zos7n4oqelaag433@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 03:08:21PM +0100, Arnaud Pouliquen wrote:
> This patch adds documentation of device tree bindings for audio DMIC codec.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  Documentation/devicetree/bindings/sound/dmic.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
> new file mode 100644
> index 0000000..eb2a9d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/dmic.txt
> @@ -0,0 +1,11 @@
> +Device-Tree bindings for dmic codec

Please define what is and isn't a DMIC here. What's the interface?

> +
> +Required properties:
> +	- compatible: should be "dmic-codec".

DMICs don't have part numbers?

> +
> +Example node:
> +
> +	dmic_audio: dmic_audio at 0 {

Don't use '_' and there's no reg property, so there should be no unit 
address.

> +		compatible = "dmic-codec";
> +		status = "okay";

Don't show status in examples.

> +	};
> -- 
> 1.9.1
> 
