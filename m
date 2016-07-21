From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Thu, 21 Jul 2016 15:17:20 +0200
Subject: [PATCH v2] arm64: KVM: VHE: Context switch MDSCR_EL1
In-Reply-To: <1468933014-26966-1-git-send-email-marc.zyngier@arm.com>
References: <1468933014-26966-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160721131720.GA32739@potion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-19 13:56+0100, Marc Zyngier:
> The kprobe enablement work has uncovered that changes made by
> a guest to MDSCR_EL1 were propagated to the host when VHE was
> enabled, leading to unexpected exception being delivered.
> 
> Moving this register to the list of registers that are always
> context-switched fixes the issue.
> 
> Fixes: 9c6c35683286 ("arm64: KVM: VHE: Split save/restore of registers shared between guest and host")
> Cc: stable at vger.kernel.org #4.6
> Reported-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>
> Tested-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

I would take this patch to 4.7 directly through the main tree.
Are your plans different?

Thanks.
