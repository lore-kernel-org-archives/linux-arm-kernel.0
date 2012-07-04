From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 4 Jul 2012 10:45:06 +0200
Subject: MX28 poweroff issue
In-Reply-To: <20120704082049.GI16319@n2100.arm.linux.org.uk>
References: <201207040030.36713.marex@denx.de>
 <201207040412.46748.marex@denx.de>
 <CAOMZO5Ab-Zibnn-tVfTz5BNJsqJer88jZLVa5Een9DDZ3tdssg@mail.gmail.com>
 <201207040547.37021.marex@denx.de>
 <20120704070751.GB5398@pengutronix.de>
 <20120704082049.GI16319@n2100.arm.linux.org.uk>
Message-ID: <20120704084506.GE5398@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 09:20:49AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 04, 2012 at 09:07:51AM +0200, Uwe Kleine-K?nig wrote:
> > Hi Marek,
> > 
> > On Wed, Jul 04, 2012 at 05:47:36AM +0200, Marek Vasut wrote:
> > > Dear Fabio Estevam,
> > > 
> > > > On Tue, Jul 3, 2012 at 11:12 PM, Marek Vasut <marex@denx.de> wrote:
> > > > > Dunno, can you try on mx28 please?
> > > > 
> > > > I get the same crash as you reported.
> > > > 
> > > > On a mx27 (also ARM926EJS) I do not see this problem.
> > > 
> > > Thanks for verifying this, Fabio. The mx28 generates timer interrupt after it 
> > > should be sitting in the endless loop, therefore this crash. I think it's 
> > > because the mx28 (mxs at al) is using the new clock framework (compared to mxc) 
> > > and the timer isn't deinited by then ...
> > On an i.MX35 with v3.5-rc4 (which is using the new clock framework in
> > the meantime, but is an ARM11) I don't see this crash.
> 
> Are you who aren't seeing it waiting around 30 seconds after "System halted" ?
I waited longer and had

	CONFIG_DETECT_HUNG_TASK=y
	CONFIG_LOCKUP_DETECTOR=y

in my .config.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
