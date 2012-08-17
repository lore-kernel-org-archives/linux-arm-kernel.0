From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 17 Aug 2012 15:26:29 +0200
Subject: Issues with all kernels after 3.3.7
In-Reply-To: <CADhrpJ7r4PPM2nOD7Wch9H+usaDUJ5XYeim6THUKEDTz=-Zyig@mail.gmail.com>
References: <CADhrpJ7r4PPM2nOD7Wch9H+usaDUJ5XYeim6THUKEDTz=-Zyig@mail.gmail.com>
Message-ID: <20120817132629.GA2232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 01:47:06PM +0100, alan butler wrote:
> I have been trying all kernels after 3.3.7 (except for the 3.5 series)
> on my ix2-200
> and have found that on every kernel 3.3.8, 3.4, 3.4.2, 3.4.4 =>3.4.7
> and now even on 3.6 rc1
> and the next dated today 17 august that when i use git for example:
> 
> git clone git://git.videolan.org/x264
> 
> my system just crash's / hangs and even through the serial port i get
> no response.
> This also happens when i try to access a web interface for example the
> serviio java webui.
> 
> The second issue i have noticed is that my raid 0 array hangs / pauses
> when being mounted
> at system startup. (for approximatly 30 seconds maybe more maybe less
> im not certain).
> But again on the 3.3.7 kernel there was no issue and no hang.
> 
> If i return to 3.3.7 everything works fine with no other modifications
> to the os or kernels.
> I am using debian wheezy at the moment but also tried debian squeeze
> so it does not
> seem to be related to the specific linux version just the kernel.
Can you bisect your problem? Doing that between 3.3.7 and 3.3.8 seems to
be the obvious range to test.

You can also try to enable the various debugging options like

	CONFIG_DETECT_HUNG_TASK
	CONFIG_PROVE_LOCKING
	CONFIG_DEBUG_ATOMIC_SLEEP
	CONFIG_MAGIC_SYSRQ

or try https://lkml.org/lkml/2012/5/26/83.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
