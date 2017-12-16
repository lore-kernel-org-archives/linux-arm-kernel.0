From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Dec 2017 11:44:33 -0600
Subject: [RESEND PATCH v2 13/15] dt-bindings: sound: qcom: Add devicetree
 bindings for apq8096
In-Reply-To: <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
Message-ID: <20171216174433.dzjftpz6zcyyq4ph@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 05:34:00PM +0000, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add devicetree bindings documentation file for Qualcomm apq8096 sound card.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,apq8096.txt     | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> new file mode 100644
> index 000000000000..27b511dab533
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> @@ -0,0 +1,22 @@
> +* Qualcomm Technologies APQ8096 ASoC sound card driver
> +
> +This binding describes the APQ8096 sound card, which uses qdsp for audio.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,apq8096-sndcard"
> +
> +- qcom,audio-routing:
> +	Usage: Optional
> +	Value type: <stringlist>
> +	Definition:  A list of the connections between audio components.
> +		  Each entry is a pair of strings, the first being the
> +		  connection's sink, the second being the connection's
> +		  source. Valid names could be power supplies, MicBias
> +		  of codec and the jacks on the board:
> +Example:
> +	sound {
> +		compatible	= "qcom,snd-apq8096";
> +		qcom,model = "DB820c";

Not documented, but just use "model".

This doesn't look complete. No codec, etc.?

Rob
