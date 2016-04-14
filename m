From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 14:29:22 +0100
Subject: [PATCH v2 00/17] kvm-arm: Add stage2 page table walker
In-Reply-To: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <570F9B32.9090106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 14:20, Suzuki K Poulose wrote:
> This series adds support for stage2 page table helpers and makes
> the core kvm-arm MMU code make use of it. At the moment we assume
> that the host/hyp and the stage2 page tables have same number of
> levels and hence use the host level accessors (except for some
> hooks, e.g kvm_p.d_addr_end) and shares the routines for unmapping
> the page table ranges.

> The tree is available at :
>        git://linux-arm.org/linux-skp.git kvm-stage2/v2

Please note that the tree above contains one additional patch on top of kvmarm/master :
commit	91ad0db16a42a7d3("arm64/sunxi: 4.6-rc1: Add dependency on generic irq chip"),
which is there to fix a build break with ARCH_SUNXI selected on 4.6-rc1.

Thanks
Suzuki
