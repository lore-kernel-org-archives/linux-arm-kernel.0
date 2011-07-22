From: philippe.retornaz@epfl.ch (Philippe =?utf-8?q?R=C3=A9tornaz?=)
Date: Fri, 22 Jul 2011 15:21:27 +0200
Subject: [PATCH 5/6] mc13783: add power button support
In-Reply-To: <4E28CD3F.5010006@cn.fujitsu.com>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
	<1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch>
	<4E28CD3F.5010006@cn.fujitsu.com>
Message-ID: <201107221521.27625.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 22 juillet 2011 03:07:11, Wanlong Gao a ?crit :
> On 07/22/2011 02:04 AM, Philippe R?tornaz wrote:
> > This adds support for the power-on buttons of MC13783 PMIC.
> > This is done using a misc input device.
> > 
> > Signed-off-by: Philippe R?tornaz<philippe.retornaz@epfl.ch>
> > ---
> > 
> >   drivers/input/misc/Kconfig             |   10 +
> >   drivers/input/misc/Makefile            |    1 +
> >   drivers/input/misc/mc13783-pwrbutton.c |  288
> >   ++++++++++++++++++++++++++++++++ drivers/mfd/mc13xxx-core.c           
> >    |    4 +
> >   include/linux/mfd/mc13783.h            |    1 +
> >   include/linux/mfd/mc13xxx.h            |   17 ++
> >   6 files changed, 321 insertions(+), 0 deletions(-)
> >   create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
> > 
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index 45dc6aa..4272658 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -100,6 +100,16 @@ config INPUT_MAX8925_ONKEY
> > 
> >   	  To compile this driver as a module, choose M here: the module
> >   	  will be called max8925_onkey.
> > 
> > +struct mc13783_pwrb {
> > +	struct input_dev *pwr;
> > +	struct mc13xxx *mc13783;
> > +#define MC13783_PWRB_B1_POL_INVERT	(1<<  0)
> > +#define MC13783_PWRB_B2_POL_INVERT	(1<<  1)
> > +#define MC13783_PWRB_B3_POL_INVERT	(1<<  2)
> > +	int flags;
> > +	unsigned short keymap[3];
> 
> It seems like you just use the keymap[0]?

No, keymap[0] is for button 0, keymap[1] if for button 1 and keymap[2] is for 
button 3. The _probe() function wrongly initialized the two last button. I 
will fix this in the next patch.

Thanks for spotting this.

Regards,

Philippe
