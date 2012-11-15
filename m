From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Thu, 15 Nov 2012 15:27:42 +0530
Subject: Fwd: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
In-Reply-To: <20121115092953.GA418@pengutronix.de>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <CACRpkdYekQF5111NSNSPeaHdxgS_gpXkCjqT1n-n1_iAdDXbSg@mail.gmail.com>
 <20121115084858.GA29668@bnru10>
 <20121115092953.GA418@pengutronix.de>
Message-ID: <20121115095741.GA6280@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 10:29:53 +0100, Wolfram Sang wrote:
> 
> > > -       if (timeout < 0) {
> > > -               dev_err(&dev->adev->dev,
> > > -                       "wait_for_completion_timeout "
> > > -                       "returned %d waiting for event\n", timeout);
> > > -               status = timeout;
> > > -       }
> > > -
> > No, it is wrong. You need to update the status variable in the case of timeout.
> 
> Looking at the patch context, such code comes later.
But it causes regressions; without looking at the "later" code, we can't afford merging
this code now.

regards/srinidhi
