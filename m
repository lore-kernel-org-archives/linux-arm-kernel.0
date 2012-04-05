From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 5 Apr 2012 14:15:57 +0100
Subject: [PATCH] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
In-Reply-To: <4F7D974C.9050506@arm.com>
References: <1333384217-13441-1-git-send-email-marc.zyngier@arm.com>
 <4F7AC138.9020308@citrix.com> <4F7AC8A8.9020606@arm.com>
 <20120403153538.0D1B83E044A@localhost> <4F7D974C.9050506@arm.com>
Message-ID: <4F7D9B0D.7020009@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/12 13:59, Marc Zyngier wrote:
> 
> How about this?
> 
> 	gic: interrupt-controller at 2c001000 {
> 		compatible = "arm,cortex-a15-gic";
> 		#interrupt-cells = <3>;
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		interrupt-controller;
> 		reg = <0x2c001000 0x1000>,
> 		      <0x2c002000 0x100>;
> 
> 		vgic at 2c004000 {
> 			compatible = "arm,cortex-a15-vgic", "arm,vgic";
> 			reg = <0x2c004000 0x2000>,
> 			      <0x2c006000 0x2000>;
> 			interrupts = <1 9 0xf04>;
> 		};
> 	};
> 
> It cleanly separate the extension from the core GIC, and still make it
> part of the GIC node.

This looks sensible to me.

David
