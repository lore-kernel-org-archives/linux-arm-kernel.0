From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 6 Jun 2017 15:46:34 +0200
Subject: [PATCH 0/2] arm64/kvm: use SYS_REG_DESC() for VGIC-v3
In-Reply-To: <1496668801-16064-1-git-send-email-mark.rutland@arm.com>
References: <1496668801-16064-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170606134634.GE9464@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Jun 05, 2017 at 02:19:59PM +0100, Mark Rutland wrote:
> While looking around, I spotted that the VGIC-v3 code still uses open-coded SYS
> encodings. These patches migrate said code to use common <asm/sysreg.h>
> mnemonics, as we do for the rest of the AArch64 sysregs.
> 
> This is based on Marc's kvm-arm64/gicv3-cpuif-mediated-access branch [1].

Patches look good to me.  I can apply them after we apply [1] if
Catalin/Will are ok with this.

Thanks,
-Christoffer

> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv3-cpuif-mediated-access
> 
> Mark Rutland (2):
>   arm64/kvm: sysreg: fix typo'd SYS_ICC_IGRPEN*_EL1
>   arm64/kvm: vgic: use SYS_DESC()
> 
>  arch/arm64/include/asm/arch_gicv3.h |  2 +-
>  arch/arm64/include/asm/sysreg.h     | 12 ++++++++--
>  arch/arm64/kvm/vgic-sys-reg-v3.c    | 45 +++++++++++++------------------------
>  virt/kvm/arm/hyp/vgic-v3-sr.c       |  4 ++--
>  4 files changed, 28 insertions(+), 35 deletions(-)
> 
> -- 
> 1.9.1
> 
