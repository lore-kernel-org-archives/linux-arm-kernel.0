From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Mar 2012 21:22:29 +0800
Subject: [PATCH v2 1/1] ARM: imx28: add basic dt support
In-Reply-To: <20120328095346.GA31901@shlinux2.ap.freescale.net>
References: <1332513070-5400-1-git-send-email-b29396@freescale.com>
 <20120328055801.GA3953@S2100-06.ap.freescale.net>
 <20120328095346.GA31901@shlinux2.ap.freescale.net>
Message-ID: <20120328132227.GA3254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 05:53:47PM +0800, Dong Aisheng wrote:
> On Wed, Mar 28, 2012 at 01:58:04PM +0800, Guo Shawn-R65073 wrote:
> > On Fri, Mar 23, 2012 at 10:31:10PM +0800, Dong Aisheng wrote:
> > > From: Dong Aisheng <dong.aisheng@linaro.org>
...
> > > +static const char *imx28_dt_compat[] __initdata = {
> > 
> > mxs_dt_compat
> > 
> If changed like that, is it reasonable for mx23 to use this
> compatible string list?
> I planed to have separate compatible string for mx23 and mx28.

Ok, I'm fine with that, since we will have separate DT_MACHINE_START
for imx23 and imx28.

> 
> > > +	"fsl,imx28",
> > > +	"fsl,imx28-evk",
> > 
> > I would have the list sorted from the most specific to the most
> > general.  That said, it's better to have "fsl,imx28" sorted after
> > "fsl,imx28-evk".
> > 
> I prefer to keep the basic one first, then for future boards support
> we just add them below rather than insert above the basic one "fsl,imx28".
> However, it's really not a big deal.
> If you persist to do like that, i can also do it.
> 
Yes, please.  Listing items from the most specific to the general is
the rule for compatible property and match table.

-- 
Regards,
Shawn
