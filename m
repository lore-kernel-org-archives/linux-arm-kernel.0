From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 23 Nov 2014 10:58:23 +0100
Subject: [PATCH v4 05/19] arm/arm64: KVM: introduce per-VM ops
In-Reply-To: <1415959683-26027-6-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-6-git-send-email-andre.przywara@arm.com>
Message-ID: <20141123095823.GV3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:07:49AM +0000, Andre Przywara wrote:
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
> ---
> Changelog v3...v4:
> - add accessor functions for vm_ops members
> - introduce init_vgic_model() to differentiate between guest GIC models
> - simplify vgic_v2_init_emulation() 
> - help debugging by hinting on handle_mmio codeflow in comment
> 
That helped a lot as this patch goes, thanks for reworking the function
pointers and init sequence:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
