From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Feb 2016 16:46:06 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <CAFEAcA9SQjg3GpDpU-Tt8i+JiOcJWQKTNzwLLTC4imiBuiP6+w@mail.gmail.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <20160218180313.GE2538@e104818-lin.cambridge.arm.com>
 <CAFEAcA9SQjg3GpDpU-Tt8i+JiOcJWQKTNzwLLTC4imiBuiP6+w@mail.gmail.com>
Message-ID: <20160219164606.GD12864@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 03:38:44PM +0000, Peter Maydell wrote:
> On 18 February 2016 at 18:03, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Feb 05, 2016 at 02:58:45PM +0000, James Morse wrote:
> >> James Morse (5):
> >>   arm64: cpufeature: Change read_cpuid() to use sysreg's mrs_s macro
> >>   arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
> >>   arm64: kernel: Add support for User Access Override
> >>   arm64: cpufeature: Test 'matches' pointer to find the end of the list
> >>   arm64: kernel: Don't toggle PAN on systems with UAO
> >
> > Patches applied with an additional fixup on top for removing
> > get_thread_info().
> 
> Just to let you know, unfortunately this series breaks booting the
> kernel on QEMU. We didn't implement the parts of the ID register
> space that the ARM ARM documents as "reserved, RAZ", and so when
> the kernel touches ID_AA64MMFR2 (new in v8.2) QEMU hands it an
> UNDEF. This is obviously a bug in QEMU, and I just sent out a patch
> for it: http://patchwork.ozlabs.org/patch/585237/ -- but of course
> that doesn't do anything for all the buggy QEMUs already in the field.
> 
> This is more of a heads-up than a demand that you Do Something,
> but perhaps somebody has a clever idea...

Only if Qemu had its own MIDR/REVIDR ;) (and patch the instruction like
other errata workarounds).

-- 
Catalin
