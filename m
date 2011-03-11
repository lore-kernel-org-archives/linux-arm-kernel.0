From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Mar 2011 17:08:07 +0000
Subject: [RFC] ARM: Cortex-A9: Enable dynamic clock gating
In-Reply-To: <1298433325-16810-1-git-send-email-toddpoynor@google.com>
References: <1298433325-16810-1-git-send-email-toddpoynor@google.com>
Message-ID: <1299863287.7239.37.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-02-23 at 03:55 +0000, Todd Poynor wrote:
> Enable dynamic high level clock gating for Cortex-A9 CPUs, as
> described in 2.3.3 "Dynamic high level clock gating" of the
> Cortex-A9 TRM.  This may cut the clock of the integer core,
> system control block, and Data Engine in certain conditions.
> 
> Add ARM errata 720791 to avoid corrupting the Jazelle
> instruction stream on earlier Cortex-A9 revisions.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
> Can anyone advise whether this feature should be selectively
> enabled (or otherwise modified) due to secured register access,
> introduced latencies observed, etc.?
> 
> This has been tested on a few Tegra 2 boards without problems
> observed thus far, and some preliminary testing indicates it
> may result in fairly significant power savings.  Any additional
> testing greatly appreciated.

I haven't done any benchmarks on this, so can't comment on this.

My view is that something like the boot monitor/firmware should set this
up, though that's not always the case. On some OMAP boards Linux runs in
non-secure mode and it will fault when trying to set this bit.

-- 
Catalin
