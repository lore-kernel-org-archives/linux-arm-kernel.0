From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 8 Jun 2016 16:27:50 +0200
Subject: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
In-Reply-To: <33469694.MLbpCUJe2G@wuerfel>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <33469694.MLbpCUJe2G@wuerfel>
Message-ID: <20160608162750.712916ce@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thanks for your review!

On Thu, 02 Jun 2016 11:35:38 +0200, Arnd Bergmann wrote:
> On Thursday, June 2, 2016 11:09:43 AM CEST Thomas Petazzoni wrote:
> > +               ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
> > +                         0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
> >   
> 
> Any reason for not having a 64-bit MEM prefetchable area in the example?
> Does the host not support that?

I'll have to admit I am not sure how to find this out from the
datasheet. My datasheet says about the PCIe controller:

"""
64-bit PCIe address and system address space for outbound transactions
"""

So I guess this would indicate that a 64-bit MEM area is possible.
However, since anyway the area used above is at 0xe8000000 for a length
of 0x1000000, what would be the benefit of declaring this range as a
64-bit one ?

Regarding the prefetchable aspect, I couldn't find any reference in the
datasheet. However, the original driver code explicitly errors out if
there is no non-prefetchable memory area, so I guess prefetchable
areas is not supported.

In of_bus_pci_get_flags(), both the 32-bit and 64-bit cases are handled
in the same way, so is this distinction actually being used by the
kernel?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
