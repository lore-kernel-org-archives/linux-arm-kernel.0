From: scottwood@freescale.com (Scott Wood)
Date: Fri, 11 Jan 2013 14:11:18 -0600
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <A6843D28-E2AF-4EFF-8C9B-232B804C01E7@suse.de> (from
 agraf@suse.de on Fri Jan 11 09:42:55 2013)
Message-ID: <1357935078.5475.10@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2013 09:42:55 AM, Alexander Graf wrote:
> 
> On 11.01.2013, at 02:10, Scott Wood wrote:
> 
> > struct kvm_device_attr {
> > 	__u32 device;
> 
> This needs some semantic specification. Is device a constant value?  
> Is it the return value of CREATE_IRQCHIP?

As proposed, it's up to the architecture to provide that  
specification.  In theory this could be used for things other than IRQ  
chips.  We could still say that device creation functions return a  
valid device ID (if the device has any attributes), as well as have  
other architecture-specific ways of describing device IDs (static  
enumeration).  Or we could have non-architecture-specific static  
enumeration.  Or just require that all devices be explicitly created by  
something that returns the ID.

Do you have a preferred approach?

-Scott
