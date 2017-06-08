From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 8 Jun 2017 14:12:02 +0200
Subject: [PATCH v2 2/6] dt-bindings: interrupt-controller: add DT
 binding for the Marvell ICU
In-Reply-To: <20170607223317.hkpak5y2oalktjqe@rob-hp-laptop>
References: <1496398017-6487-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496398017-6487-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170607223317.hkpak5y2oalktjqe@rob-hp-laptop>
Message-ID: <20170608141202.14e4801e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 7 Jun 2017 17:33:17 -0500, Rob Herring wrote:

> > +Example:
> > +
> > +icu: interrupt-controller at 1e0000 {
> > +	compatible = "marvell,cp110-icu";
> > +	reg = <0x1e0000 0x10>;
> > +	#interrupt-cells = <3>;
> > +	interrupt-controller;
> > +	interrupt-parent = <&gic>;  
> 
> If you have a parent, then you should have some interrupts. I guess that 
> would be your ranges property? I suppose that is fine.

The ranges of interrupts available is defined by the gicp node. Indeed,
as explained in the cover letter:

 - We have one GICP in the SoC, providing a number of GIC SPI interrupts

 - We have one ICU per CP in the SoC. So for example in the Armada 8K,
   we have two CPs, and therefore two ICUs.

So the range of available GIC SPI interrupts it not associated to each
ICU, it's a global range of GIC SPI interrupts: each can freely be
allocated by any of the ICUs in the system.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
