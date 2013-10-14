From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 14 Oct 2013 15:13:13 +0200
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <FAC2ABD2-F4AE-49D5-A787-F28391D910D7@suse.de>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <525BEBB4.4050603@redhat.com> <FAC2ABD2-F4AE-49D5-A787-F28391D910D7@suse.de>
Message-ID: <525BEDE9.8070304@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 14/10/2013 15:10, Alexander Graf ha scritto:
>> More precisely, it allows the guest drivers to pick the
>> endianness they prefer.  Mixed-endian virtio works fine on QEMU
>> with e.g. a mips guest in emulation mode, because then any given
>> QEMU binary will always use the same endianness (e.g. big for
>> qemu-system-mips).
> 
> We have the same problem (runtime switchable endianness) on PowerPC.
> IBM POWER is gaining Little Endian support in Linux now, so we could
> easily end up with an LE guest on a BE host.
> 
> IIRC the way we're going to solve this is to hack up
> virtio_is_big_endian() to evaluate the first CPU's endianness mode
> (which will always be the same as all other CPU's endianness mode due
> to hypercall restrictions).
> 
> You could do the same with ARM if you need to support guest kernels
> before the new virtio stuff is there. LE POWER is definitely already
> reality upstream.

And the virtio standard, when it becomes reality, will be LE-only except
for some s390 stuff that I don't claim I understand...

Paolo
