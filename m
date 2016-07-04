From: eric.auger@redhat.com (Auger Eric)
Date: Mon, 4 Jul 2016 15:54:17 +0200
Subject: [PATCH v7 09/17] KVM: arm64: introduce ITS emulation file with
 MMIO framework
In-Reply-To: <32d54016-731d-e4a9-272d-8b0934ebec31@arm.com>
References: <20160628123230.26255-1-andre.przywara@arm.com>
 <20160628123230.26255-10-andre.przywara@arm.com>
 <3fec9632-ce39-3508-2b71-4049fc959a64@redhat.com>
 <32d54016-731d-e4a9-272d-8b0934ebec31@arm.com>
Message-ID: <8546ac45-f7cd-31af-a261-bb85ca7305ca@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 04/07/2016 15:38, Andre Przywara wrote:
> 2) on KVM_DEV_ARM_VGIC_GRP_ADDR check that "initialized" is false
> 3) on KVM_DEV_ARM_VGIC_CTRL_INIT check that "initialized" is false
> 4) after KVM_DEV_ARM_VGIC_CTRL_INIT set initialized to true
> 
> I don't want to rely solely on vgic_its_base being ADDR_UNDEF, since I
> expect we extend that interface later by supporting more options (for
> instance to size the virtual ITS, in terms of devices, number of LPIs,
> collections, etc.)
> 
> Does that make sense?
> Or do we need more here?

So you will accept a call to KVM_DEV_ARM_VGIC_CTRL_INIT with an unset
address? I don't think this is relevant.

Thanks

Eric
