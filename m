From: panand@redhat.com (Pratyush Anand)
Date: Fri, 29 Apr 2016 20:26:00 +0530
Subject: [PATCH 06/12] ARM: kexec: advertise location of bootable RAM
In-Reply-To: <E1aviF4-0000jG-MO@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviF4-0000jG-MO@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Apr 28, 2016 at 2:58 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Advertise the location of bootable RAM to kexec-tools.  kexec needs to
> know where it can place the kernel in RAM, and so be executable when
> the system needs to jump into it.
>
> Advertise these areas in /proc/iomem with a "System RAM (boot alias)"
> tag.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Can you please also share git tree path of corresponding kexec-tools changes?

Could it be a better idea (if things in user space become simpler)
that in stead of patch 5 and 6, we pass arch_phys_to_idmap_offset to
user space, and then user space manipulates existing "Crash kernel"
and "System RAM" resources.

~Pratyush
