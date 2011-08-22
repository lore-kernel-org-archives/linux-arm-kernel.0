From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 00:40:08 +0100
Subject: error: implicit declaration of function 'machine_is_ventana'
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A376A@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04B24A376A@HQMAIL01.nvidia.com>
Message-ID: <20110822234008.GC3895@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 04:11:50PM -0700, Stephen Warren wrote:
> Russell,
> 
> Commit 46dcfc806a9f6834e6007449eac175f781058c49 "ARM: Update mach-types"
> removed the entry for Ventana (2927). In turn, this broke compilation of
> sound/soc/tegra/tegra_wm8903.c, since that calls machine_is_ventana().
> It looks like the machine is still registered at
> http://www.arm.linux.org.uk/developer/machines/. Can you explain what the
> removal policy is for arch/arm/tools/mach-types?

The policy has always been that the machine_is_xxx() matches the other
constants.  Rather than having to edit those out by hand, the script
now does this for me automatically.

This means any I've missed in previous updates are now missing.  And
if that means stuff was merged with the non-conforming entries, then
that's a problem.

It's not something I particularly care about because the responsibility
has always been on the submitter to talk to me if they want to change
those constants.  As they haven't talked to me...

Please submit a patch to fix your use in the kernel, including updating
the mach-types file to conform.  I'll then fix the machine registry by
hand.
