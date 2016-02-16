From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Feb 2016 10:57:59 +0000
Subject: [PATCH] arm64: mark kernel text segment as MEMBLOCK_NOMAP
In-Reply-To: <CAKv+Gu9uwcjc0dgO+KOrmhJ=Kyc1ojD1FF32gu7v7VFNFqKpnw@mail.gmail.com>
References: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160215114505.GE13683@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-Y-k_LAbFZJjiPuHq6ssaFCb3WMG_fVGx3ODrvb+hEUQ@mail.gmail.com>
 <20160215120809.GF13683@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9uwcjc0dgO+KOrmhJ=Kyc1ojD1FF32gu7v7VFNFqKpnw@mail.gmail.com>
Message-ID: <20160216105759.GC19413@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 09:49:48AM +0100, Ard Biesheuvel wrote:
> On 15 February 2016 at 13:08, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Feb 15, 2016 at 12:53:59PM +0100, Ard Biesheuvel wrote:
> >> On 15 February 2016 at 12:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> > Ard, I'm about to drop the kernel memory map patches from -next. There
> >> > are several issues like KASAN (which may as well be a KASAN bug but I
> >> > haven't got to the bottom of it yet), initrd (you have patches but
> >> > require additional acks).
> >> >
> >> > I'll keep your stuff on the for-next/kernmap branch and do further
> >> > debugging. If it stabilises in the next 1-2 weeks, I'll merge it into
> >> > for-next/core for 4.6, otherwise, it will have to wait. I would really
> >> > like these patches merged but it looks like they need wider testing.
> > [...]
> >> If you are going to drop it for now anyway, I can do a v6sub1 with
> >> this issue and the initrd issue addressed, but also an issue with the
> >> KVM ksym ref patch with GCC 4.8. Since these issues affect
> >> bisectability, I'd prefer to rebase entirely, and fold all the fixes
> >> rather than apply them on top.
> >
> > That's fine. I'll push one more patch to the for-next/pgtable branch,
> > converting __set_fixmap_offset() back to a macro as it broke other
> > architectures. Otherwise it is not rebased and I'll merge it into
> > for-next core.
> 
> If you are doing for-next/core from scratch, perhaps it is better to
> squash the fixmap patches as well?

I could, assuming you were the only one using the for-next/pgtable
branch and I won't get pull requests against it (I usually cherry-pick
the patches, so not a problem).

-- 
Catalin
