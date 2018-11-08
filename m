From: jbrunet@baylibre.com (jbrunet at baylibre.com)
Date: Thu, 08 Nov 2018 17:29:47 +0100
Subject: [PATCH 3/4] Documentation: bindings: Add missing Amlogic SCPI
 sensor bindings
In-Reply-To: <20181108160457.GA10953@e107155-lin>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
 <20181108135352.8459-4-jbrunet@baylibre.com>
 <20181108160457.GA10953@e107155-lin>
Message-ID: <a52c64d6159c73e1cb97089ed051321f121f0467.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-11-08 at 16:04 +0000, Sudeep Holla wrote:
> On Thu, Nov 08, 2018 at 02:53:51PM +0100, Jerome Brunet wrote:
> > amlogic,meson-gxbb-scpi-sensors is both the driver and DT but is not
> > documented. Just add it to amlogic's scpi documentation
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/arm/amlogic,scpi.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> > b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> > index 7b9a861e9306..5ab59da052df 100644
> > --- a/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> > +++ b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> > @@ -17,4 +17,11 @@ Required sub-node properties:
> >  - compatible : should be "amlogic,meson-gxbb-scp-shmem" for SRAM based
> > shared
> >  		memory on Amlogic GXBB SoC.
> >  
> > +Sensor bindings for the sensors based on SCPI Message Protocol
> > +--------------------------------------------------------------
> > +SCPI provides an API to access the various sensors on the SoC.
> > +
> > +Required properties:
> > +- compatible : should be "amlogic,meson-gxbb-scpi-sensors".
> > +
> 
> Not sure if it's worth mentioning the reason for being able to identify
> amlogic,meson-gxbb sensors from generic scpi ones. IIRC it was for the
> unit values of these sensors are different ? But I will leave that to
> DT or platform maintainers' taste.

Yes Sudeep, the unit are different.
If we probe on the generic one, it will "work" but the result is just not
good. 

BTW, the point of this patch is merely to remove an existing issue.
The scpi driver and meson-gx.dtsi are both refering to an undocumented
compatible.

> 
> --
> Regards,
> Sudeep
