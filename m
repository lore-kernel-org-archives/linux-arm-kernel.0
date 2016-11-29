From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 29 Nov 2016 18:36:11 +0300
Subject: [PATCH v3 13/13] clocksource/drivers/rockchip_timer: Prevent
 ftrace recursion
In-Reply-To: <7837485.H9nfDmPu0F@diego>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480427118-5126-1-git-send-email-al.kochet@gmail.com>
 <1480427118-5126-14-git-send-email-al.kochet@gmail.com>
 <7837485.H9nfDmPu0F@diego>
Message-ID: <3CA13FA3-1110-4833-B844-446AF16931C5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko!
Thank you for patch review!

> 29 ????. 2016 ?., ? 18:01, Heiko St?bner <heiko@sntech.de> ???????(?):
> 
> you introduced the issue yourself in patch 11/13. In general any patch should 
> never leave the kernel in a worse state than it was before, so no patch should 
> ever introduce known issues itself.

Agree.

> In that line of thought, don't patches 10+11 introduce warnings about unused 
> functions as well when applied without patch 12?
7 - yes
10 - not
11 - yes

> 29 ????. 2016 ?., ? 18:03, Heiko St?bner <heiko@sntech.de> ???????(?):
> 
> Then why do you need another patch to remove them and don't do that in the 
> patch removing their respective usage?


To make 7 more readable. Overwise patch messed up and unreadable.
It?s hard to track what going on in the patch.

> Maybe merge them?

I'll merge all of them.

P.S.
here comment from another thead about the patches.
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/thread.html#470957

> 29 ????. 2016 ?., ? 18:07, Robin Murphy <robin.murphy@arm.com> ???????(?):
> 
> 3288 (and probably anything newer) is irrelevant to this discussion, as
> it has the arch timer interface - that may be busted in other ways (such
> as not being correctly set up by firmware and not being always-on as it
> should), but frequency is not one of them. This only affects
> Cortex-A9/A5 based parts.


So I update comments for patches.

Looks, like I study archeology with my patches, as all new ARM chips not
affected by the problem anymore.

Regards,
Alexander.
