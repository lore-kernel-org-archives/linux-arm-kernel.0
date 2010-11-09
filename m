From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Nov 2010 13:18:38 +0000
Subject: [PATCH] ARM: Temporary fix for broken arch reboot
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAB9E@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAB9E@dbde02.ent.ti.com>
Message-ID: <20101109131838.GF2869@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 06:40:39PM +0530, Shilimkar, Santosh wrote:
> With commit 3d3f78d752bf, reboot seems to broken on ARM
> machines. CPU dies while doing flush_pmd_entry() as part of
> setup_mm_for_reboot()
> 
> I know this is not the fix but intention is to report the
> issue and also provide temporary fix till it get fixed correctly

So you're now rebooting with the secondary CPUs still running.  I guess
that the secondary CPUs end up crashing and don't restart.

I think more the question is why the CP15 cache clean/flush is hanging
with the other CPUs taken down.  All the other CPUs will be doing is
sitting in a loop doing nothing.

Catalin?
