From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 2 Aug 2011 09:36:09 +0100
Subject: [PATCH] CSR: add missing sentinels to of_device_id tables
In-Reply-To: <20023.40012.119095.724255@ipc1.ka-ro>
References: <1312229376-5982-1-git-send-email-jamie@jamieiles.com>
	<20023.40012.119095.724255@ipc1.ka-ro>
Message-ID: <20110802083609.GA5063@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 08:42:20AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Jamie Iles writes:
> > The of_device_id tables used for matching should be terminated with
> > empty sentinel values.
> > 
> > Cc: Barry Song <baohua.song@csr.com>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > ---
> >  arch/arm/mach-prima2/clock.c |    1 +
> >  arch/arm/mach-prima2/irq.c   |    1 +
> >  arch/arm/mach-prima2/rstc.c  |    1 +
> >  arch/arm/mach-prima2/timer.c |    1 +
> >  4 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-prima2/clock.c b/arch/arm/mach-prima2/clock.c
> > index f9a2aaf..615a4e7 100644
> > --- a/arch/arm/mach-prima2/clock.c
> > +++ b/arch/arm/mach-prima2/clock.c
> > @@ -481,6 +481,7 @@ static void __init sirfsoc_clk_init(void)
> >  
> >  static struct of_device_id clkc_ids[] = {
> >  	{ .compatible = "sirf,prima2-clkc" },
> > +	{},
> I would add a comment like '/* end of list sentinel */' inside the
> '{}' to make it crystal clear that the empty braces are intentional.
> I also would omit the comma since it would be an error adding more
> entries after this one.

OK.  Revised patch below.

Thanks Lothar!

8<----

Date: Mon, 1 Aug 2011 21:09:36 +0100
Subject: [PATCH] CSR: add missing sentinels to of_device_id tables

The of_device_id tables used for matching should be terminated with
empty sentinel values.

Cc: Barry Song <baohua.song@csr.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-prima2/clock.c |    1 +
 arch/arm/mach-prima2/irq.c   |    1 +
 arch/arm/mach-prima2/rstc.c  |    1 +
 arch/arm/mach-prima2/timer.c |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/clock.c b/arch/arm/mach-prima2/clock.c
index f9a2aaf..7c56320 100644
--- a/arch/arm/mach-prima2/clock.c
+++ b/arch/arm/mach-prima2/clock.c
@@ -481,6 +481,7 @@ static void __init sirfsoc_clk_init(void)
 
 static struct of_device_id clkc_ids[] = {
 	{ .compatible = "sirf,prima2-clkc" },
+	{ /* Sentinel */ }
 };
 
 void __init sirfsoc_of_clk_init(void)
diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
index c3404cb..0f3ddb7 100644
--- a/arch/arm/mach-prima2/irq.c
+++ b/arch/arm/mach-prima2/irq.c
@@ -51,6 +51,7 @@ static __init void sirfsoc_irq_init(void)
 
 static struct of_device_id intc_ids[]  = {
 	{ .compatible = "sirf,prima2-intc" },
+	{ /* Sentinel */ }
 };
 
 void __init sirfsoc_of_irq_init(void)
diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index d074786..b0b5fa1 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -19,6 +19,7 @@ static DEFINE_MUTEX(rstc_lock);
 
 static struct of_device_id rstc_ids[]  = {
 	{ .compatible = "sirf,prima2-rstc" },
+	{ /* Sentinel */ }
 };
 
 static int __init sirfsoc_of_rstc_init(void)
diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
index 44027f3..366a9aa 100644
--- a/arch/arm/mach-prima2/timer.c
+++ b/arch/arm/mach-prima2/timer.c
@@ -190,6 +190,7 @@ static void __init sirfsoc_timer_init(void)
 
 static struct of_device_id timer_ids[] = {
 	{ .compatible = "sirf,prima2-tick" },
+	{ /* Sentinel */ }
 };
 
 static void __init sirfsoc_of_timer_map(void)
-- 
1.7.4.1
