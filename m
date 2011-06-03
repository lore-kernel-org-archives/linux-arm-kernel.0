From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 3 Jun 2011 23:26:44 +0800
Subject: [PATCH v2 0/4] Move plat-mxc gpio driver into drivers/gpio
In-Reply-To: <BANLkTi=5kNAt51DP3-rykkT3ZONczD5Crg@mail.gmail.com>
References: <1306985632-18820-1-git-send-email-shawn.guo@linaro.org>
	<20110603075201.GE10532@n2100.arm.linux.org.uk>
	<20110603143406.GA19344@S2100-06.ap.freescale.net>
	<BANLkTi=5kNAt51DP3-rykkT3ZONczD5Crg@mail.gmail.com>
Message-ID: <20110603152643.GB19344@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Fri, Jun 03, 2011 at 08:55:58AM -0600, Grant Likely wrote:
> On Fri, Jun 3, 2011 at 8:34 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > Hi Russell,
> >
> > On Fri, Jun 03, 2011 at 08:52:01AM +0100, Russell King - ARM Linux wrote:
> >> On Thu, Jun 02, 2011 at 11:33:48AM +0800, Shawn Guo wrote:
> >> > ?arch/arm/plat-mxc/gpio.c ? ? ? ? ? ? ? ? ? ? ? ?| ?361 -------------------
> >> > ?drivers/gpio/gpio-mxc.c ? ? ? ? ? ? ? ? ? ? ? ? | ?433 +++++++++++++++++++++++
> >>
> > My bad here. ?I should have used 'git diff --stat -M' to show the
> > the following.
> >
> > .../arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c | ?216 +++++++++++++-------
> >
> >> I'm wondering why just moving this driver into drivers/gpio has
> >> resulted in it growing by 72 lines - and it's not clear from the
> >> diffs why that is because of the way they're broken up.
> >>
> > Yes, I agree. ?But when I did something like that to ease the review,
> > people think it's not necessary :)
> >
> > http://permalink.gmane.org/gmane.linux.kernel/1143257
> 
> The issue was bisectability: it looked like the build would break
> after applying the first patch.  The first patch should move the

Yes, the build would break only if you change Kconfig/Makefile to
actually build it.  The patch does not enable the build of the driver
in the patch.

> driver without breaking the build, and then you can follow up with
> driver fixes.  I don't want to see functional changes mixed in with
> the file move change.
> 
Understood.  Do you want me to resend the gpio-mxs and gpio-mxc patch
sets for that?  Or can I follow the practice you and Russell
suggested in the future posts?  I have learnt the lesson.

> > +
> > +static struct platform_driver mxc_gpio_driver = {
> > + ? ? ? .driver ? ? ? ? = {
> > + ? ? ? ? ? ? ? .name ? = "gpio-mxc",
> 
> .owner = THIS_MODULE,
> 
Do I need to re-spin the patch set to fix it, or maintainer (you or
Sascha) can help to fix it up?

BTW, do you and Sascha get the agreement on which tree the gpio-mxs
and gpio-mxc should go through?

-- 
Regards,
Shawn
