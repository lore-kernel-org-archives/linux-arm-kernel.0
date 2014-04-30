From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 30 Apr 2014 21:26:35 +0200
Subject: [GIT PULL] KVM/ARM Fixes for 3.15-rc4
In-Reply-To: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
References: <1398856556-13199-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <53614E6B.8090700@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 30/04/2014 13:15, Christoffer Dall ha scritto:
> The following changes since commit 0f689a33ad17845363acdc6d52783befd6ad116c:
>
>   Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2014-04-16 11:28:25 -0700)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-3.15-rc4
>
> for you to fetch changes up to 30c2117085bc4e05d091cee6eba79f069b41a9cd:
>
>   KVM: ARM: vgic: Fix the overlap check action about setting the GICD & GICC base address. (2014-04-29 02:01:43 -0700)
>
> ----------------------------------------------------------------
> First round of KVM/ARM Fixes for 3.15
>
> Includes vgic fixes, a possible kernel corruption bug due to
> misalignment of pages and disabling of KVM in KConfig on big-endian
> systems, because the last one breaks the build.
>
> ----------------------------------------------------------------
> Andre Przywara (1):
>       KVM: arm/arm64: vgic: fix GICD_ICFGR register accesses
>
> Haibin Wang (2):
>       KVM: ARM: vgic: Fix sgi dispatch problem
>       KVM: ARM: vgic: Fix the overlap check action about setting the GICD & GICC base address.
>
> Mark Salter (1):
>       arm: KVM: fix possible misalignment of PGDs and bounce page
>
> Will Deacon (1):
>       ARM: KVM: disable KVM in Kconfig on big-endian systems
>
>  arch/arm/kvm/Kconfig |  2 +-
>  arch/arm/kvm/mmu.c   | 15 +++++++++------
>  virt/kvm/arm/vgic.c  | 15 ++++++++-------
>  3 files changed, 18 insertions(+), 14 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Pulled, thanks.  I'll send the pull request out on Friday, because 
tomorrow is a public holiday here.

Paolo
