From: inki.dae@samsung.com (Inki Dae)
Date: Fri, 27 Jan 2012 11:07:44 +0900
Subject: [PATCH v7 2/2] video: backlight: support s6e8ax0 panel driver
 based on MIPI DSI
In-Reply-To: <1327593179.2843.5.camel@lappy>
References: <4F17AA14.8030100@samsung.com> <1327593179.2843.5.camel@lappy>
Message-ID: <001901ccdc98$755d4bd0$6017e370$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Tomi.

Below is my comments.

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen at ti.com]
> Sent: Friday, January 27, 2012 12:53 AM
> To: Donghwa Lee
> Cc: linux-fbdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Florian Tobias Schandinat; Andrew Morton; rpurdie at linux.intel.com;
> inki.dae at samsung.com; kyungmin.park at samsung.com
> Subject: Re: [PATCH v7 2/2] video: backlight: support s6e8ax0 panel driver
> based on MIPI DSI
> 
> Hi,
> 
> On Thu, 2012-01-19 at 14:28 +0900, Donghwa Lee wrote:
> > This patch is amoled panel driver based MIPI DSI interface.
> > S6E8AX0 means it may includes many other ldi controllers, for example,
> > S6E8AA0, S6E8AB0, and so on.
> >
> > This patch can be modified depending on each panel properites. For
> > example, second parameter of panel condition register can be changed
> > depending on ldi controller or amoled type.
> >
> > Changes since v6:
> > 	- change data type from const to static const
> >
> > Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> > Signed-off-by: Inki Dae <inki.dae@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/video/backlight/Kconfig   |    7 +
> >  drivers/video/backlight/Makefile  |    1 +
> >  drivers/video/backlight/s6e8ax0.c |  898
> +++++++++++++++++++++++++++++++++++++
> >  drivers/video/backlight/s6e8ax0.h |   21 +
> >  4 files changed, 927 insertions(+), 0 deletions(-)  create mode
> > 100644 drivers/video/backlight/s6e8ax0.c  create mode 100644
> > drivers/video/backlight/s6e8ax0.h
> 
> Why is this in backlight directory? It's a panel driver, not a backlight
> driver.
> 

Yes, right. this backlight driver is specific to our mipi dsi driver because this uses the interface of mipi dsi driver to send some commands to real lcd panel.

> And the driver is s5p specific, wouldn't a directory like
> drivers/video/s5p/, where both the s5p DSI driver from the previous patch
> and this panel driver could be?
> 

Ok, we will create new directory, "exynos" instead of "s5p" because our SoC chip doesn't use such prefix(s5p, and s3c) anymore. and also as you mentioned, we should working on a common DSI framework.  do you have any plan for this?

Thanks,
Inki Dae.

>  Tomi
