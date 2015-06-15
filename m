From: koro.chen@mediatek.com (Koro Chen)
Date: Mon, 15 Jun 2015 10:31:45 +0800
Subject: [PATCH 2/3] ASoC: mediatek: Add machine driver for MAX98090 codec
In-Reply-To: <20150612131325.GA1921@sirena.org.uk>
References: <1433946276-25969-1-git-send-email-koro.chen@mediatek.com>
 <1433946276-25969-3-git-send-email-koro.chen@mediatek.com>
 <20150612131325.GA1921@sirena.org.uk>
Message-ID: <1434335505.14980.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-06-12 at 14:13 +0100, Mark Brown wrote:
> On Wed, Jun 10, 2015 at 10:24:35PM +0800, Koro Chen wrote:
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/mt8173-max98090.txt
> > @@ -0,0 +1,17 @@
> > +MT8173 with MAX98090 CODEC
> > +
> > +Required properties:
> > +- compatible : "mediatek,mt8173-max98090"
> > +- mediatek,audio-codec: the phandle of the MAX98090 audio codec
> > +- dvdd-supply : the phandle of regulator to supply 1.2V
> > +- avdd-supply : the phandle of regulator to supply 1.8V
> 
> Why are these supplies part of the machine driver?
> 
These are for the codec as you said. I think I should remove all these
supplies as well as codes in machine drivers, since now the regulators
are configured during the board's bootloader stage.

> > +config SND_SOC_MT8173_MAX98090
> > +	bool "ASoC Audio driver for MT8173 with MAX98090 codec"
> 
> Why bool?
> 
This should be tristate as Paul mentioned before. I will fix it.
> > +	codec_node = of_parse_phandle(pdev->dev.of_node,
> > +				      "mediatek,audio-codec", 0);
> > +	if (!codec_node) {
> > +		dev_err(&pdev->dev,
> > +			"Property 'audio-codec' missing or invalid\n");
> > +	} else {
> 
> Isn't this a fatal error?
> 
Thank you and yes it should be fatal, I will fix it.
