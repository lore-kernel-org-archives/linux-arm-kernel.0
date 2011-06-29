From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Jun 2011 11:14:41 +0200
Subject: [PATCH V2 0/3] Add drivers/pwm and drivers/pwm/st_pwm.c
In-Reply-To: <201106281713.16099.arnd@arndb.de>
References: <cover.1306831238.git.viresh.kumar@st.com>
	<201106271526.12848.arnd@arndb.de>
	<20110628100438.GI6069@pengutronix.de>
	<201106281713.16099.arnd@arndb.de>
Message-ID: <20110629091441.GA9349@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 05:13:15PM +0200, Arnd Bergmann wrote:
> On Tuesday 28 June 2011, Sascha Hauer wrote:
> > > 
> > > Good question. If Sascha is able to come up with the patch to introduce
> > > the generic layer, I think it would be good to have it go though him.
> > 
> > Just posted a rebased and documented series again. Let's see what
> > happens. The time seems good to finally get this into the kernel.
> 
> I'd say let's go forward with your framework. The two patches currently
> because they both add Makefile/Kconfig files in drivers/pwm.
> 
> Maybe you can add Viresh's patch to your series, and wait for him
> to follow up with a patch to convert it?
> 
> I've tried to blindly do the conversion myself, but got stuck with the
> definition of the platform device that has multiple pwms in it.
> I wonder if it would be better to change the st-pwm platform
> interface to define one platform_device for each of them.

Definitely. From a quick look at the driver it seems the pwms all have
a seperate register space.

I can add Viresh's patch to my series once we agree on the base patch.
In the meantime maybe Viresh starts converting it ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
