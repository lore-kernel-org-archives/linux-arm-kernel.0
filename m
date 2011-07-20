From: davidb@codeaurora.org (David Brown)
Date: Wed, 20 Jul 2011 15:50:10 -0700
Subject: [GIT PULL] MSM fix
In-Reply-To: <1989166.1WcWHOXyl7@wuerfel>
References: <20110720203703.GA4495@huya.qualcomm.com>
	<1989166.1WcWHOXyl7@wuerfel>
Message-ID: <20110720225010.GA18381@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 11:06:15PM +0200, Arnd Bergmann wrote:
> On Wednesday 20 July 2011 13:37:03 David Brown wrote:
> > I seem to have missed this fix when it was sent out in April.
> > 
> > The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:
> > 
> >   Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)
> > 
> > are available in the git repository at:
> >   git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-fix
> > 
> > Jeff Ohlstein (1):
> >       msm: platsmp: actually read core count in get_core_count
> > 
> 
> Hmm, this one seems like it really applies to older kernels as well, so
> we can just as well add a cc:stable at kernel.org tag and put it into the
> arm-soc/next/fixes branch, right?

It looks like it would apply to 2.6.38 and 39 as well.  I'm not sure
it qualifies under the "It must fix a real bug that bothers people".
It would only apply if someone had set NR_CPUS to more than 2.

> Linus has just pulled the 'last arm-soc fixes for 3.0' branch, and I don't
> really want to follow up with 'last fix, this time for real' pull request
> unless it's for a serious regression.

It's not serious, so 3.1 is fine.

> On a related topic, what's the deal with the msm-core and msm-move-gpio
> branches in the same tree? I have the impression that they should be
> in arm-soc.git, but I never received a pull request.

I had sent a pull request for msm-move-gpio to Grant, but apparently
that didn't happen.  If more appropriate, I can send one to you for
it, or resend to Grant.

The msm-core stuff happened before the snafu about ARM, and I was
holding off on these things.  The authors of these patches say they
are working on cleaned up versions.

I'm not sure we want the dummy clocks code in the kernel.  It's
intended as a placeholder.  Stephen Boyd has a 26-series patch that
adds better clock support.  Given the size (13047 insertions), this
may need some cleanup or even device-tree work to include.

Unfortunately, a lot of the Qualcomm development seems to have moved
back to private trees.

BTW, I am planning on being at the Linaro Connect in August.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
