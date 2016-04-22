From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 Apr 2016 15:25:18 +0100
Subject: [PATCH 0/3] arm64 pt dumper changes
In-Reply-To: <CAKv+Gu-vvVp=5J5W=o9rspWGAGujm23mtMXiXbMGpm0svUds7Q@mail.gmail.com>
References: <1456135239-3607-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160422141154.GN2998@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-vvVp=5J5W=o9rspWGAGujm23mtMXiXbMGpm0svUds7Q@mail.gmail.com>
Message-ID: <20160422142518.GM10606@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 04:15:03PM +0200, Ard Biesheuvel wrote:
> On 22 April 2016 at 16:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Hi Ard,
> >
> > On Mon, Feb 22, 2016 at 11:00:36AM +0100, Ard Biesheuvel wrote:
> >> This series updates the kernel page table dumper to:
> >> - not initialize the vmemmap region markers dynamically
> >> - show region boundaries for the kasan shadow region
> >> - include the UEFI runtime services mappings
> >>
> >> Ard Biesheuvel (3):
> >>   arm64: ptdump: use static initializers for vmemmap region boundaries
> >>   arm64: ptdump: add region marker for kasan shadow region
> >>   arm64: ptdump: include UEFI runtime service mappings
> >>
> >>  arch/arm64/mm/dump.c               | 58 ++++++++------------
> >>  drivers/firmware/efi/arm-runtime.c |  2 +-
> >>  2 files changed, 24 insertions(+), 36 deletions(-)
> >
> > What's the plan with these patches? They no longer apply cleanly on top
> > of arm64 for-next/core.
> >
> 
> I will respin #1 and #2. Regarding patch #3, I think Mark wanted a
> more flexible approach?

My complaint was with placing the EFI table dump in the kernel table
dump, as the EFI page tables are distinct, and that VA range is shared
by other tables we map from time-to-time, e.g. the idmap.

So I would like to see the EFI tables exposed by a separate file.

I had patches [1] which librify the existing code and do just that, but
I haven't had the time to rebase and rework those. If you have the time,
feel free to pick that up!

Thanks,
Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/ptdump/librify
