From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Jun 2012 14:38:45 -0700
Subject: [PATCH 0/2] Use architected timers for delay loop
In-Reply-To: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
Message-ID: <4FE8DA65.8030403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/12 08:09, Will Deacon wrote:
> Hello,
>
> This patch series reworks our delay loop implementation to allow the
> busy-loop to be replaced with the physical counter included as part of
> the architected timer on recent CPUs. The polling implementation is
> still maintained to support cores without the timers and we use the same
> maths and upper delay bound of 2ms.
>
> Russell - I think my maths is correct, but why can't we increase the
>           precision by using a magic constant of 4398046U and a right
> 	  shift of 31?
>
> As usual, all feedback is welcome,

I have posted a read_current_timer implementation to the list a couple
times but had no success in getting it merged. The patches are still in
the patch tracker but I haven't really pushed them to get merged.

    http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6874/1
    http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6873/1
    http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6875/1

So far we've just been carrying them internally. I suppose ARM needs
this now because of big little?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
