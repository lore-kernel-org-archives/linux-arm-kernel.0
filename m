From: pavel@denx.de (Pavel Machek)
Date: Wed, 17 Jun 2015 14:19:20 +0200
Subject: [PATCH 11/11] dt: Exynos: add Snow SPI NOR node.
In-Reply-To: <201506041720.54666.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com>
 <3234c12c90eabbeeb6d33604a324231937e309ec.1433364398.git.hramrach@gmail.com>
 <556FB222.2070406@samsung.com> <201506041720.54666.marex@denx.de>
Message-ID: <20150617121920.GB20728@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2015-06-04 17:20:54, Marek Vasut wrote:
> On Thursday, June 04, 2015 at 04:04:18 AM, Krzysztof Kozlowski wrote:
> > On 04.06.2015 06:26, Michal Suchanek wrote:
> > > The Snow has onboard SPI NOR flash which contains the bootloader.
> > > 
> > > Add DT node for this flash chip. The flash is rated 133MHz but the pl330
> > > controller can transfer only up to 128 bytes at this speed so use more
> > > conservative settings. Even at 40MHz pl330 can transfer at most 64k with
> > > the current driver.
> > > 
> > > Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> > > ---
> > > 
> > >  arch/arm/boot/dts/exynos5250-snow.dts | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/exynos5250-snow.dts
> > > b/arch/arm/boot/dts/exynos5250-snow.dts index 1fa72cf..38e4cda 100644
> > > --- a/arch/arm/boot/dts/exynos5250-snow.dts
> > > +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> > > @@ -691,6 +691,18 @@
> > > 
> > >  	num-cs = <1>;
> > >  	cs-gpios = <&gpa2 5 0>;
> > >  	status = "okay";
> > > 
> > > +		flash: m25p80 at 0 {
> > 
> > The indentation looks odd. This should be at the same level as "status".
> > 
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			compatible = "jedec,spi-nor";
> > > +			reg = <0>;
> > > +			spi-max-frequency = <40000000>;
> > 
> > So actually you wanted 133 MHz but as a workaround for DMA issue you use
> > 40 MHz, right? Could you add here a small TODO note in comment about it?
> 
> I disagree. There is a problem, the problem should actually be analyzed and 
> fixed, not just postponed with some TODO nonsense.

Of course, that would be preferable if submitter has time. But OTOH
slow SPI is probably better than no SPI at all, and debugging this can
be nasty. I think that TODO is suitable.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
