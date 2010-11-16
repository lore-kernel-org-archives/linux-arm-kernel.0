From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 16 Nov 2010 12:45:23 -0800
Subject: [PATCH 14/14] msm: iommu: Miscellaneous code cleanup
In-Reply-To: <4CE1DB7F.1020408@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
	<1289619000-13167-15-git-send-email-stepanm@codeaurora.org>
	<1289867105.4050.29.camel@c-dwalke-linux.qualcomm.com>
	<4CE1DB7F.1020408@codeaurora.org>
Message-ID: <1289940323.9950.15.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-15 at 17:16 -0800, Stepan Moskovchenko wrote:
> On 11/15/2010 4:25 PM, Daniel Walker wrote:
> > On Fri, 2010-11-12 at 19:30 -0800, Stepan Moskovchenko wrote:
> >> Remove some unneeded assignments and messages, restructure
> >> a failure path in iova_to_phys, and make __flush_iotlb
> >> return int in preparation for adding IOMMU clock control.
> > Why restructure the failure path ?
> >
> > Daniel
> 
> It is a trivial change of replacing a goto with an assignment and moving 
> it a few lines down. It reduces "jumpiness" within that function and is 
> a cleaner version. On the more practical side, it was done in 
> preparation for some other changes I have coming up, which touch that 
> function and work a lot better with the cleaned-up failure path. The 
> next patch was delayed (due to a dependency) but as long as I was doing 
> code cleanup, I saw no reason not to also clean up the failure path as 
> part of this series.

Some of what your have said above really needs to be in your commit
text. I've noticed that your commit text in general is not verbose
enough. You need to explain what doing better.

Also generally you want to organize similar sets of changes. So if you
doing a cleanup in preparation for another change then the cleanup
should go with the other change. In this case it's not clear that this
is actually a cleanup, so it would be much nicer to get that change
along with the one you've delayed .. Also the two Kconfig changes you've
sent indicate that your not organizing your changes properly, so I think
you need to take more time considering how to the organize patches.

Just so we're clear on this, any changes that you send me will go into
_permanent_ public history. This history will not disappear at some set
date, and we will not be rebasing out changes or squashing changes.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
