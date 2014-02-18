From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Feb 2014 15:41:02 +0000
Subject: [PATCH v4 04/12] ARM: KVM: introduce kvm_p*d_addr_end
In-Reply-To: <1392737253-10480-5-git-send-email-marc.zyngier@arm.com>
References: <1392737253-10480-1-git-send-email-marc.zyngier@arm.com>
 <1392737253-10480-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140218154101.GC904@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:27:25PM +0000, Marc Zyngier wrote:
> The use of p*d_addr_end with stage-2 translation is slightly dodgy,
> as the IPA is 40bits, while all the p*d_addr_end helpers are
> taking an unsigned long (arm64 is fine with that as unligned long
> is 64bit).
> 
> The fix is to introduce 64bit clean versions of the same helpers,
> and use them in the stage-2 page table code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
