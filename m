From: will.deacon@arm.com (Will Deacon)
Date: Sun, 5 Aug 2012 14:20:02 +0100
Subject: [PATCH] ARM: Don't enable GENERIC_LOCKBREAK with ticket spinlocks
In-Reply-To: <1344033762-3296-1-git-send-email-sboyd@codeaurora.org>
References: <1344033762-3296-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120805132001.GA1591@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2012 at 11:42:42PM +0100, Stephen Boyd wrote:
> Now that ARM has implemented its spinlocks with tickets we don't
> need to use the generic lockbreak algorithm. Remove the Kconfig
> from ARM so that we use the arch_spin_is_contended() definition
> from the asm header. This also saves a word in each lock because
> we don't need the break_lock member anymore.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> It seems we define the arch_spin_is_contended() macro but we don't
> use it on SMP && PREEMPT kernels?

Thanks, I missed that.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
