From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 24 Oct 2013 22:39:10 -0500
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <1382616832-23593-2-git-send-email-denis@eukrea.com>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
Message-ID: <8309A8FC-87E3-4479-BAB7-DD9B818D56BE@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 24, 2013, at 7:13 AM, Denis Carikli wrote:

> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel at alsa-project.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Eric B?nard <eric@eukrea.com>
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v6->v7:
> - The cleanups went into another patch.
> - The support for fsl_ssi doesn't depend on dt anymore.
> - platform_name = "imx-ssi.0" is still set when in non-dt mode.
> ---
> .../devicetree/bindings/sound/eukrea-tlv320.txt    |   23 +++++
> sound/soc/fsl/Kconfig                              |    5 +-
> sound/soc/fsl/eukrea-tlv320.c                      |   88 ++++++++++++++++++--
> 3 files changed, 107 insertions(+), 9 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
> new file mode 100644
> index 0000000..8791037
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
> @@ -0,0 +1,23 @@
> +Audio complex for Eukrea boards with tlv320aic23 codec.
> +
> +Required properties:
> +- compatible : "eukrea,eukrea-tlv320"
> +- model : The user-visible name of this sound complex.
> +- ssi-controller : The phandle of the SSI controller.
> +- audio-codec : The phandle of the tlv320aic23 audio codec.
> +- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX).
> +- mux-ext-port : The external port of the i.MX audio muxer.

mux-int-port & mux-ext-port should probably be vendor prefixed. (I know there are examples in tree where this isn't done).

> +
> +Note: The AUDMUX port numbering should start at 1, which is consistent with
> +hardware manual.
> +
> +Example:
> +
> +	sound {
> +		compatible = "eukrea,eukrea-tlv320";
> +		model = "imx51-eukrea-tlv320aic23";
> +		ssi-controller = <&ssi2>;
> +		fsl,audio-codec = <&tlv320aic23>;

this is inconsistent with the binding description above, is it audio-codec or fsl,audio-codec?

> +		mux-int-port = <2>;
> +		mux-ext-port = <3>;
> +	};

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
