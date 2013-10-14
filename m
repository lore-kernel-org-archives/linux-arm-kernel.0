From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 14 Oct 2013 15:03:48 +0200
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <525BEBB4.4050603@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 11/10/2013 16:36, Marc Zyngier ha scritto:
> This small patch series adds just enough kernel infrastructure and
> fixes to allow a BE guest to use virtio-mmio on a LE host, provided
> that the host actually supports such madness.

More precisely, it allows the guest drivers to pick the endianness they
prefer.  Mixed-endian virtio works fine on QEMU with e.g. a mips guest
in emulation mode, because then any given QEMU binary will always use
the same endianness (e.g. big for qemu-system-mips).

As far as I understand, patches 2 and 3 are really separate bugfixes,
and they should go in irrespective of patch 1.

Paolo

> This has been tested on arm64, with some fixes to KVM and a set of
> changes to kvmtool, both which I am posting separately.
> 
> A branch containing all the relevant changes is at:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/be-on-le-3.12-rc4
> 
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
