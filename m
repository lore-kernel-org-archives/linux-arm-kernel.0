From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Nov 2014 12:35:02 -0800
Subject: [GIT PULL 2/3 v2] 1st Round of Samsung PM updates for v3.19
In-Reply-To: <021801cff253$0374fe40$0a5efac0$@samsung.com>
References: <021801cff253$0374fe40$0a5efac0$@samsung.com>
Message-ID: <20141104203502.GA3851@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 11:00:57AM +0900, Kukjin Kim wrote:
> Hi,
> 
> I'm sending new pull-request for tags/samsung-pm-v2 instead of tags/samsung-pm.
> Note that just added "fix build with ARM_CPU_SUSPEND=n" from Arnd, please pull.
> 
> Thanks,
> Kukjin

Kukjin,

The history here is somewhat odd. You've merged in cleanup and dt,
and two merges of pm (one with just the extra fix from Arnd). Are the
merges needed just to avoid merge conflicts? If so, we can resolve that
when we merge here, that's not a problem.

If it's needed because pm doesn't work without the dt branch also being
merged in, then this is not sufficient since when bisecting, you might get
only the pm branch contents and not the dt contents in some circumstances.

So, please confirm which of the cases it is, and resubmit just the bare
pm branch if there are no dependencies.


-Olof
