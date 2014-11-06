From: geoff@infradead.org (Geoff Levand)
Date: Thu, 06 Nov 2014 10:25:09 -0800
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <CAFdej01qZMr3CgBv6jOuXHod2F8zHg89yDA8FA4m65bFEn+vYw@mail.gmail.com>
 <20141106152830.GF23706@leverpostej>
 <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
Message-ID: <1415298309.12884.45.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Thu, 2014-11-06 at 21:43 +0530, Arun Chandran wrote:
> Initializing cgroup subsys cpu
> Linux version 3.17.0-rc4+ (arun at arun-OptiPlex-9010) (gcc version 4.9.1
> 20140505 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro
> GCC 4.9-2014.05) ) #12 PREEMPT Thu Nov 6 21:38:03 IST 2014
> CPU: AArch64 Processor [500f0000] revision 0
> Detected PIPT I-cache on CPU0
> Ignoring memory block 0x100000000 - 0x180000000
> Early serial console at MMIO32 0x1c020000 (options '')
> bootconsole [uart0] enabled
> efi: Getting EFI parameters from FDT:
> efi: UEFI not found.
> cma: Failed to reserve 16 MiB

This error comes from cma_declare_contiguous().

> Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.

This panic comes from memblock_alloc_base().  I guess something has
passed in bad values.

I wonder if your dtb is compatible with this platform.  What if you
don't pass a dtb to kexec?

It could be caused by memory corruption.

-Geoff
