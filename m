From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 May 2010 11:27:27 -0700
Subject: [PATCH 14/18] omap: Overo: Add support for second ethernet port
In-Reply-To: <AANLkTinxHaxG89pUhD7nmMjQSF-p-FB1FWj_w-de9y1r@mail.gmail.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
	<20100505193315.21568.55530.stgit@baageli.muru.com>
	<AANLkTinxHaxG89pUhD7nmMjQSF-p-FB1FWj_w-de9y1r@mail.gmail.com>
Message-ID: <20100519182727.GG5818@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Steve Sakoman <sakoman@gmail.com> [100518 06:36]:
> On Wed, May 5, 2010 at 12:33 PM, Tony Lindgren <tony@atomide.com> wrote:
> > From: Steve Sakoman <steve@sakoman.com>
> >
> > Some Overo add-on boards include a second ethernet port. ?This patch
> > adds support for that second port.
> >
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > ?arch/arm/mach-omap2/board-overo.c | ? 14 +++++++++++++-
> > ?1 files changed, 13 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> > index 8848c7c..79ac414 100644
> > --- a/arch/arm/mach-omap2/board-overo.c
> > +++ b/arch/arm/mach-omap2/board-overo.c
> > @@ -63,6 +63,8 @@
> >
> > ?#define OVERO_SMSC911X_CS ? ? ?5
> > ?#define OVERO_SMSC911X_GPIO ? ?176
> > +#define OVERO_SMSC911X2_CS ? ? 4
> > +#define OVERO_SMSC911X2_GPIO ? 65
> >
> > ?#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> > ? ? ? ?defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> > @@ -137,6 +139,16 @@ static struct resource overo_smsc911x_resources[] = {
> > ? ? ? ?},
> > ?};
> >
> > +static struct resource overo_smsc911x2_resources[] = {
> > + ? ? ? {
> > + ? ? ? ? ? ? ? .name ? = "smsc911x2-memory",
> > + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> > + ? ? ? },
> > + ? ? ? {
> > + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
> > + ? ? ? },
> > +};
> > +
> > ?static struct smsc911x_platform_config overo_smsc911x_config = {
> > ? ? ? ?.irq_polarity ? = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
> > ? ? ? ?.irq_type ? ? ? = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
> > @@ -146,7 +158,7 @@ static struct smsc911x_platform_config overo_smsc911x_config = {
> >
> > ?static struct platform_device overo_smsc911x_device = {
> > ? ? ? ?.name ? ? ? ? ? = "smsc911x",
> > - ? ? ? .id ? ? ? ? ? ? = -1,
> > + ? ? ? .id ? ? ? ? ? ? = 0,
> > ? ? ? ?.num_resources ?= ARRAY_SIZE(overo_smsc911x_resources),
> > ? ? ? ?.resource ? ? ? = overo_smsc911x_resources,
> > ? ? ? ?.dev ? ? ? ? ? ?= {
> >
> > --
> 
> I just noticed that somehow a good portion of my original patch got
> dropped in this version!

It seems to be a patchwork issue, note how some of that got into the commit
message:

https://patchwork.kernel.org/patch/91277/

Might be worth investigating further, there's the mbox link there, maybe
that contains some clues.
 
> Original:
> 
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg26350.html
> 
> How would you like to handle getting the missing chuncks?

Can you please post your fix as a reply to this thread? I've already
merged the original patch into omap-for-linus, this is too late to
start messing with that.

Regards,

Tony
