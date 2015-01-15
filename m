From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Jan 2015 13:18:08 +0100
Subject: [PATCH v7 08/20] arm/arm64: KVM: make the maximum number of
 vCPUs a per-VM value
In-Reply-To: <1421253084-9663-9-git-send-email-andre.przywara@arm.com>
References: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
 <1421253084-9663-9-git-send-email-andre.przywara@arm.com>
Message-ID: <20150115121808.GT26222@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 04:31:12PM +0000, Andre Przywara wrote:
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
