From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Feb 2016 12:08:10 +0000
Subject: [PATCH] arm64: mark kernel text segment as MEMBLOCK_NOMAP
In-Reply-To: <CAKv+Gu-Y-k_LAbFZJjiPuHq6ssaFCb3WMG_fVGx3ODrvb+hEUQ@mail.gmail.com>
References: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160215114505.GE13683@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-Y-k_LAbFZJjiPuHq6ssaFCb3WMG_fVGx3ODrvb+hEUQ@mail.gmail.com>
Message-ID: <20160215120809.GF13683@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 12:53:59PM +0100, Ard Biesheuvel wrote:
> On 15 February 2016 at 12:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Ard, I'm about to drop the kernel memory map patches from -next. There
> > are several issues like KASAN (which may as well be a KASAN bug but I
> > haven't got to the bottom of it yet), initrd (you have patches but
> > require additional acks).
> >
> > I'll keep your stuff on the for-next/kernmap branch and do further
> > debugging. If it stabilises in the next 1-2 weeks, I'll merge it into
> > for-next/core for 4.6, otherwise, it will have to wait. I would really
> > like these patches merged but it looks like they need wider testing.
[...]
> If you are going to drop it for now anyway, I can do a v6sub1 with
> this issue and the initrd issue addressed, but also an issue with the
> KVM ksym ref patch with GCC 4.8. Since these issues affect
> bisectability, I'd prefer to rebase entirely, and fold all the fixes
> rather than apply them on top.

That's fine. I'll push one more patch to the for-next/pgtable branch,
converting __set_fixmap_offset() back to a macro as it broke other
architectures. Otherwise it is not rebased and I'll merge it into
for-next core.

-- 
Catalin
