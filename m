From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 13 Dec 2014 14:31:14 +0100
Subject: [PATCH v5 08/19] arm/arm64: KVM: make the maximum number of
 vCPUs a per-VM value
In-Reply-To: <1418042274-3246-9-git-send-email-andre.przywara@arm.com>
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-9-git-send-email-andre.przywara@arm.com>
Message-ID: <20141213133114.GE16855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 12:37:43PM +0000, Andre Przywara wrote:
> Currently the maximum number of vCPUs supported is a global value
> limited by the used GIC model. GICv3 will lift this limit, but we
> still need to observe it for guests using GICv2.
> So the maximum number of vCPUs is per-VM value, depending on the
> GIC model the guest uses.
> Store and check the value in struct kvm_arch, but keep it down to
> 8 for now.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
