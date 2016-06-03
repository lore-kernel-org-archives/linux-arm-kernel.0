From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jun 2016 12:30:36 -0700
Subject: [PATCH 0/2] ARM: dts: sun6i: Drop constraints on dc1sw regulator
In-Reply-To: <20160511124344.GO3733@lukather>
References: <1462944194-6920-1-git-send-email-wens@csie.org>
 <20160511124344.GO3733@lukather>
Message-ID: <20160603193036.GK3761@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 02:43:44PM +0200, Maxime Ripard wrote:
> On Wed, May 11, 2016 at 01:23:12PM +0800, Chen-Yu Tsai wrote:
> > Hi Arnd, Olof,
> > 
> > Here are 2 last minute fixes for 4.6. The 2 patches drop constaints on
> > the dc1sw regulator for 2 A31s tablets. I checked with Maxime and he said
> > to send them directly to you.
> > 
> > The issue was first brought up and fixed for A23/A33 Q8 tablets in commit
> > dcf5341f0150 ("ARM: dts: sun8i-q8-common: Do not set constraints on dc1sw
> > regulator"). It was brought up again yesterday on IRC, and I realized that
> > 2 sun6i A31s tablet DTS files also had this setting. The setting causes
> > PMIC regulator registration to fail, and since among other things, mmc
> > depends on the regulators, the system will likely hang.
> > 
> > There seems to be a fix for this queued up for 4.7: commit 45389c47526d
> > ("regulator: core: Add early supply resolution for regulators") in the
> > regulator "supply" topic branch. So we should be able to revert these
> > fixes in 4.7.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> For the two patches.
> 

Looks like these weren't applied. I've applied them to fixes now and cc:d
stable for 4.6.



-Olof
