From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Dec 2011 22:30:48 +0100
Subject: [PATCH] ARM: add device tree blobs to .gitignore
In-Reply-To: <20111215144757.GA2081@linaro.org>
References: <1323808612-14976-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111215144757.GA2081@linaro.org>
Message-ID: <20111215213048.GH24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 02:47:57PM +0000, Dave Martin wrote:
> On Tue, Dec 13, 2011 at 09:36:52PM +0100, Uwe Kleine-K??nig wrote:
> > *.dtb files are a build result and so should be ignored.
> > 
> > Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> 
> Should this actually be global?
> 
> It looks like at least powerpc, microblaze and openrisc may generate
> .dtbs and I don't see any local .gitignore entries for those.
> 
> Since the dtc tool itself is global (i.e., in an arch-independent
> scripts dir instead of somewhere arch-specific), it could be argued that
> other related stuff should be global too.
hmm, I'm not convinced. The build system puts ARM dtb images only in
arch/arm/boot, so IMHO they should only be ignored there. If the other
arch don't .gitignore the dtb files they should get a specific entry,
too.

Having said that, adding a / to my patch would be the right thing to do.
(i.e.

	+/*.dtb

) The other entries could get a slash, too. Maybe a bit over engineered.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
