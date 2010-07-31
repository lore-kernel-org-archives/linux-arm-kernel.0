From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 31 Jul 2010 09:03:52 +0200
Subject: [PATCH] Input: Make ADS7846 independent on regulator
In-Reply-To: <20100731063329.GA23620@core.coreip.homeip.net>
References: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com>
	<20100731063329.GA23620@core.coreip.homeip.net>
Message-ID: <201007310903.52921.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 31. ?ervence 2010 08:33:29 Dmitry Torokhov napsal(a):
> Hi Marek,
> 
> On Sat, Jul 31, 2010 at 07:45:08AM +0200, Marek Vasut wrote:
> > In case regulator was not found, ADS7846 failed to probe.
> > 
> > This fixes a problem on some Sharp Zaurus devices, where there is no
> > regulator present and yet the touchscreen is used.
> 
> Too many ifdefs to my taste... Can we have ads7846_regulator_enable()
> and friends stubbed out in case !CONFIG_REGULATOR?

Hi,

I believe you should ask the regulator guys about these. We can certainly just 
remove the ifdefs (I was thinking about it, because it poluted the code quality 
quite a bit). Just removing the ifdefs shouldn't cause any harm.

Cheers
