From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 21 Apr 2011 14:27:01 -0400 (EDT)
Subject: [PATCH] ARM: kprobes: Fix error in conditional instruction
	checking
In-Reply-To: <1303406966-28219-1-git-send-email-tixy@yxit.co.uk>
References: <1302085032-30415-2-git-send-email-tixy@yxit.co.uk>
	<1303406966-28219-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1104211424050.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Tixy wrote:

> From: Jon Medhurst <tixy@yxit.co.uk>
> 
> The patch titled "ARM: kprobes: Fix probing of conditionally executed
> instructions" contains errors in the condition code checking functions
> __check_gt() and __check_lt(). These return the incorrect results if the
> Q flag is set because this is xored with the Z flag in the first
> expression. The fix is to use an intermediate temporary variable.
> 
> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>

Good, I've folded this patch into the original commit where this bug was 
introduced, and pushed the amended branch.


Nicolas
