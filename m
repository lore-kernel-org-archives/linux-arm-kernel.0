From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 1 Nov 2009 21:22:10 +0100
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091031013427.GL14091@buzzloop.caiaq.de>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
Message-ID: <20091101202209.GB13467@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Daniel, 

On Sat, Oct 31, 2009 at 02:34:27AM +0100, Daniel Mack wrote:
> Is anyone using suspend/resume with a recent git mainline kernel on PXA
> or other ARM embedded boards? My platform used to suspend and resume
> just fine on 2.6.31 but now as I rebased it, it fails the resume part.
> 
> Unfortunately, I can't bisect it as the platform is not mainline yet and
> so I always have mandatory patches (without my platform won't do
> anything) on top of the git repository. Which breaks the bisect logic.
What you can do is call 2.6.31 good and to test a vanilla state, do
something like

	git merge my_support_branch_based_on_2.6.31
	... test ...
	git reset --hard HEAD^
	git bisect --good_or_bad_as_found_by_test_above
 
Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
