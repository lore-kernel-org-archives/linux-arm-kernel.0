From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Dec 2014 11:43:05 +0000
Subject: [PATCH v5 05/19] arm/arm64: KVM: introduce per-VM ops
In-Reply-To: <1418042274-3246-6-git-send-email-andre.przywara@arm.com> (Andre
 Przywara's message of "Mon, 8 Dec 2014 12:37:40 +0000")
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-6-git-send-email-andre.przywara@arm.com>
Message-ID: <86ppba1tiu.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08 2014 at 12:37:40 PM, Andre Przywara <andre.przywara@arm.com> wrote:
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

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
