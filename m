From: agross@codeaurora.org (Andy Gross)
Date: Fri, 11 Sep 2015 12:11:25 -0500
Subject: master build: 1 failures 73 warnings (v4.2-11142-gb0a1ea5)
In-Reply-To: <20150911145638.GL20922@sirena.org.uk>
References: <E1ZaL9B-0006QE-Kh@optimist> <20150911120150.GN12027@sirena.org.uk>
 <20150911125830.GA11833@n2100.arm.linux.org.uk>
 <20150911145638.GL20922@sirena.org.uk>
Message-ID: <20150911171125.GA32107@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:56:38PM +0100, Mark Brown wrote:
> On Fri, Sep 11, 2015 at 01:58:30PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Sep 11, 2015 at 01:01:51PM +0100, Mark Brown wrote:

<snip>

> 
> Indeed, the initial reason I set up my builder was that I was doing work
> on arm64 and got fed up with the constant breakage in -next.  It's
> getting better slowly, we mostly at least compile now which wasn't the
> case originally.
> 
> > Changing the "depends" on QCOM_SCM won't fix it - I think something's
> > been recently merged which has added another select QCOM_SCM which has
> > the effect of enabling this on ARM64.  _That_ is the cause of this
> > breakage.

Right.  The driver which needs the SCM infrastructure selected the QCOM_SCM.
However, since the correct 64-bit version of the SCM hasn't been added, it uses
the current scm driver.
> 
> Yes, it'll be the combination of the two commits (hopefully whatever
> patch introduced the issue builds on its own branch as well).  There's a
> fix been merged into -next somewhere which fixes this - like I said I'm
> fairly sure that's 626ffb400e1e781 (firmware: qcom: scm: Add function
> stubs for ARM64) which means that an alternative stub implementation in
> qcom_scm-64.c gets build on arm64 but that's not hit mainline yet and
> we're getting near the end of the merge window.
> 
> It would be sad to have yet another release where -rc1 doesn't build for
> common test configurations :/

I dropped the ball on this.  I am sending the patch and pull request shortly.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
