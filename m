From: mturquette@ti.com (Mike Turquette)
Date: Wed, 19 Sep 2012 09:42:31 -0700
Subject: [PATCH 3/4] mfd: dbx500: Provide a more accurate smp_twd clock
In-Reply-To: <20120919160251.GM28670@sortiz-mobl>
References: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
 <1346415691-13371-4-git-send-email-ulf.hansson@stericsson.com>
 <20120919160251.GM28670@sortiz-mobl>
Message-ID: <20120919164231.17033.27762@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Samuel Ortiz (2012-09-19 09:02:51)
> Hi Ulf,
> 
> On Fri, Aug 31, 2012 at 02:21:30PM +0200, Ulf Hansson wrote:
> > From: Michel Jaouen <michel.jaouen@stericsson.com>
> > 
> > The local timer clock is based on ARM subsystem clock. This patch
> > obtains a more exact value of that clock by reading PRCMU registers.
> > Using this increases the accuracy of the local timer events.
> > 
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
> > Signed-off-by: Michel Jaouen <michel.jaouen@stericsson.com>
> > ---
> >  drivers/mfd/db8500-prcmu.c       |   42 ++++++++++++++++++++++++++++++++++++++
> >  drivers/mfd/dbx500-prcmu-regs.h  |    4 +++-
> >  include/linux/mfd/dbx500-prcmu.h |    1 +
> >  3 files changed, 46 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> > index 4f74529..e7f9539 100644
> > --- a/drivers/mfd/db8500-prcmu.c
> > +++ b/drivers/mfd/db8500-prcmu.c
> > @@ -418,6 +418,9 @@ static struct {
> >  
> >  static atomic_t ac_wake_req_state = ATOMIC_INIT(0);
> >  
> > +/* Functions definition */
> > +static void compute_armss_rate(void);
> > +
> I'm not a big fan of forward declarations, but I still applied your patch to
> my for-next branch. Thanks.
> 

Samuel,

Not sure if you were Cc'd on the rest of the patches in this series but
after some discussion (see patch #1) I took all four patches into
clk-next, including the MFD change.  This was done first week of
September.  At this point those patches have shifted into my stable
branch that I have promised not to rebase (for arm-soc dependencies).

Are you OK with me taking this patch through the clk-next branch?

Regards,
Mike

> Cheers,
> Samuel.
> 
> -- 
> Intel Open Source Technology Centre
> http://oss.intel.com/
