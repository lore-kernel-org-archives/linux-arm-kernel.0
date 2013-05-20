From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 13:30:20 -0400
Subject: [PATCH] ARM: plat-orion: Fix num_resources and id for ge10 and
 ge11
In-Reply-To: <20130520172424.GI26249@lunn.ch>
References: <1368994363-14762-1-git-send-email-gregory.clement@free-electrons.com>
 <20130520082205.GC26249@lunn.ch>
 <20130520171301.GV31290@titan.lakedaemon.net>
 <20130520172424.GI26249@lunn.ch>
Message-ID: <20130520173020.GY31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 07:24:24PM +0200, Andrew Lunn wrote:
> On Mon, May 20, 2013 at 01:13:01PM -0400, Jason Cooper wrote:
> > On Mon, May 20, 2013 at 10:22:05AM +0200, Andrew Lunn wrote:
> > > On Sun, May 19, 2013 at 10:12:43PM +0200, Gregory CLEMENT wrote:
> > > > When platform data were moved from arch/arm/mach-mv78xx0/common.c to
> > > > arch/arm/plat-orion/common.c with the commit "7e3819d ARM: orion:
> > > > Consolidate ethernet platform data", there were few typo made on
> > > > gigabit Ethernet interface ge10 and ge11. This commit writes back
> > > > their initial value, which allows to use this interfaces again.
> > > > 
> > > > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > > > ---
> > > >  arch/arm/plat-orion/common.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> > > > index 251f827..c019b7a 100644
> > > > --- a/arch/arm/plat-orion/common.c
> > > > +++ b/arch/arm/plat-orion/common.c
> > > > @@ -383,7 +383,7 @@ static struct resource orion_ge10_shared_resources[] = {
> > > >  
> > > >  static struct platform_device orion_ge10_shared = {
> > > >  	.name		= MV643XX_ETH_SHARED_NAME,
> > > > -	.id		= 1,
> > > > +	.id		= 2,
> > > >  	.dev		= {
> > > >  		.platform_data	= &orion_ge10_shared_data,
> > > >  	},
> > > > @@ -398,8 +398,8 @@ static struct resource orion_ge10_resources[] = {
> > > >  
> > > >  static struct platform_device orion_ge10 = {
> > > >  	.name		= MV643XX_ETH_NAME,
> > > > -	.id		= 1,
> > > > -	.num_resources	= 2,
> > > > +	.id		= 2,
> > > > +	.num_resources	= 1,
> > > >  	.resource	= orion_ge10_resources,
> > > >  	.dev		= {
> > > >  		.coherent_dma_mask	= DMA_BIT_MASK(32),
> > > > @@ -432,7 +432,7 @@ static struct resource orion_ge11_shared_resources[] = {
> > > >  
> > > >  static struct platform_device orion_ge11_shared = {
> > > >  	.name		= MV643XX_ETH_SHARED_NAME,
> > > > -	.id		= 1,
> > > > +	.id		= 3,
> > > >  	.dev		= {
> > > >  		.platform_data	= &orion_ge11_shared_data,
> > > >  	},
> > > > @@ -447,8 +447,8 @@ static struct resource orion_ge11_resources[] = {
> > > >  
> > > >  static struct platform_device orion_ge11 = {
> > > >  	.name		= MV643XX_ETH_NAME,
> > > > -	.id		= 1,
> > > > -	.num_resources	= 2,
> > > > +	.id		= 3,
> > > > +	.num_resources	= 1,
> > > >  	.resource	= orion_ge11_resources,
> > > >  	.dev		= {
> > > >  		.coherent_dma_mask	= DMA_BIT_MASK(32),
> > > > -- 
> > > > 1.8.1.2
> > > > 
> > > 
> > > Hi Gregory
> > > 
> > > My Bad. Thanks for fixing this.
> > > 
> > > Acked-by: Andrew Lunn <andrew@lunn.ch>
> > > 
> > > Jason, this can go into stable, as far back as 3.0.
> > 
> > Ok, thanks for the heads up.  I'll wait for v2 (with rmk's suggestion)
> > and tag it for stable.
> 
> Hi Jason
> 
> RMK suggestion would apply to the whole file, not just this one
> instance. As such, it would be a bigger patch going into -cleanup for
> the next merge window.
> 
> I suggest you take this patch as is for the next -rc and i can work on
> RMKs suggestion soon along with a couple of other cleanups.

ok, sounds good.  I'll queue it up for the next /fixes PR.

thx,

Jason.
