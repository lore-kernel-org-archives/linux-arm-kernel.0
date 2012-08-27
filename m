From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Aug 2012 00:59:32 +0100
Subject: [PATCH] ARM: MSM: Implement read_current_timer for msm timers
In-Reply-To: <1346102319-24497-1-git-send-email-sboyd@codeaurora.org>
References: <1345817604-9004-2-git-send-email-will.deacon@arm.com>
 <1346102319-24497-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120827235932.GA8468@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 10:18:39PM +0100, Stephen Boyd wrote:
> Setup the same timer used as the clocksource to be used as the
> read_current_timer implementation. This allows us to support a
> stable udelay implementation on MSMs where it's possible for the
> CPUs to scale speeds independently of one another.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> I have some patches to send that add DT support to the MSM timer that
> this conflicts with slightly. I'm not too concerned though, but we may
> want to decide what tree this goes through when I send out those patches.

Cheers Stephen, this looks good to me. After looking at this code some more
I think I'll change the read_current_timer function pointer type to be:

	unsigned long (*read_current_timer)(void);

since it doesn't make sense to return an error code from the platform
implementation (in fact, it will cause havoc in the delay loop).

I'll post a new patch -- rebasing your code should be trivial.

Cheers,

Will
