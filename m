From: marcus.folkesson@gmail.com (Marcus Folkesson)
Date: Sat, 10 Feb 2018 09:54:06 +0100
Subject: [PATCH 7/7] watchdog: coh901327: make use of timeout-secs
 provided in devicetree
In-Reply-To: <20180209225200.GI19627@roeck-us.net>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-8-marcus.folkesson@gmail.com>
 <20180209225200.GI19627@roeck-us.net>
Message-ID: <20180210085406.GA744@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 09, 2018 at 02:52:00PM -0800, Guenter Roeck wrote:
> On Fri, Feb 09, 2018 at 08:27:24PM +0100, Marcus Folkesson wrote:
> > watchdog_init_timeout() will allways pick timeout_param since it
> > defaults to a valid timeout.
> > 
> > Following best practice described in
> > Documentation/watchdog/watchdog-kernel-api.txt to make use of
> > the parameter logic.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  drivers/watchdog/coh901327_wdt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
> > index 4410337f4f7f..437f865e5c6b 100644
> > --- a/drivers/watchdog/coh901327_wdt.c
> > +++ b/drivers/watchdog/coh901327_wdt.c
> > @@ -67,7 +67,7 @@
> >  #define U300_WDOG_IFR_WILL_BARK_IRQ_FORCE_ENABLE			0x0001U
> >  
> >  /* Default timeout in seconds = 1 minute */
> > -static unsigned int margin = 60;
> > +static unsigned int margin;
> >  static int irq;
> >  static void __iomem *virtbase;
> >  static struct device *parent;
> 
> I would suggest to initialize .timeout in 'static struct watchdog_device
> coh901327_wdt', and drop the error check when calling watchdog_init_timeout().

Will do, thank you.

> 
> Guenter


Best regards
Marcus Folkesson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180210/13b40f3d/attachment.sig>
