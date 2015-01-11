From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 15:58:52 +0100
Subject: [PATCH v6 05/20] arm/arm64: KVM: introduce per-VM ops
In-Reply-To: <1420804478-17354-6-git-send-email-andre.przywara@arm.com>
References: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
 <1420804478-17354-6-git-send-email-andre.przywara@arm.com>
Message-ID: <20150111145852.GB21444@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 11:54:23AM +0000, Andre Przywara wrote:
> Currently we only have one virtual GIC model supported, so all guests
> use the same emulation code. With the addition of another model we
> end up with different guests using potentially different vGIC models,
> so we have to split up some functions to be per VM.
> Introduce a vgic_vm_ops struct to hold function pointers for those
> functions that are different and provide the necessary code to
> initialize them.
> Also split up the vgic_init() function to separate out VGIC model
> specific functionality into a separate function, which will later be
> different for a GICv3 model.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
