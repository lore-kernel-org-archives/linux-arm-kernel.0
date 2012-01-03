From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 03 Jan 2012 15:26:55 -0800
Subject: [PATCH] ARM: Remove BUILD_BUG_ON from asm/bug.h
In-Reply-To: <CAPnjgZ1P6bdAGRa-9ZyuNMT7jRAfrH3abWJPkxVeeM7BDKsXTg@mail.gmail.com>
References: <1325616276-10304-1-git-send-email-sjg@chromium.org>	<4F03821D.9080503@codeaurora.org>
 <CAPnjgZ1P6bdAGRa-9ZyuNMT7jRAfrH3abWJPkxVeeM7BDKsXTg@mail.gmail.com>
Message-ID: <4F038EBF.5030408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/12 14:40, Simon Glass wrote:
> Yes that is the reason, but ARM is not unique in this matter, and
> other archs do not have this check. I did suggest a solution in this
> thread involving putting the check in a C file instead of header. But
> it needs an arch-specific #define to specify the size expected by the
> assembler, and has the disadvantage of moving the check away from the
> assembler code.
>
> It's not that we don't want this check, more that it is not essential
> (since there is currently no mismatch), it is causing problems and it
> is risky to try to solve this problem some other way at this late
> stage in 3.2. So the easiest thing is to remove it, to match other
> archs.

Fair enough. I now see the other thread where this has all been
discussed. Sorry for the noise.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
