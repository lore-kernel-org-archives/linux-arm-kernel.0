From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 13 May 2015 21:58:03 +0800
Subject: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <20150513111051.GH3066@sirena.org.uk>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk> <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk>
 <1431509166.25254.12.camel@mtksdaap41>
 <20150513111051.GH3066@sirena.org.uk>
Message-ID: <1431525483.25254.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-13 at 12:10 +0100, Mark Brown wrote:
> On Wed, May 13, 2015 at 05:26:06PM +0800, Yingjoe Chen wrote:
> > On Tue, 2015-05-12 at 17:05 +0100, Mark Brown wrote:
> 
> > > > > There were three compatible strings listed in the DT binding but only
> > > > > two here.
> 
> > > > And I test it's ok on MT8135 platform. So I add struct of_device_id
> > > > mtk_spi_of_match like this in spi driver code.
> 
> > > You should list all the compatibles documented in the binding here, if
> > > some of them are the same just have them map to a single constant.
> 
> > Just for clarification. If we want to add spi support for a new soc, say
> > mt8127, which we think is compatible to mt6589. Since it may turn out we
> > need special handling for this soc latter, it is suggested to write
> > compatible like this in mt8127.dtsi:
> 
> >    compatible = "mediatek,mt8127-spi",
> >  	        "mediatek,mt6589-spi";
> 
> > Device tree binding should list all possible compatible string in .dts,
> > so we'll have to add that to binding as well.
> 
> >      - mediatek,mt6589-spi: for mt6589 platforms
> > +    - mediatek,mt8127-spi: for mt8127 platforms
> 
> > Then we'll also need to add this to source code to reflect this.
> 
> > 	{ .compatible = "mediatek,mt6589-spi", .data = (void *)COMPAT_MT6589},
> > +	{ .compatible = "mediatek,mt8127-spi", .data = (void *)COMPAT_MT6589},
> 
> > This seems to introduce lots of trivial patches just to add a compatible
> > device to me...
> 
> Yes, but that's how DT works and as you say these patches are all
> trivial so it's not like they take any appreciable effort.

Yes, that's shouldn't be a big effort.
Thanks for clarification.

Joe.C
