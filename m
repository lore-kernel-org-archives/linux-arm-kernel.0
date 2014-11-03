From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 03 Nov 2014 13:25:11 +0000
Subject: [PATCH v3 02/19] arm/arm64: KVM: pass down user space provided
 GIC type into vGIC code
In-Reply-To: <20141103131425.GC16132@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-3-git-send-email-andre.przywara@arm.com>
 <20141103131425.GC16132@cbox>
Message-ID: <54578237.3080900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 03/11/14 13:14, Christoffer Dall wrote:
> On Fri, Oct 31, 2014 at 05:26:37PM +0000, Andre Przywara wrote:
>> With the introduction of a second emulated GIC model we need to let
>> userspace specify the GIC model to use for each VM. Pass the
>> userspace provided value down into the vGIC code and store it there
>> to differentiate later.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Did you change anything since v2?

Yes (and that's why I dropped your ack):
I moved the line that stores the vgic_model from the "introduce
per-VM-ops" patch into here (plus the declaration of it):

	kvm->arch.vgic.vgic_model = type;

That was part of the split-up to make that bigger patch more readable.

Regards,
Andre.

> 
> If not, care to apply my ack from last time?
> 
> -Christoffer
> 
