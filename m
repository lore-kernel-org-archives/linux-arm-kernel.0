From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 26 Aug 2014 16:29:14 +0200
Subject: [PATCH 01/11] KVM: ARM/arm64: fix non-const declaration of
 function returning const
In-Reply-To: <1409062410-25891-2-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-2-git-send-email-will.deacon@arm.com>
Message-ID: <20140826142914.GA5757@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:13:20PM +0100, Will Deacon wrote:
> Sparse kicks up about a type mismatch for kvm_target_cpu:
> 
> arch/arm64/kvm/guest.c:271:25: error: symbol 'kvm_target_cpu' redeclared with different type (originally declared at ./arch/arm64/include/asm/kvm_host.h:45) - different modifiers
> 
> so fix this by adding the missing const attribute to the function
> declaration.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
