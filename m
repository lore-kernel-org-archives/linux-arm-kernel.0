From: ahs3@redhat.com (Al Stone)
Date: Wed, 13 May 2015 16:00:58 -0600
Subject: [PATCH v2 2/2] ARM64: kernel: unify ACPI and DT cpus
 initialization
In-Reply-To: <1431522769-11276-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1431522769-11276-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1431522769-11276-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5553C99A.5020706@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 07:12 AM, Lorenzo Pieralisi wrote:
> The code that initializes cpus on arm64 is currently split in two
> different code paths that carry out DT and ACPI cpus initialization.
> 
> Most of the code executing SMP initialization is common and should
> be merged to reduce discrepancies between ACPI and DT initialization
> and to have code initializing cpus in a single common place in the
> kernel.
> 
> This patch refactors arm64 SMP cpus initialization code to merge
> ACPI and DT boot paths in a common file and to create sanity
> checks that can be reused by both boot methods.
> 
> Current code assumes PSCI is the only available boot method
> when arm64 boots with ACPI; this can be easily extended if/when
> the ACPI parking protocol is merged into the kernel.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Mark Rutland <mark.rutland@arm.com> [DT]
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
[snip...]

These patches look pretty good so far, but I've only just started
reviewing them.  This one raised the question: do we know if there
is someone already working on parking protocol?  I've seen a form
of it working on AMD Seattles but I don't recall seeing any patches
being submitted -- I'll search archives again, just in case I missed
it the first time, but if there is someone working on it, that would
be good to know.

Thanks.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
