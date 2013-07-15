From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Jul 2013 11:02:43 +0100
Subject: [PATCH] arm64: compat: fix compilation when using 64kB pages
In-Reply-To: <1373553036-5418-1-git-send-email-marc.zyngier@arm.com>
References: <1373553036-5418-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130715100243.GA10000@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 03:30:36PM +0100, Marc Zyngier wrote:
> When compiling for 64kB pages, we end-up having conflicting
> implementations for aarch32_break_handler().
> 
> Wrap the 4kB page implementation with a CONFIG_COMPAT guard and change
> the !CONFIG_COMPAT implementation to be static inline instead of simply static.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I think there was a better fix kicking around for this from Chen Gang already.
I asked for a new commit message, but a v3 didn't appear:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/179418.html

Will
