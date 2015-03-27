From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 27 Mar 2015 00:14:07 +0000
Subject: [PATCH v3 09/11] KVM: arm/arm64: merge GICv3 RD_base and SGI_base
 register frames
In-Reply-To: <20150326215308.74b994ff@arm.com>
References: <1427380778-942-1-git-send-email-andre.przywara@arm.com>	<1427380778-942-10-git-send-email-andre.przywara@arm.com>
 <20150326215308.74b994ff@arm.com>
Message-ID: <5514A0CF.80907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2015 09:53 PM, Marc Zyngier wrote:
> On Thu, 26 Mar 2015 14:39:36 +0000
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> Currently we handle the redistributor registers in two separate MMIO
>> regions, one for the overall behaviour and SPIs and one for the
>> SGIs/PPIs. That latter forces the creation of _two_ KVM I/O bus
>> devices for each redistributor.
>> Since the spec mandates those two pages to be contigious, we could as
>> well merge them and save the churn with the second KVM I/O bus device.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> I wonder why we didn't have it that way the first place...

Me too ;-)

> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks!
Andre.
