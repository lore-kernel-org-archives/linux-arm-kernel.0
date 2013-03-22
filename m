From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 11:09:07 +0000
Subject: [PATCH 2/3] ARM: sched_clock: support 64-bit counters
In-Reply-To: <514B1311.20308@codeaurora.org>
References: <1363055197-17296-1-git-send-email-robherring2@gmail.com>
 <1363055197-17296-3-git-send-email-robherring2@gmail.com>
 <514B1311.20308@codeaurora.org>
Message-ID: <20130322110907.GY4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 10:02:57AM -0400, Christopher Covington wrote:
> To be more precise, architected timers are anywhere between 56 and 64 bits
> wide, zero-extended to 64-bits. See section B8.1.1 of the ARM ARM rev C.b. I
> don't know if the code really needs to change until someone has a need to
> distinguish more finely between timers, but if you're using access size as an
> approximation for counter width, I feel like it at least deserves a mention in
> the comments.

If the counter is such that it doesn't produce a full 64-bit nsec value
from sched_clock(), then it needs to be extended to 64-bit.
