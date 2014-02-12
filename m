From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Feb 2014 18:23:14 +0000
Subject: [PATCH] arm64: smp: Add a memory barrier before we start
 secondary cores
In-Reply-To: <20140212145644.GP28112@sirena.org.uk>
References: <1392205594-29186-1-git-send-email-broonie@kernel.org>
 <20140212122727.GB29132@mudshark.cambridge.arm.com>
 <20140212124717.GL28112@sirena.org.uk> <20140212134332.GK29702@arm.com>
 <20140212145644.GP28112@sirena.org.uk>
Message-ID: <F28028BE-865B-4338-BA62-3F766B922A63@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 Feb 2014, at 14:56, Mark Brown <broonie@kernel.org> wrote:

> On Wed, Feb 12, 2014 at 01:43:32PM +0000, Catalin Marinas wrote:
> 
>> I think we can drop this until Vincent clarifies the synchronisation
>> requirements (still wondering whether spinlocks are needed).
> 
> Even if they're not actually required for the topology code the fact
> that we're having to think about what is needed suggests that the code
> is going to end up being clearer and hence more maintainable going
> forwards if we add it.

I think we should aim to understand the code better rather than just
adding the spinlocks. Some simple questions:

- Who uses the topology information and when? (the scheduler? first time after or
before secondaries are started?)

- Who updates the topology information? (primary and secondary startup
code?)

- What about hotplug?

- Can any of the above happen in parallel on different CPUs?

Catalin
