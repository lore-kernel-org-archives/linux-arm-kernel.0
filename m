From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 23 Oct 2015 07:35:06 -0500
Subject: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size in
 pl011_fifo_to_tty()"
In-Reply-To: <20151023103056.GI4801@e103592.cambridge.arm.com>
References: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
 <20151023103056.GI4801@e103592.cambridge.arm.com>
Message-ID: <562A297A.9030204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin wrote:
>> >The commit 71a5cd8a4 makes the console hang for some times.
>> >This reverts commit 71a5cd8a4a2602a6e9010b557a23af0a54df87b6.
> What hangs?  Input?  Output?  Both?
>
> Is CREAD set on the terminal?  If only input hangs, it's possible CREAD
> is not set and we were previously getting away with it, though I can't
> easily see why it should be unset...

Dave is right, the revert doesn't make any sense. Huang has a user-space 
bug.  Please check to see if CREAD is set.  I'm pretty sure it isn't.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
