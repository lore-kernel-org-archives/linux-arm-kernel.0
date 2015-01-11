From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 13:39:54 +0100
Subject: [PATCH v3 2/2] KVM: arm/arm64: vgic: add init entry to VGIC KVM
 device
In-Reply-To: <1418665413-31521-3-git-send-email-eric.auger@linaro.org>
References: <1418665413-31521-1-git-send-email-eric.auger@linaro.org>
 <1418665413-31521-3-git-send-email-eric.auger@linaro.org>
Message-ID: <20150111123954.GW21092@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 06:43:33PM +0100, Eric Auger wrote:
> Since the advent of VGIC dynamic initialization, this latter is
> initialized quite late on the first vcpu run or "on-demand", when
> injecting an IRQ or when the guest sets its registers.
> 
> This initialization could be initiated explicitly much earlier
> by the users-space, as soon as it has provided the requested
> dimensioning parameters.
> 
> This patch adds a new entry to the VGIC KVM device that allows
> the user to manually request the VGIC init:
> - a new KVM_DEV_ARM_VGIC_GRP_CTRL group is introduced.
> - Its first attribute is KVM_DEV_ARM_VGIC_CTRL_INIT
> 
> The rationale behind introducing a group is to be able to add other
> controls later on, if needed.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
This looks good to me:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
