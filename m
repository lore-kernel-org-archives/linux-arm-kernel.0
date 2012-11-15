From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 15 Nov 2012 11:18:20 +0100
Subject: Fwd: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
In-Reply-To: <20121115095741.GA6280@bnru10>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <CACRpkdYekQF5111NSNSPeaHdxgS_gpXkCjqT1n-n1_iAdDXbSg@mail.gmail.com>
 <20121115084858.GA29668@bnru10>
 <20121115092953.GA418@pengutronix.de>
 <20121115095741.GA6280@bnru10>
Message-ID: <20121115101820.GC418@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 03:27:42PM +0530, Srinidhi Kasagar wrote:
> On Thu, Nov 15, 2012 at 10:29:53 +0100, Wolfram Sang wrote:
> > 
> > > > -       if (timeout < 0) {
> > > > -               dev_err(&dev->adev->dev,
> > > > -                       "wait_for_completion_timeout "
> > > > -                       "returned %d waiting for event\n", timeout);
> > > > -               status = timeout;
> > > > -       }
> > > > -
> > > No, it is wrong. You need to update the status variable in the case of timeout.
> > 
> > Looking at the patch context, such code comes later.
> But it causes regressions; without looking at the "later" code, we can't afford merging
> this code now.

Later as in "a few lines later" not "some time later". Or am I missing
something else?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121115/24943c8e/attachment.sig>
