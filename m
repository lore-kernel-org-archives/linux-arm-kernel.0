From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 10:57:02 +0100
Subject: [PATCH 07/17] Documentation: Define the MSP Driver Device Tree
 bindings
In-Reply-To: <504EFF86.10105@stericsson.com>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
 <1345816913-4113-8-git-send-email-lee.jones@linaro.org>
 <20120910164333.GB24506@gmail.com> <504EFF86.10105@stericsson.com>
Message-ID: <20120914095659.GQ3374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 11:08:22AM +0200, Ola Lilja wrote:
> On 09/10/2012 06:43 PM, Lee Jones wrote:
> 
> > Ola poke.
> > 
> > On Fri, Aug 24, 2012 at 03:01:43PM +0100, Lee Jones wrote:
> >> Here we add the required documentation for the new Device Tree
> >> bindings pertaining to the MSP CPU-side DAI Driver.
> >> 
> >> CC: alsa-devel at alsa-project.org
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> ---
> >>  .../devicetree/bindings/sound/ux500-msp.txt        |   43 ++++++++++++++++++++
> >>  1 file changed, 43 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/sound/ux500-msp.txt
> >> 
> >> diff --git a/Documentation/devicetree/bindings/sound/ux500-msp.txt b/Documentation/devicetree/bindings/sound/ux500-msp.txt
> >> new file mode 100644
> >> index 0000000..99acd9c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/ux500-msp.txt
> >> @@ -0,0 +1,43 @@
> >> +* ux500 MSP (CPU-side Digital Audio Interface)
> >> +
> >> +Required properties:
> >> + - compatible       :"stericsson,ux500-msp-i2s"
> >> + - reg              : Physical base address and length of the device's registers.
> >> +
> >> +Optional properties:
> >> + - interrupts       : The interrupt output from the device.
> >> + - interrupt-parent : The parent interrupt controller.
> >> + - <name>-supply    : Phandle to the regulator <name> supply
> >> +
> >> +Example:
> >> +
> >> +	sound {
> >> +		compatible = "stericsson,snd-soc-mop500";
> >> +
> >> +		stericsson,platform-pcm-dma = <&pcm>;
> >> +		stericsson,cpu-dai = <&msp1 &msp3>;
> >> +		stericsson,audio-codec = <&codec>;
> >> +	};
> >> +
> >> +	pcm: ux500-pcm {
> >> +		compatible = "stericsson,ux500-pcm";
> >> +	};
> >> +
> >> +	msp1: msp at 80124000 {
> >> +		compatible = "stericsson,ux500-msp-i2s";
> >> +		reg = <0x80124000 0x1000>;
> >> +		interrupts = <0 62 0x4>;
> >> +		v-ape-supply = <&db8500_vape_reg>;
> >> +	};
> >> +
> >> +	msp3: msp at 80125000 {
> >> +		compatible = "stericsson,ux500-msp-i2s";
> >> +		reg = <0x80125000 0x1000>;
> >> +		interrupts = <0 62 0x4>;
> >> +		v-ape-supply = <&db8500_vape_reg>;
> >> +	};
> >> +
> >> +	codec: ab8500-codec {
> >> +		compatible = "stericsson,ab8500-codec";
> >> +		stericsson,earpeice-cmv = <950>; /* Units in mV. */
> 
> 
> This parameter has nothing to do with the ASoC platform-driver. Some way or the
> other the earpiece-cmv should belong to the codec-driver. Also, this parameter
> was set in the previous patch as well?!

You know that this is just a documentation patch right?

It just shows how the pieces fit together. No settings will actually
be read from here, it's just a .txt file used for reference.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
