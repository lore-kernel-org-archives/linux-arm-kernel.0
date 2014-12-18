From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 18 Dec 2014 08:00:14 -0800
Subject: [PATCH 6/8] watchdog: st_wdt: Add new driver for ST's LPC Watchdog
In-Reply-To: <20141218082652.GP13885@x1>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <1418834727-1602-7-git-send-email-lee.jones@linaro.org>
 <20141217180251.GA29914@roeck-us.net> <20141218082652.GP13885@x1>
Message-ID: <20141218160014.GA16015@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 08:26:52AM +0000, Lee Jones wrote:
> On Wed, 17 Dec 2014, Guenter Roeck wrote:
> > On Wed, Dec 17, 2014 at 04:45:25PM +0000, Lee Jones wrote:
> > > Signed-off-by: David Paris <david.paris@st.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Hi Lee and David,
> > 
> > I still have a couple of comments below. Sorry I didn't catch those earlier.
> > 
> > Thanks,
> > Guenter
> > 
> > > ---
> > >  drivers/watchdog/Kconfig  |  13 ++
> > >  drivers/watchdog/Makefile |   1 +
> > >  drivers/watchdog/st_wdt.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 337 insertions(+)
> > >  create mode 100644 drivers/watchdog/st_wdt.c
> 
> Chopping all the crud.
> 
> [...]
> 
> > > +static struct of_device_id st_wdog_match[] = {
> > > +	{
> > > +		.compatible = "st,stih407-lpc",
> > > +		.data = (void *)&stih407_syscfg,
> > 
> > Nitpick: typecast to and from void * is not necessary.
> 
> Actually that's not true, but it is superfluous in this case.
> 
Point taken. Would you agree to a more detailed "typecasting a pointer
to and from void * is not necessary" ?

Guenter
