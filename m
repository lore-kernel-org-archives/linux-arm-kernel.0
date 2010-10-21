From: simon@sequanux.org (Simon Guinot)
Date: Thu, 21 Oct 2010 20:07:10 +0000
Subject: [PATCH 1/2] hwmon: add generic GPIO fan driver
In-Reply-To: <20101018160830.GB9033@ericsson.com>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
Message-ID: <20101021200710.GR29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Mon, Oct 18, 2010 at 09:08:30AM -0700, Guenter Roeck wrote:
> On Sun, Oct 17, 2010 at 11:50:11AM -0400, Simon Guinot wrote:
> > From: Simon Guinot <sguinot@lacie.com>
> > 
> > This patch adds hwmon support for the GPIO connected fan.
> > 
> > Platform specific informations as GPIO pinout and speed conversion array
> > (rpm from/to GPIO value) are passed to the driver via platform_data.
> > 
> > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> 
> Hi Simon,
> 
> good start. Bunch of comments inline. Our mailer was nice enough to replace tabs
> with blanks, thanks to our friends at MicroSomething, so I could not run the patch
> through checkpatch.pl. Hope you did that.
> 
> > ---
> >  drivers/hwmon/Kconfig    |    9 +
> >  drivers/hwmon/Makefile   |    1 +
> >  drivers/hwmon/gpio-fan.c |  508 ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/gpio-fan.h |   43 ++++
> >  4 files changed, 561 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/hwmon/gpio-fan.c
> >  create mode 100644 include/linux/gpio-fan.h
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 4d4d09b..1dc57c1 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -399,6 +399,15 @@ config SENSORS_GL520SM
> >           This driver can also be built as a module.  If so, the module
> >           will be called gl520sm.
> > 
> > +config SENSORS_GPIO_FAN
> > +       tristate "GPIO fan"
> > +       depends on GENERIC_GPIO
> > +       help
> > +         If you say yes here you get support for the GPIO connected fan.
> > +
> > +         This driver can also be built as a module.  If so, the module
> > +         will be called gpio-fan.
> > +
> 
> Can you move this up a bit, ahead of SENSORS_FSCHMD ? Trying to stay in sequence.

Ok. Let's try to figure out where is the right location :)
After SENSORS_GL520SM or not ?

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101021/8ce2d545/attachment.sig>
