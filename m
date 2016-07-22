From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Fri, 22 Jul 2016 21:50:17 +0200
Subject: [PULL] KVM/ARM updates for Linux 4.8, take #1
In-Reply-To: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160722195016.GD9019@potion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-22 18:28+0100, Marc Zyngier:
> Paolo, Radim,
> 
> Please find below the first batch of 4.8 updates for KVM/ARM. Biggest
> feature is the long awaited GICv3 ITS emulation, allowing MSIs to be
> delivered into guests running on GICv3 HW. The other big feature is
> the removal of the old vgic implementation. Less visible is the revamp
> of the way we deal with the HYP initialization (by keeping an idmap
> around), and making HYP page tables honor the kernel's own protection.
> 
> This may generate a few conflicts, all of which have been seen in
> -next. 3 which are KVM specific (and pretty easy to resolve), and
> another one in include/irqchip/arm-gic-v3.h. They should be resolved
> as in -next.
> 
> Please pull!

Pulled into kvm/next, KVM_CAP_MSI_DEVID is 131.

>  54 files changed, 2698 insertions(+), 6065 deletions(-)

<3
