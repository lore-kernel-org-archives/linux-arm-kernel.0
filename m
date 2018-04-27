From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Fri, 27 Apr 2018 10:26:14 +0200
Subject: [PATCH v7 08/11] ARM: sun9i: smp: Add is_a83t field
In-Reply-To: <20180423081423.h7b35sobagypokpe@flea>
References: <20180420211022.11759-1-mylene.josserand@bootlin.com>
 <20180420211022.11759-9-mylene.josserand@bootlin.com>
 <20180423081423.h7b35sobagypokpe@flea>
Message-ID: <20180427102614.1558a1ae@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 23 Apr 2018 10:14:23 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Fri, Apr 20, 2018 at 11:10:19PM +0200, Myl?ne Josserand wrote:
> > To prepare the support of sun8i-a83t, add a field in the smp_data
> > structure to know if we are on sun9i-a80 or sun8i-a83t.
> > 
> > Add also a global variable to retrieve which architecture we are
> > having.
> > 
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/mc_smp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> > index 03f021d0c73e..48e5f4db64b6 100644
> > --- a/arch/arm/mach-sunxi/mc_smp.c
> > +++ b/arch/arm/mach-sunxi/mc_smp.c
> > @@ -74,6 +74,7 @@ static void __iomem *sram_b_smp_base;
> >  
> >  extern void sunxi_mc_smp_secondary_startup(void);
> >  extern void sunxi_mc_smp_resume(void);
> > +static int is_a83t;
> >  
> >  static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
> >  {
> > @@ -624,6 +625,7 @@ struct sunxi_mc_smp_nodes {
> >  struct sunxi_mc_smp_data {
> >  	const char *enable_method;
> >  	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
> > +	int is_a83t;  
> 
> This can be made a boolean.
> 
> Maxime
> 

ACK. It will be fixed in next version.

Best regards,

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
