From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 30 Dec 2010 16:33:19 +0800
Subject: [PATCH 09/10] ARM: mx28: read fec mac address from ocotp
In-Reply-To: <20101229124506.GE14221@pengutronix.de>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-10-git-send-email-shawn.guo@freescale.com>
	<20101229105328.GX14221@pengutronix.de>
	<20101229121354.GJ19347@freescale.com>
	<20101229124506.GE14221@pengutronix.de>
Message-ID: <20101230083318.GB28246@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Dec 29, 2010 at 01:45:06PM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Wed, Dec 29, 2010 at 08:13:55PM +0800, Shawn Guo wrote:
> > On Wed, Dec 29, 2010 at 11:53:28AM +0100, Uwe Kleine-K?nig wrote:
> > > On Tue, Dec 28, 2010 at 10:55:54PM +0800, Shawn Guo wrote:
> > > > Read fec mac address from ocotp and save it into fec_platform_data
> > > > mac field for fec driver to use.
> > > > 
> > > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > > ---
> > > >  arch/arm/mach-mxs/devices/platform-fec.c        |    2 +-
> > > >  arch/arm/mach-mxs/include/mach/devices-common.h |    2 +-
> > > >  arch/arm/mach-mxs/mach-mx28evk.c                |   31 +++++++++++++++++++++++
> > > >  3 files changed, 33 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-mxs/devices/platform-fec.c b/arch/arm/mach-mxs/devices/platform-fec.c
> > > > index c08168c..dc978ee 100644
> > > > --- a/arch/arm/mach-mxs/devices/platform-fec.c
> > > > +++ b/arch/arm/mach-mxs/devices/platform-fec.c
> > > > @@ -31,7 +31,7 @@ const struct mxs_fec_data mx28_fec_data[] __initconst = {
> > > >  
> > > >  struct platform_device *__init mxs_add_fec(
> > > >  		const struct mxs_fec_data *data,
> > > > -		const struct fec_platform_data *pdata)
> > > > +		struct fec_platform_data *pdata)
> > > >  {
> > > >  	struct resource res[] = {
> > > >  		{
> > > > diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
> > > > index fca0551..d206e0a 100644
> > > > --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> > > > +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> > > > @@ -38,4 +38,4 @@ struct mxs_fec_data {
> > > >  };
> > > >  struct platform_device *__init mxs_add_fec(
> > > >  		const struct mxs_fec_data *data,
> > > > -		const struct fec_platform_data *pdata);
> > > > +		struct fec_platform_data *pdata);
> > > Why that?
> > > 
> > pdata->mac needs to get assigned by ocotp read function.
> ... which is done before mxs_add_fec is called.
> 
My bad. Will add it back.

-- 
Regards,
Shawn
