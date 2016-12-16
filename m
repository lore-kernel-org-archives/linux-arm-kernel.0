From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 10:23:43 +0100
Subject: [PATCH] ARM: imx: remove unused device definitions
In-Reply-To: <7e077d23-eec1-6a6a-9318-84a5543d684d@pengutronix.de>
References: <20161216090533.2195228-1-arnd@arndb.de>
 <7e077d23-eec1-6a6a-9318-84a5543d684d@pengutronix.de>
Message-ID: <3673316.UJiiIZbYgE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 16, 2016 10:10:49 AM CET Marc Kleine-Budde wrote:
> On 12/16/2016 10:05 AM, Arnd Bergmann wrote:
> > I stumbled over these during build testing, they are evidently
> > not referenced anywhere any more.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/mach-imx/devices/platform-flexcan.c         |  9 ---------
> >  arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c | 10 ----------
> >  2 files changed, 19 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/devices/platform-flexcan.c b/arch/arm/mach-imx/devices/platform-flexcan.c
> > index 55d61eaf63c6..8a1a2fc4ce10 100644
> > --- a/arch/arm/mach-imx/devices/platform-flexcan.c
> > +++ b/arch/arm/mach-imx/devices/platform-flexcan.c
> > @@ -19,15 +19,6 @@
> >  #define imx_flexcan_data_entry(soc, _id, _hwid, _size)			\
> >  	[_id] = imx_flexcan_data_entry_single(soc, _id, _hwid, _size)
> >  
> > -#ifdef CONFIG_SOC_IMX25
> > -const struct imx_flexcan_data imx25_flexcan_data[] __initconst = {
> > -#define imx25_flexcan_data_entry(_id, _hwid)				\
> > -	imx_flexcan_data_entry(MX25, _id, _hwid, SZ_16K)
> > -	imx25_flexcan_data_entry(0, 1),
> > -	imx25_flexcan_data_entry(1, 2),
> > -};
> > -#endif /* ifdef CONFIG_SOC_IMX25 */
> > -
> >  #ifdef CONFIG_SOC_IMX35
> >  const struct imx_flexcan_data imx35_flexcan_data[] __initconst = {
> >  #define imx35_flexcan_data_entry(_id, _hwid)				\
> 
> What about the imx35 variant?
> 

It's used from here:

arch/arm/mach-imx/mach-pcm043.c:        imx35_add_flexcan1();

	Arnd
