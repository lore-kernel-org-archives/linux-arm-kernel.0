From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 22 May 2017 21:37:46 +0200
Subject: [PATCH v3 1/3] Documentation/bindings: Document the SafeXel
 cryptographic engine driver
In-Reply-To: <44fc18ba-a06a-de89-2172-08c093880e79@arm.com>
References: <20170424075407.19730-1-antoine.tenart@free-electrons.com>
 <20170424075407.19730-2-antoine.tenart@free-electrons.com>
 <7986721e-3a2b-23fb-61d7-7032f0d65533@arm.com>
 <20170522143049.GD14976@kwain.lan>
 <e8ef1f11-539c-9abc-9977-36366d4994b1@arm.com>
 <20170522145440.GE14976@kwain.lan>
 <44fc18ba-a06a-de89-2172-08c093880e79@arm.com>
Message-ID: <20170522213746.403aa844@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 22 May 2017 16:02:33 +0100, Marc Zyngier wrote:

> > It also says: 87 =>  34 En Lv 5, which is the IRQ I'm looking for.  
> 
> Ah, that one as well. So how is the interrupt routed? Via the ICU, and
> then to the GIC (with several ICU sources mapped on a single SPI)?

The crypto block being in the CP part, it has a wired interrupt to the
ICU (also in the CP). The ICU then turns this wired interrupt into a
memory write transaction to a register called GICP SPI in the AP, which
triggers a SPI interrupt in the GIC.

In the current mainline kernel, the ICU is configured by the firmware
and creates static associations between wired interrupts in the CP and
corresponding SPI interrupts. Therefore the Device Tree currently
reference such SPI interrupts directly.

However, I have a patch series that I plan to submit hopefully in the
next days that adds an ICU driver, and changes the Device Tree to refer
to the ICU interrupt instead.

Therefore, I don't think the binding should reference anything else
than the usual info about the interrupts property.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
