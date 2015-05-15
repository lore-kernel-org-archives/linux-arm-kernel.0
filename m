From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 15 May 2015 09:58:18 +0100
Subject: [PATCH v2 2/2] ARM64: kernel: unify ACPI and DT cpus
 initialization
In-Reply-To: <5553C99A.5020706@redhat.com>
References: <1431522769-11276-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1431522769-11276-3-git-send-email-lorenzo.pieralisi@arm.com>
 <5553C99A.5020706@redhat.com>
Message-ID: <20150515085817.GA14206@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[restored CC list]

On Wed, May 13, 2015 at 11:00:58PM +0100, Al Stone wrote:
> On 05/13/2015 07:12 AM, Lorenzo Pieralisi wrote:
> > The code that initializes cpus on arm64 is currently split in two
> > different code paths that carry out DT and ACPI cpus initialization.
> > 
> > Most of the code executing SMP initialization is common and should
> > be merged to reduce discrepancies between ACPI and DT initialization
> > and to have code initializing cpus in a single common place in the
> > kernel.
> > 
> > This patch refactors arm64 SMP cpus initialization code to merge
> > ACPI and DT boot paths in a common file and to create sanity
> > checks that can be reused by both boot methods.
> > 
> > Current code assumes PSCI is the only available boot method
> > when arm64 boots with ACPI; this can be easily extended if/when
> > the ACPI parking protocol is merged into the kernel.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Tested-by: Mark Rutland <mark.rutland@arm.com> [DT]
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> [snip...]
> 
> These patches look pretty good so far, but I've only just started
> reviewing them.  This one raised the question: do we know if there
> is someone already working on parking protocol?  I've seen a form
> of it working on AMD Seattles but I don't recall seeing any patches
> being submitted -- I'll search archives again, just in case I missed
> it the first time, but if there is someone working on it, that would
> be good to know.

I have seen patches for the ACPI parking protocol but nothing posted
publicly. This patch consolidates what exists today, honestly
I do not think that putting together a patch to enable the ACPI parking
protocol is a big deal on top of this set, keeping in mind that it
should be used as a fallback solution if PSCI can't be implemented
(ie AMD Seattle must boot with PSCI).

Lorenzo
