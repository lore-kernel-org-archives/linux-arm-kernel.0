From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 22 Aug 2012 19:02:10 +0800
Subject: [PATCH 6/7] ARM: dts: imx6q: add simple-bus compatible string
 for anatop
In-Reply-To: <20120822085236.GK4011@b20223-02.ap.freescale.net>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-7-git-send-email-b29396@freescale.com>
 <20120822085236.GK4011@b20223-02.ap.freescale.net>
Message-ID: <20120822110209.GC10057@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 04:52:36PM +0800, Zhao Richard-B20223 wrote:
> On Wed, Aug 22, 2012 at 03:18:47PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > Originally the anatop regulator devices are populated by mfd anatop driver.
> > Since mfd anatop driver will be deleted later, we change to populate the
> > regulator devices by devicetree automatically.
> > This will cause some warning messages as follows during boot due to device
> > recreation: "vdd1p1: Failed to create debugfs directory"
> > But it does not break any function.
> > Later, we will remove mfd anatop driver which can get rid of this
> > error message.
> > 
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > ---
> >  arch/arm/boot/dts/imx6q.dtsi |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> > index 7076be0..426f735 100644
> > --- a/arch/arm/boot/dts/imx6q.dtsi
> > +++ b/arch/arm/boot/dts/imx6q.dtsi
> > @@ -379,7 +379,7 @@
> >  			};
> >  
> >  			anatop: anatop at 020c8000 {
> > -				compatible = "fsl,imx6q-anatop", "fsl,imx-syscon";
> > +				compatible = "fsl,imx6q-anatop", "fsl,imx-syscon", "simple-bus";
> To prevent bisect break, it should merge with patch #4.
Yes, i will try it and merge them if needed.

> It's really strange to use simple-bus, because it's not a bus.
I can't say it's strange or not.
There are existing using examples, imx28.dtsi.

> I like more the way how anatop driver handle it. Anatop driver populate
> devices in its code.
The anatop mfd driver will be deleted later.
So the proper solution may be generating regulator devices automatically when call
of_platform_populate in mach code rather than populate it in driver itself.

Regards
Dong Aisheng
