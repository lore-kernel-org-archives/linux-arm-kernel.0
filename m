From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Nov 2014 20:30:22 +0100
Subject: [PATCH v3 13/19] arm/arm64: KVM: add vgic.h header file
In-Reply-To: <1414776414-13426-14-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-14-git-send-email-andre.przywara@arm.com>
Message-ID: <20141104193022.GP16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:48PM +0000, Andre Przywara wrote:
> vgic.c is currently a mixture of generic vGIC emulation code and
> functions specific to emulating a GICv2. To ease the addition of
> GICv3 later, we create new header file vgic.h, which holds constants
> and prototypes of commonly used functions.
> I removed the long-standing comment about using the kvm_io_bus API
> to tackle the GIC register ranges, as it wouldn't be a win for us
> anymore.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> -------
> As the diff isn't always obvious here (and to aid eventual rebases),
> here is a list of high-level changes done to the code:
> * moved definitions and prototypes from vgic.c to vgic.h:
>   - VGIC_ADDR_UNDEF
>   - ACCESS_{READ,WRITE}_*
>   - vgic_update_state()
>   - vgic_kick_vcpus()
>   - vgic_get_vmcr()
>   - vgic_set_vmcr()
>   - struct mmio_range {}
>   - IS_IN_RANGE() macro

should we worry about generic names now being exported and think about
renaming to things like kvm_mmio_range ?

(For the record, I'm not a strong proponent of this idea, just thought
it better to raise the issue now than later.)

Otherwise:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
