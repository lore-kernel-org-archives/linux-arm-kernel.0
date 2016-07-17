From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 15:03:11 -0500
Subject: [PATCH 1/4] qcom: ipq4019: Add ipq4019 ASoC device tree changes
In-Reply-To: <1468566426-19598-2-git-send-email-njaigane@codeaurora.org>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
 <1468566426-19598-2-git-send-email-njaigane@codeaurora.org>
Message-ID: <20160717200311.GA6588@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 12:37:03PM +0530, njaigane at codeaurora.org wrote:
> From: Jaiganesh Narayanan <njaigane@codeaurora.org>
> 
> This patch adds the ipq4019 ASoC device tree changes and the
> binding documentation for pcm, spdif, tdm, stereo, codec, mbox,
> adss modules
> 
> Signed-off-by: Jaiganesh Narayanan <njaigane@codeaurora.org>
> ---
>  .../bindings/sound/qca,ipq4019-audio-adss.txt      |  20 ++
>  .../bindings/sound/qca,ipq4019-audio.txt           |  13 ++
>  .../bindings/sound/qca,ipq4019-codec.txt           |  15 ++
>  .../devicetree/bindings/sound/qca,ipq4019-i2s.txt  |  33 +++
>  .../devicetree/bindings/sound/qca,ipq4019-i2s1.txt |  29 +++
>  .../devicetree/bindings/sound/qca,ipq4019-i2s2.txt |  29 +++
>  .../devicetree/bindings/sound/qca,ipq4019-mbox.txt |  23 ++
>  .../bindings/sound/qca,ipq4019-pcm-i2s.txt         |  15 ++
>  .../bindings/sound/qca,ipq4019-pcm-i2s1.txt        |  15 ++
>  .../bindings/sound/qca,ipq4019-pcm-i2s2.txt        |  15 ++
>  .../bindings/sound/qca,ipq4019-pcm-spdif.txt       |  15 ++
>  .../bindings/sound/qca,ipq4019-pcm-tdm.txt         |  15 ++
>  .../bindings/sound/qca,ipq4019-spdif.txt           |  35 +++
>  .../bindings/sound/qca,ipq4019-stereo.txt          |  17 ++
>  .../devicetree/bindings/sound/qca,ipq4019-tdm.txt  |  33 +++
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      | 195 ++++++++++++++--
>  arch/arm/boot/dts/qcom-ipq4019.dtsi                | 247 ++++++++++++++++++++-
>  17 files changed, 742 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-audio-adss.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-codec.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-i2s1.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-i2s2.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-mbox.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s1.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s2.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-tdm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-stereo.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-tdm.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-audio-adss.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-audio-adss.txt
> new file mode 100644
> index 0000000..5ba2b9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-audio-adss.txt
> @@ -0,0 +1,20 @@
> +* Qualcomm Technologies IPQ4019 ASoC audio subsystem driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC audio subsystem driver
> +
> +Required properties:
> +
> +- compatible	: "qca,ipq4019-audio-adss"
> +- reg		: should have the stereo register address, length
> +- resets	: references to the reset controllers
> +- reset-names	: should be "blk_rst"
> +
> +
> +Example:
> +audio: audio at 7700000 {
> +	compatible = "qca,ipq4019-audio-adss";
> +	reg = <0x7700000 0x34>;
> +	resets = <&gcc AUDIO_BLK_ARES>;
> +	reset-names = "blk_rst";
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-audio.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-audio.txt
> new file mode 100644
> index 0000000..fde039f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-audio.txt
> @@ -0,0 +1,13 @@
> +* Qualcomm Technologies IPQ4019 ASoC machine driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC machine driver

ASoC machine driver is a Linuxism.

> +
> +Required properties:
> +
> +- compatible		: "qca,ipq4019-audio"
> +
> +Example:
> +
> +sound: sound {
> +	compatible = "qca,ipq4019-audio";

I'd expect something else in here like phandle links to sub blocks. This 
alone just for purposes of instantiating a driver is not acceptible.

> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-codec.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-codec.txt
> new file mode 100644
> index 0000000..3df7742d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-codec.txt
> @@ -0,0 +1,15 @@
> +* Qualcomm Technologies IPQ4019 ASoC Codec driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC Codec driver
> +
> +Required properties:
> +
> +- compatible	: "qca,ipq4019-codec"
> +- reg		: should have the stereo i2c register address
> +
> +Example:
> +qca_codec: qca_codec at 12 {

Don't use '_' in node names, just 'codec at ...'.

> +	compatible = "qca,ipq4019-codec";
> +	reg = <0x12>;
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-i2s.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-i2s.txt
> new file mode 100644
> index 0000000..af9b63e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-i2s.txt
> @@ -0,0 +1,33 @@
> +* Qualcomm Technologies IPQ4019 ASoC PCM driver

Bindings describe h/w, not ASoC or drivers.

> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC I2S PCM driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-i2s"
> +- dma-tx-channel : should have the mbox tx channel id
> +- dma-rx-channel : should have the mbox rx channel id
> +- stereo-tx-port : should have the stereo tx id
> +- stereo-rx-port : should have the stereo rx id
> +- clocks	 : should have the audio tx bit clock, tx master clock,
> +		   rx bit clock, rx master clock id
> +- clock-names	 : should be "audio_tx_bclk", "audio_tx_mclk", "audio_rx_bclk",
> +		   "audio_rx_mclk"
> +
> +Example:
> +i2s: ipq4019-pcm-i2s at 0 {

Just i2s at ... Though 0 here is not valid without a reg property. There's 
no registers?

> +	compatible = "qca,ipq4019-i2s";
> +	dma-tx-channel = <MBOX0_TX_ID>;
> +	dma-rx-channel = <MBOX3_RX_ID>;
> +	stereo-tx-port = <STEREO0_ID>;
> +	stereo-rx-port = <STEREO3_ID>;
> +	clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +		<&adcc ADCC_TXM_CLK_SRC>,
> +		<&adcc ADCC_RXB_CLK_SRC>,
> +		<&adcc ADCC_RXM_CLK_SRC>;
> +	clock-names = "audio_tx_bclk",
> +		"audio_tx_mclk",
> +		"audio_rx_bclk",
> +		"audio_rx_mclk";
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-i2s1.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-i2s1.txt
> new file mode 100644
> index 0000000..47333b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-i2s1.txt
> @@ -0,0 +1,29 @@
> +* Qualcomm Technologies IPQ4019 ASoC I2S PCM driver

ditto

> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC I2S PCM driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-i2s1"

What's the difference between this and the previous one.

> +- dma-tx-channel : should have the mbox tx channel id
> +- stereo-tx-port : should have the stereo tx id
> +- clocks	 : should have the audio tx bit clock, tx master clock,
> +		   rx bit clock, rx master clock id
> +- clock-names	 : should be "audio_tx_bclk", "audio_tx_mclk", "audio_rx_bclk",
> +		   "audio_rx_mclk"
> +
> +Example:
> +i2s1: ipq4019-pcm-i2s1 at 0 {
> +	compatible = "qca,ipq4019-i2s1";
> +	dma-tx-channel = <MBOX1_TX_ID>;
> +	stereo-tx-port = <STEREO1_ID>;
> +	clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +		<&adcc ADCC_TXM_CLK_SRC>,
> +		<&adcc ADCC_RXB_CLK_SRC>,
> +		<&adcc ADCC_RXM_CLK_SRC>;
> +	clock-names = "audio_tx_bclk",
> +		"audio_tx_mclk",
> +		"audio_rx_bclk",
> +		"audio_rx_mclk";
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-i2s2.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-i2s2.txt
> new file mode 100644
> index 0000000..9af0113
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-i2s2.txt
> @@ -0,0 +1,29 @@
> +* Qualcomm Technologies IPQ4019 ASoC I2S PCM driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC I2S PCM driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-i2s2"
> +- dma-tx-channel : should have the mbox tx channel id
> +- stereo-tx-port : should have the stereo tx id
> +- clocks	 : should have the audio tx bit clock, tx master clock,
> +		   rx bit clock, rx master clock id
> +- clock-names	 : should be "audio_tx_bclk", "audio_tx_mclk", "audio_rx_bclk",
> +		   "audio_rx_mclk"
> +
> +Example:
> +i2s1: ipq4019-pcm-i2s2 at 0 {
> +	compatible = "qca,ipq4019-i2s2";
> +	dma-tx-channel = <MBOX2_TX_ID>;
> +	stereo-tx-port = <STEREO2_ID>;
> +	clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +		<&adcc ADCC_TXM_CLK_SRC>,
> +		<&adcc ADCC_RXB_CLK_SRC>,
> +		<&adcc ADCC_RXM_CLK_SRC>;
> +	clock-names = "audio_tx_bclk",
> +		"audio_tx_mclk",
> +		"audio_rx_bclk",
> +		"audio_rx_mclk";
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-mbox.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-mbox.txt
> new file mode 100644
> index 0000000..51d6c51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-mbox.txt
> @@ -0,0 +1,23 @@
> +* Qualcomm Technologies IPQ4019 ASoC MBOX driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC mbox driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-mbox"
> +- dma-index	 : should have the mbox dma index

What is this exactly?

> +- reg		 : should have the stereo register address, length
> +- interrupts	 : should have the mbox interrupt no
> +- tx-channel	 : should have the mbox tx id
> +- rx-channel	 : should have the mbox rx id
> +
> +Example:
> +mbox0: mbox at 7708000 {
> +	compatible = "qca,ipq4019-mbox";
> +	dma-index = <0>;
> +	reg = <0x7708000 0x1000>;
> +	interrupts = <0 156 0>;
> +	tx-channel = <MBOX0_TX_ID>;
> +	rx-channel = <MBOX0_RX_ID>;
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s.txt
> new file mode 100644
> index 0000000..a47c7fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s.txt
> @@ -0,0 +1,15 @@
> +* Qualcomm Technologies IPQ4019 ASoC platform driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC platform driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-pcm-i2s"
> +- reg		 : should have the stereo register address, length
> +
> +Example:
> +i2splatform: qca-pcm-i2s at 7709000 {
> +	compatible = "qca,ipq4019-pcm-i2s";
> +	reg = <0x7709000 0x1000>;
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s1.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s1.txt
> new file mode 100644
> index 0000000..cf23ca0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s1.txt
> @@ -0,0 +1,15 @@
> +* Qualcomm Technologies IPQ4019 ASoC platform driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC platform driver

Now I'm confused. How does this relate to the machine driver above? An 
overview of the audio subsystem and its components would be helpful.

> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-pcm-i2s1"
> +- reg		 : should have the stereo register address, length
> +
> +Example:
> +i2s1platform: qca-pcm-i2s1 at 770b000 {
> +	compatible = "qca,ipq4019-pcm-i2s1";
> +	reg = <0x770b000 0x1000>;
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s2.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s2.txt
> new file mode 100644
> index 0000000..ae04380
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s2.txt
> @@ -0,0 +1,15 @@
> +* Qualcomm Technologies IPQ4019 ASoC platform driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC platform driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-pcm-i2s2"

Again, why the indexing here?

> +- reg		 : should have the stereo register address, length
> +
> +Example:
> +i2s2platform: qca-pcm-i2s1 at 770d000 {
> +	compatible = "qca,ipq4019-pcm-i2s2";
> +	reg = <0x770d000 0x1000>;
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-spdif.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-spdif.txt
> new file mode 100644
> index 0000000..b47c02c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-spdif.txt
> @@ -0,0 +1,15 @@
> +* Qualcomm Technologies IPQ4019 ASoC SPDIF platform driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC SPDIF platform driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-pcm-spdif"
> +- reg		 : should have the stereo register address, length
> +
> +Example:
> +tdmplatform: qca-pcm-spdif at 7707000 {
> +	compatible = "qca,ipq4019-pcm-spdif";
> +	reg = <0x7709000 0x1000>;
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-tdm.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-tdm.txt
> new file mode 100644
> index 0000000..bd3aaa3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-tdm.txt
> @@ -0,0 +1,15 @@
> +* Qualcomm Technologies IPQ4019 ASoC TDM platform driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC TDM platform driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-pcm-tdm"
> +- reg		 : should have the stereo register address, length
> +
> +Example:
> +tdmplatform: qca-pcm-tdm at 7709000 {
> +	compatible = "qca,ipq4019-pcm-tdm";
> +	reg = <0x7709000 0x1000>;
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-spdif.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-spdif.txt
> new file mode 100644
> index 0000000..5a80bbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-spdif.txt
> @@ -0,0 +1,35 @@
> +* Qualcomm Technologies IPQ4019 ASoC SPDIF driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC SPDIF driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-spdif"
> +- dma-tx-channel : should have the mbox tx channel id
> +- dma-rx-channel : should have the mbox rx channel id
> +- stereo-tx-port : should have the stereo tx id
> +- stereo-rx-port : should have the stereo tx id
> +- clocks	 : should have the audio tx bit clock, tx master clock,
> +		   spdif clock, spdif divider clock, spdif in fast clock
> +- clock-names	 : should be "audio_tx_bclk", "audio_tx_mclk", "audio_spdif_src",
> +		   "audio_spdif_div2", "audio_spdifinfast_src"
> +
> +Example:
> +spdif: spdif at 0 {
> +	compatible = "qca,ipq4019-spdif";
> +	dma-tx-channel = <MBOX0_TX_ID>;
> +	dma-rx-channel = <MBOX3_RX_ID>;
> +	stereo-tx-port = <STEREO0_ID>;
> +	stereo-rx-port = <STEREO3_ID>;
> +	clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +		<&adcc ADCC_TXM_CLK_SRC>,
> +		<&adcc ADCC_SPDIF_SRC>,
> +		<&adcc ADCC_SPDIFDIV2_SRC>,
> +		<&adcc ADCC_AUDIO_SPDIFINFAST_SRC>;
> +	clock-names = "audio_tx_bclk",
> +		"audio_tx_mclk",
> +		"audio_spdif_src",
> +		"audio_spdif_div2",
> +		"audio_spdifinfast_src";
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-stereo.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-stereo.txt
> new file mode 100644
> index 0000000..35b4815
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-stereo.txt
> @@ -0,0 +1,17 @@
> +* Qualcomm Technologies IPQ4019 ASoC stereo driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC stereo driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-stereo"
> +- reg		 : should have the stereo register address, length
> +- stereo-index	 : should have the stereo port index
> +
> +Example:
> +stereo0: stereo at 7709000 {
> +	compatible = "qca,ipq4019-stereo";
> +	reg = <0x7709000 0x1000>;
> +	stereo-index = <STEREO0_ID>;
> +	status = "disabled";
> +};
> diff --git a/Documentation/devicetree/bindings/sound/qca,ipq4019-tdm.txt b/Documentation/devicetree/bindings/sound/qca,ipq4019-tdm.txt
> new file mode 100644
> index 0000000..c2bf38c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qca,ipq4019-tdm.txt
> @@ -0,0 +1,33 @@
> +* Qualcomm Technologies IPQ4019 ASoC TDM driver
> +
> +This node models the Qualcomm Technologies IPQ4019 ASoC TDM driver
> +
> +Required properties:
> +
> +- compatible	 : "qca,ipq4019-tdm"
> +- dma-tx-channel : should have the mbox tx channel id
> +- dma-rx-channel : should have the mbox rx channel id
> +- stereo-tx-port : should have the stereo tx id
> +- stereo-rx-port : should have the stereo tx id
> +- clocks	 : should have the audio tx bit clock, tx master clock,
> +		   rx bit clock, rx master clock id
> +- clock-names	 : should be "audio_tx_bclk", "audio_tx_mclk", "audio_rx_bclk",
> +		   "audio_rx_mclk"
> +
> +Example:
> +tdm: tdm at 0 {
> +	compatible = "qca,ipq4019-tdm";
> +	dma-tx-channel = <MBOX0_TX_ID>;
> +	dma-rx-channel = <MBOX3_RX_ID>;
> +	stereo-tx-port = <STEREO0_ID>;
> +	stereo-rx-port = <STEREO3_ID>;
> +	clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +		<&adcc ADCC_TXM_CLK_SRC>,
> +		<&adcc ADCC_RXB_CLK_SRC>,
> +		<&adcc ADCC_RXM_CLK_SRC>;
> +	clock-names = "audio_tx_bclk",
> +		"audio_tx_mclk",
> +		"audio_rx_bclk",
> +		"audio_rx_mclk";
> +	status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
> index b9457dd2..e2ab95a 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi

This should be a separate patch.

> @@ -1,4 +1,4 @@
> -/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
> +/* Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
>   *
>   * Permission to use, copy, modify, and/or distribute this software for any
>   * purpose with or without fee is hereby granted, provided that the above
> @@ -20,26 +20,7 @@
>  	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK01.1";
>  	compatible = "qcom,ipq4019";
>  
> -	clocks {
> -                xo: xo {
> -                        compatible = "fixed-clock";
> -                        clock-frequency = <48000000>;
> -                        #clock-cells = <0>;
> -                };
> -	};
> -
>  	soc {
> -
> -
> -		timer {
> -			compatible = "arm,armv7-timer";
> -			interrupts = <1 2 0xf08>,
> -				     <1 3 0xf08>,
> -				     <1 4 0xf08>,
> -				     <1 1 0xf08>;
> -			clock-frequency = <48000000>;
> -		};
> -

This hunk looks unrelated.

>  		pinctrl at 0x01000000 {
>  			serial_pins: serial_pinmux {
>  				mux {
> @@ -69,6 +50,81 @@
>  					bias-disable;
>  					output-high;
>  				};
> +
> +			};
> +
> +			audio_pins: audio_pinmux {
> +				mux_1 {
> +					pins = "gpio25", "gpio53", "gpio60";
> +					function = "i2s_tx_bclk";
> +					bias-pull,up;
> +				};
> +
> +				mux_2 {
> +					pins = "gpio27", "gpio54", "gpio63";
> +					function = "i2s_txd1";
> +					bias-pull,up;
> +				};
> +
> +				mux_3 {
> +					pins = "gpio28", "gpio55";
> +					function = "i2s_txd2";
> +					bias-pull,up;
> +				};
> +
> +				mux_4 {
> +					pins = "gpio29", "gpio56";
> +					function = "i2s_txd3";
> +					bias-pull,up;
> +				};
> +
> +				mux_5 {
> +					pins = "gpio24", "gpio52";
> +					function = "i2s_tx_mclk";
> +					bias-pull,up;
> +				};
> +
> +				mux_6 {
> +					pins = "gpio26", "gpio57", "gpio61";
> +					function = "i2s_tx_fsync";
> +					bias-pull,up;
> +				};
> +
> +				mux_7 {
> +					pins = "gpio2", "gpio23", "gpio63";
> +					function = "i2s_rxd";
> +					bias-pull,up;
> +				};
> +
> +				mux_8 {
> +					pins = "gpio20", "gpio58";
> +					function = "i2s_rx_mclk";
> +					bias-pull,up;
> +				};
> +
> +				mux_9 {
> +					pins = "gpio0", "gpio21", "gpio60";
> +					function = "i2s_rx_bclk";
> +					bias-pull,up;
> +				};
> +
> +				mux_10 {
> +					pins = "gpio1", "gpio22", "gpio61";
> +					function = "i2s_rx_fsync";
> +					bias-pull,up;
> +				};
> +
> +				mux_11 {
> +					pins = "gpio34", "gpio59", "gpio63";
> +					function = "i2s_spdif_in";
> +					bias-pull,up;
> +				};
> +
> +				mux_12 {
> +					pins = "gpio35", "gpio62", "gpio63";
> +					function = "i2s_spdif_out";
> +					bias-pull,up;
> +				};
>  			};
>  		};
>  
> @@ -108,5 +164,104 @@
>  		watchdog at b017000 {
>  			status = "ok";
>  		};
> +
> +		adcc: clock-controller at 7700038 {
> +			status = "ok";
> +		};
> +
> +		audio: audio at 7700000 {
> +			status = "ok";
> +		};
> +
> +		mbox0: mbox at 7708000 {
> +			status = "ok";
> +		};
> +
> +		mbox1: mbox at 770a000 {
> +			status = "ok";
> +		};
> +
> +		mbox2: mbox at 770c000 {
> +			status = "ok";
> +		};
> +
> +		mbox3: mbox at 770e000 {
> +			status = "ok";
> +		};
> +
> +		mbox4: mbox at 7706000 {
> +			status = "ok";
> +		};
> +
> +		stereo0: stereo at 7709000 {
> +			status = "ok";
> +		};
> +
> +		stereo1: stereo at 770b000 {
> +			status = "ok";
> +		};
> +
> +		stereo2: stereo at 770d000 {
> +			status = "ok";
> +		};
> +
> +		stereo3: stereo at 770f000 {
> +			status = "ok";
> +		};
> +
> +		/* Enable Audio Interfaces */
> +		i2s: ipq4019-pcm-i2s at 0 {
> +			status = "ok";
> +		};
> +
> +		i2splatform: qca-pcm-i2s at 7709000 {
> +			status = "ok";
> +		};
> +
> +		i2s1platform: qca-pcm-i2s1 at 770b000 {
> +			status = "ok";
> +		};
> +
> +		i2s1: ipq4019-pcm-i2s1 at 0 {
> +			status = "ok";
> +		};
> +
> +		i2s2platform: qca-pcm-i2s2 at 770d000 {
> +			status = "ok";
> +		};
> +
> +		i2s2: ipq4019-pcm-i2s2 at 0 {
> +			status = "ok";
> +		};
> +
> +		tdmplatform: qca-pcm-tdm at 7709000 {
> +			status = "ok";
> +		};
> +
> +		tdm: tdm at 0 {
> +			status = "ok";
> +		};
> +
> +		spdifplatform: qca-pcm-spdif at 7707000 {
> +			status = "ok";
> +		};
> +
> +		spdif: spdif at 0 {
> +			status = "ok";
> +		};
> +
> +		sound: sound at 0 {
> +			pinctrl-0 = <&audio_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +		};
> +
> +		i2c_0: i2c at 78b7000 { /* BLSP1 QUP2 */
> +			status = "ok";
> +
> +			qca_codec: qca_codec at 12 {
> +				status = "ok";
> +			};
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index 5c08d19..e2b4810 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
> @@ -15,6 +15,8 @@
>  
>  #include "skeleton.dtsi"
>  #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
> +#include <dt-bindings/clock/qca,adcc-ipq4019.h>
> +#include <dt-bindings/sound/ipq4019-audio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  
> @@ -90,6 +92,21 @@
>  			clock-frequency = <32768>;
>  			#clock-cells = <0>;
>  		};
> +
> +		xo: xo {
> +			compatible = "fixed-clock";
> +			clock-frequency = <48000000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <1 2 0xf08>,
> +			     <1 3 0xf08>,
> +			     <1 4 0xf08>,
> +			     <1 1 0xf08>;
> +		clock-frequency = <48000000>;
>  	};
>  
>  	soc {
> @@ -156,8 +173,13 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			status = "disabled";
> -		};
>  
> +			qca_codec: qca_codec at 12 {
> +				compatible = "qca,ipq4019-codec";
> +				reg = <0x12>;
> +				status = "disabled";
> +			};
> +		};
>  
>  		cryptobam: dma at 8e04000 {
>  			compatible = "qcom,bam-v1.7.0";
> @@ -263,5 +285,226 @@
>  			compatible = "qcom,pshold";
>  			reg = <0x4ab000 0x4>;
>  		};
> +
> +		adcc: clock-controller at 7700038 {
> +			compatible = "qcom,adcc-ipq4019";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			reg = <0x7700038 0x1DC>;
> +			status = "disabled";
> +		};
> +
> +		audio: audio at 7700000 {
> +			compatible = "qca,ipq4019-audio-adss";
> +			reg = <0x7700000 0x34>,
> +				<0x7707000 0x20>;
> +			resets = <&gcc AUDIO_BLK_ARES>;
> +			reset-names = "blk_rst";
> +			status = "disabled";
> +		};
> +
> +		pcm: pcm at 7704000 {
> +			compatible = "qca,ipq4019-pcm";
> +			reg = <0x7704000 0x2000>;
> +			dma-tx-channel = <MBOX3_TX_ID>;
> +			dma-rx-channel = <MBOX0_RX_ID>;
> +			stereo-tx-port = <STEREO3_ID>;
> +			stereo-rx-port = <STEREO0_ID>;
> +			clocks = <&adcc ADCC_PCM_CLK_SRC>;
> +			clock-names = "audio_pcm_clk";
> +			status = "disabled";
> +		};
> +
> +		mbox0: mbox at 7708000 {
> +			dma-index = <0>;
> +			compatible = "qca,ipq4019-mbox";
> +			reg = <0x7708000 0x1000>;
> +			interrupts = <0 156 0>;
> +			tx-channel = <MBOX0_TX_ID>;
> +			rx-channel = <MBOX0_RX_ID>;
> +			status = "disabled";
> +		};
> +
> +		mbox1: mbox at 770a000 {
> +			dma-index = <1>;
> +			compatible = "qca,ipq4019-mbox";
> +			reg = <0x770A000 0x1000>;
> +			interrupts = <0 157 0>;
> +			tx-channel = <MBOX1_TX_ID>;
> +			status = "disabled";
> +		};
> +
> +		mbox2: mbox at 770c000 {
> +			dma-index = <2>;
> +			compatible = "qca,ipq4019-mbox";
> +			reg = <0x770C000 0x1000>;
> +			interrupts = <0 158 0>;
> +			tx-channel = <MBOX2_TX_ID>;
> +			status = "disabled";
> +		};
> +
> +		mbox3: mbox at 770e000 {
> +			dma-index = <3>;
> +			compatible = "qca,ipq4019-mbox";
> +			reg = <0x770E000 0x1000>;
> +			interrupts = <0 159 0>;
> +			tx-channel = <MBOX3_TX_ID>;
> +			rx-channel = <MBOX3_RX_ID>;
> +			status = "disabled";
> +		};
> +
> +		mbox4: mbox at 7706000 {
> +			dma-index = <4>;
> +			compatible = "qca,ipq4019-mbox";
> +			reg = <0x7706000 0x1000>;
> +			interrupts = <0 163 0>;
> +			rx-channel = <MBOX_SPDIF_RX_ID>;
> +			status = "disabled";
> +		};
> +
> +		stereo0: stereo at 7709000 {
> +			stereo-index = <STEREO0_ID>;
> +			compatible = "qca,ipq4019-stereo";
> +			reg = <0x7709000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		stereo1: stereo at 770b000 {
> +			stereo-index = <STEREO1_ID>;
> +			compatible = "qca,ipq4019-stereo";
> +			reg = <0x770B000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		stereo2: stereo at 770d000 {
> +			stereo-index = <STEREO2_ID>;
> +			compatible = "qca,ipq4019-stereo";
> +			reg = <0x770D000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		stereo3: stereo at 770f000 {
> +			stereo-index = <STEREO3_ID>;
> +			compatible = "qca,ipq4019-stereo";
> +			reg = <0x770F000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		i2splatform: qca-pcm-i2s at 7709000 {
> +			compatible = "qca,ipq4019-pcm-i2s";
> +			reg = <0x7709000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		i2s: ipq4019-pcm-i2s at 0 {
> +			compatible = "qca,ipq4019-i2s";
> +			dma-tx-channel = <MBOX0_TX_ID>;
> +			stereo-tx-port = <STEREO0_ID>;
> +			dma-rx-channel = <MBOX3_RX_ID>;
> +			stereo-rx-port = <STEREO3_ID>;
> +			clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +				<&adcc ADCC_TXM_CLK_SRC>,
> +				<&adcc ADCC_RXB_CLK_SRC>,
> +				<&adcc ADCC_RXM_CLK_SRC>;
> +			clock-names = "audio_tx_bclk",
> +				"audio_tx_mclk",
> +				"audio_rx_bclk",
> +				"audio_rx_mclk";
> +			status = "disabled";
> +		};
> +
> +		i2s1platform: qca-pcm-i2s1 at 770b000 {
> +			compatible = "qca,ipq4019-pcm-i2s1";
> +			reg = <0x770b000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		i2s1: ipq4019-pcm-i2s1 at 0 {
> +			compatible = "qca,ipq4019-i2s1";
> +			dma-tx-channel = <MBOX1_TX_ID>;
> +			stereo-tx-port = <STEREO1_ID>;
> +			clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +				<&adcc ADCC_TXM_CLK_SRC>,
> +				<&adcc ADCC_RXB_CLK_SRC>,
> +				<&adcc ADCC_RXM_CLK_SRC>;
> +			clock-names = "audio_tx_bclk",
> +				"audio_tx_mclk",
> +				"audio_rx_bclk",
> +				"audio_rx_mclk";
> +			status = "disabled";
> +		};
> +
> +		i2s2platform: qca-pcm-i2s2 at 770d000 {
> +			compatible = "qca,ipq4019-pcm-i2s2";
> +			reg = <0x770d000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		i2s2: ipq4019-pcm-i2s2 at 0 {
> +			compatible = "qca,ipq4019-i2s2";
> +			dma-tx-channel = <MBOX2_TX_ID>;
> +			stereo-tx-port = <STEREO2_ID>;
> +			clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +				<&adcc ADCC_TXM_CLK_SRC>,
> +				<&adcc ADCC_RXB_CLK_SRC>,
> +				<&adcc ADCC_RXM_CLK_SRC>;
> +			clock-names = "audio_tx_bclk",
> +				"audio_tx_mclk",
> +				"audio_rx_bclk",
> +				"audio_rx_mclk";
> +			status = "disabled";
> +		};
> +
> +		tdmplatform: qca-pcm-tdm at 7709000 {
> +			compatible = "qca,ipq4019-pcm-tdm";
> +			reg = <0x7709000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		tdm: tdm at 0 {
> +			compatible = "qca,ipq4019-tdm";
> +			dma-tx-channel = <MBOX0_TX_ID>;
> +			dma-rx-channel = <MBOX3_RX_ID>;
> +			stereo-tx-port = <STEREO0_ID>;
> +			stereo-rx-port = <STEREO3_ID>;
> +			clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +				<&adcc ADCC_TXM_CLK_SRC>,
> +				<&adcc ADCC_RXB_CLK_SRC>,
> +				<&adcc ADCC_RXM_CLK_SRC>;
> +			clock-names = "audio_tx_bclk",
> +				"audio_tx_mclk",
> +				"audio_rx_bclk",
> +				"audio_rx_mclk";
> +			status = "disabled";
> +		};
> +
> +		spdifplatform: qca-pcm-spdif at 7707000 {
> +			compatible = "qca,ipq4019-pcm-spdif";
> +			reg = <0x7707000 0x1000>;
> +			status = "disabled";
> +		};
> +
> +		spdif: spdif at 0 {
> +			compatible = "qca,ipq4019-spdif";
> +			dma-tx-channel = <MBOX0_TX_ID>;
> +			dma-rx-channel = <MBOX_SPDIF_RX_ID>;
> +			stereo-tx-port = <STEREO0_ID>;
> +			clocks = <&adcc ADCC_TXB_CLK_SRC>,
> +				<&adcc ADCC_TXM_CLK_SRC>,
> +				<&adcc ADCC_SPDIF_SRC>,
> +				<&adcc ADCC_SPDIFDIV2_SRC >,
> +				<&adcc ADCC_AUDIO_SPDIFINFAST_SRC>;
> +			clock-names = "audio_tx_bclk",
> +				"audio_tx_mclk",
> +				"audio_spdif_src",
> +				"audio_spdif_div2",
> +				"audio_spdifinfast_src";
> +			status = "disabled";
> +		};
> +
> +		sound: sound at 0 {
> +			compatible = "qca,ipq4019-audio";
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
