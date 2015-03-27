From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 27 Mar 2015 17:01:17 +0100
Subject: [PATCH v3 10/11] KVM: arm/arm64: prepare GICv3 emulation to use
 kvm_io_bus MMIO handling
In-Reply-To: <1427380778-942-11-git-send-email-andre.przywara@arm.com>
References: <1427380778-942-1-git-send-email-andre.przywara@arm.com>
 <1427380778-942-11-git-send-email-andre.przywara@arm.com>
Message-ID: <20150327160117.GF5121@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 02:39:37PM +0000, Andre Przywara wrote:
> Using the framework provided by the recent vgic.c changes, we
> register a kvm_io_bus device on mapping the virtual GICv3 resources.
> The distributor mapping is pretty straight forward, but the
> redistributors need some more love, since they need to be tagged with
> the respective redistributor (read: VCPU) they are connected with.
> We use the kvm_io_bus framework to register one devices per VCPU.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
