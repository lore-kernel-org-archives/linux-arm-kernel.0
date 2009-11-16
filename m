From: avorontsov@ru.mvista.com (Anton Vorontsov)
Date: Mon, 16 Nov 2009 04:00:22 +0300
Subject: [PATCH 3/6] gta02: set pcf50633 charger_reference_current_ma
In-Reply-To: <20091111134844.GB22476@home.pavel.comp>
References: <1257369899-325-1-git-send-email-fercerpav@gmail.com>
	<1257369899-325-2-git-send-email-fercerpav@gmail.com>
	<1257369899-325-3-git-send-email-fercerpav@gmail.com>
	<20091111134844.GB22476@home.pavel.comp>
Message-ID: <20091116010022.GA4927@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2009 at 04:48:44PM +0300, Paul Fertser wrote:
> Hi,

Paul, thanks a lot for your work!

> Ben, please give us an advice on how to proceed with this rather
> trivial patch. Anton doesn't merge the other patches from this series
> because we do not know via which tree to merge this particular patch.

OK, a) the patch is trivial; b) signed off and acked by people who
cares about and actually use gta devices; c) we can't wait forever
(a month, that is), even though we do realize maintainers could be
busy.

So, I've applied this patch to battery-2.6.git. Ben, I hope you're
fine with it.

Thanks,

> On Thu, Nov 05, 2009 at 12:24:56AM +0300, Paul Fertser wrote:
> > From: Lars-Peter Clausen <lars@metafoo.de>
> > 
> > This value is board-specific and is needed for calculations to set charging
> > current limit properly.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Acked-by: Nelson Castillo <arhuaco@freaks-unidos.net>
> > Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > 
> > Since this patch compile-depends on previous probably it should go through
> > the same tree as others. Nelson (gta02 maintainer) agrees with whatever you
> > think is best.
> > 
> > Anton Vorontsov is ok with merging it through his tree but needs an explicit
> > ack.
> > 
> >  arch/arm/mach-s3c2442/mach-gta02.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2442/mach-gta02.c
> > index 0fb385b..b0a3d74 100644
> > --- a/arch/arm/mach-s3c2442/mach-gta02.c
> > +++ b/arch/arm/mach-s3c2442/mach-gta02.c
> > @@ -268,6 +268,9 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
> >  
> >  	.batteries = gta02_batteries,
> >  	.num_batteries = ARRAY_SIZE(gta02_batteries),
> > +
> > +	.charger_reference_current_ma = 1000,
> > +
> >  	.reg_init_data = {
> >  		[PCF50633_REGULATOR_AUTO] = {
> >  			.constraints = {
> > -- 
> > 1.6.4.4
> > 

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
