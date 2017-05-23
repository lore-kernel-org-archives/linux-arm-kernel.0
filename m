From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 23 May 2017 14:56:27 +0200
Subject: [PATCH v3 1/3] Documentation/bindings: Document the SafeXel
 cryptographic engine driver
In-Reply-To: <9a3961ee-1396-cc8f-64ca-12beacf75c2a@arm.com>
References: <20170424075407.19730-1-antoine.tenart@free-electrons.com>
 <20170424075407.19730-2-antoine.tenart@free-electrons.com>
 <7986721e-3a2b-23fb-61d7-7032f0d65533@arm.com>
 <20170522143049.GD14976@kwain.lan>
 <e8ef1f11-539c-9abc-9977-36366d4994b1@arm.com>
 <20170522145440.GE14976@kwain.lan>
 <44fc18ba-a06a-de89-2172-08c093880e79@arm.com>
 <20170522213746.403aa844@free-electrons.com>
 <9a3961ee-1396-cc8f-64ca-12beacf75c2a@arm.com>
Message-ID: <20170523145627.63054e08@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 23 May 2017 12:13:28 +0100, Marc Zyngier wrote:

> > The crypto block being in the CP part, it has a wired interrupt to the
> > ICU (also in the CP). The ICU then turns this wired interrupt into a
> > memory write transaction to a register called GICP SPI in the AP, which
> > triggers a SPI interrupt in the GIC.  
> 
> Is that some kind of Level-triggered MSI, ? la GICv3 GICD_SETSPI_NSR?

It is some kind of MSI, and the registers are called
GICP_SETSPI/GICP_CLRSPI, so I would assume it's quite similar to this
GICv3 feature.

> > However, I have a patch series that I plan to submit hopefully in the
> > next days that adds an ICU driver, and changes the Device Tree to refer
> > to the ICU interrupt instead.  
> 
> OK, I'm quite interested to see that, specially if my above hunch is
> right...

I'll send the patches soon. I'm sure there will be lots of comments :)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
