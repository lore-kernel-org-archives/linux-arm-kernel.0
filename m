From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Jul 2013 10:03:28 +0100
Subject: [PATCH v4 02/17] sched_clock: Use seqcount instead of rolling
 our own
In-Reply-To: <1374189690-10810-3-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130719090328.GA18139@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 12:21:15AM +0100, Stephen Boyd wrote:
> We're going to increase the cyc value to 64 bits in the near
> future. Doing that is going to break the custom seqcount
> implementation in the sched_clock code because 64 bit numbers
> aren't guaranteed to be atomic. Replace the cyc_copy with a
> seqcount to avoid this problem.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  kernel/time/sched_clock.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)

Looks good to me. The current scheme would be very fiddly to extend to
64-bit values on 32-bit architectures without cheap atomic doubleword
accesses.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
