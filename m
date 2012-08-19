From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Aug 2012 15:21:37 +0000
Subject: [PATCH 0/3] New algorithm for ASID allocation and rollover
In-Reply-To: <1345049642-29704-1-git-send-email-will.deacon@arm.com>
References: <1345049642-29704-1-git-send-email-will.deacon@arm.com>
Message-ID: <201208191521.37460.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 August 2012, Will Deacon wrote:
> After some discussion, it became apparent that tracking the ASIDs
> currently active on the cores in the system means that, on rollover, we
> can automatically reserve those that are in use without having to stop
> the world.

Just a question for my general understanding of how this is done: How do
you know if an ASID is active or not? Do you broadcast flush an address
space completely when the struct mm goes away, or do you keep track of
which CPUs had TLBs in an ASIC when it went away and then flush that ASID
when you reuse it on that CPU?

	Arnd
