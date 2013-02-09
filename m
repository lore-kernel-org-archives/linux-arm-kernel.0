From: balbi@ti.com (Felipe Balbi)
Date: Sat, 9 Feb 2013 22:58:31 +0200
Subject: [PATCH 7/7] ARM: omap2: gpmc-onenand: Replace printk KERN_ERR
 with dev_warn()
In-Reply-To: <20130209180530.GC32349@localhost>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360427896-12004-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130209165532.GB13338@arwen.pp.htv.fi>
 <20130209180530.GC32349@localhost>
Message-ID: <20130209205831.GB14543@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 09, 2013 at 03:05:31PM -0300, Ezequiel Garcia wrote:
> On Sat, Feb 09, 2013 at 06:55:32PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Sat, Feb 09, 2013 at 01:38:16PM -0300, Ezequiel Garcia wrote:
> > > Since the condition is not an error but a warning, replace
> > > printk KERN_ERR with dev_warn.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  arch/arm/mach-omap2/gpmc-onenand.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
> > > index 4771945..fd6e35b 100644
> > > --- a/arch/arm/mach-omap2/gpmc-onenand.c
> > > +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> > > @@ -367,7 +367,7 @@ void gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
> > >  
> > >  	if (cpu_is_omap24xx() &&
> > >  			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
> > > -		printk(KERN_ERR "Onenand using only SYNC_READ on 24xx\n");
> > > +		dev_warn(dev, "OneNAND using only SYNC_READ on 24xx\n");
> > 
> > it would seem more natural to use dev_err() instead.
> > 
> 
> Are you sure? The error seems more a warning to me,
> although I guess it's arguable.
> 
> Let me know and I'll fix it in v2.

my bad, should've read the code more carefuly. Indeed it looks more like
a warning as we continue to try to use the IP. My bad.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130209/3e00d098/attachment.sig>
