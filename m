From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 May 2018 16:52:39 +0100
Subject: [PATCH 2/4] arm64: KVM: Avoid marking pages as XN in Stage-2 if
 CTR_EL0.DIC is set
In-Reply-To: <20180517103548.5622-3-marc.zyngier@arm.com>
References: <20180517103548.5622-1-marc.zyngier@arm.com>
 <20180517103548.5622-3-marc.zyngier@arm.com>
Message-ID: <20180524155239.htgvfp2xjwztshvh@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 11:35:46AM +0100, Marc Zyngier wrote:
> On systems where CTR_EL0.DIC is set, we don't need to perform
> icache invalidation to guarantee that we'll fetch the right
> instruction stream.
> 
> This also means that taking a permission fault to invalidate the
> icache is an unnecessary overhead.
> 
> On such systems, we can safely leave the page as being executable.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
