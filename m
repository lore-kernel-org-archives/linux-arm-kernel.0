From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Jun 2016 18:00:39 +0100
Subject: [PATCH v20 00/14] arm64 kexec kernel patches
In-Reply-To: <cover.1466702804.git.geoff@infradead.org>
References: <cover.1466702804.git.geoff@infradead.org>
Message-ID: <20160627170039.GD6847@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Thu, Jun 23, 2016 at 05:54:47PM +0000, Geoff Levand wrote:
> AKASHI Takahiro (7):
>       arm64: kdump: reserve memory for crash dump kernel
>       arm64: limit memory regions based on DT property, usable-memory
>       arm64: kdump: implement machine_crash_shutdown()
>       arm64: kdump: add kdump support
>       arm64: kdump: add VMCOREINFO's for user-space coredump tools
>       arm64: kdump: enable kdump in the arm64 defconfig
>       arm64: kdump: update a kernel doc
> 
> Geoff Levand (4):
>       arm64: Add back cpu reset routines
>       arm64/kexec: Add core kexec support
>       arm64/kexec: Enable kexec in the arm64 defconfig
>       arm64/kexec: Add pr_debug output
> 
> James Morse (3):
>       arm64: hibernate: Don't hibernate on systems with stuck CPUs
>       arm64: smp: Add function to determine if cpus are stuck in the kernel
>       Documentation: dt: usable-memory and elfcorehdr nodes for arm64 kexec

I dropped patch 1 (hibernate), cherry-picked patch 2 from mainline
("cpus stuck in the kernel", already pushed by Will to 4.7-rc5) and
merged patches 3-6, with the amendments that James mentioned.

The kdump patches, including the "Documentation" one from James require
more review, testing and acks by the corresponding maintainers (kdump,
DT). You also don't seem to have added a s-o-b for those patches (since
you are submitting them; unless you plan to let Akashi-san submit them
in the future).

Thanks.

-- 
Catalin
