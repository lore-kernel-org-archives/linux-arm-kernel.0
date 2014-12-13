From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 13 Dec 2014 14:29:40 +0100
Subject: [PATCH v5 05/19] arm/arm64: KVM: introduce per-VM ops
In-Reply-To: <1418042274-3246-6-git-send-email-andre.przywara@arm.com>
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-6-git-send-email-andre.przywara@arm.com>
Message-ID: <20141213132940.GD16855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 12:37:40PM +0000, Andre Przywara wrote:
> Currently we only have one virtual GIC model supported, so all guests
> use the same emulation code. With the addition of another model we
> end up with different guests using potentially different vGIC models,
> so we have to split up some functions to be per VM.
> Introduce a vgic_vm_ops struct to hold function pointers for those
> functions that are different and provide the necessary code to
> initialize them.
> Also split up the kvm_vgic_init() function to separate out VGIC model
> specific functionality into a separate function, which will later be
> different for a GICv3 model.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
