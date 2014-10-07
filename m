From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Oct 2014 16:22:19 +0100
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <1412370971.32313.30.camel@smoke>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
 <1412370971.32313.30.camel@smoke>
Message-ID: <20141007152219.GB27216@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

> > Does this patch series work with kexec on UEFI machines?
> 
> I have not done much more than some simple re-boot tests using the
> base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> but yes, it should work.

Where you booting the kernel as an UEFI application, or were you using the
Linux loader? The latter arguably isn't a UEFI boot because the kernel doesn't
know of or have access to UEFI (and arguably said laoder shouldn't even be
there).

I've just had a go on Juno, but I wasn't able to get the tool to work.
It seems that it's unhappy with the DTB because the EFI stub deleted the
memory nodes (to enforce use of the UEFI memory map). I'm not sure what
the tool needs to parse the memory map for, so I don't know what the
best way around that is.

nanook at localhost:~/opt/sbin$ ./kexec /home/nanook/vmlinux 
kexec version: 14.10.02.15.58-g706fbeb
Modified cmdline: root=/dev/nfs 
Unable to find /proc/device-tree//chosen/linux,stdout-path, printing from purgatory is diabled
get_memory_ranges_dt:756: Invalid /proc/device-tree.
kexec: kexec/arch/arm64/kexec-arm64.c:625: virt_to_phys: Assertion `arm64_mem.memstart' failed.
Aborted

Thanks,
Mark.
