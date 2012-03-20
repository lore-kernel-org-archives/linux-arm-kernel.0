From: mporter@ti.com (Matt Porter)
Date: Tue, 20 Mar 2012 10:02:13 -0400
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <4F626180.2010902@ti.com>
References: <4F22DEF2.5000807@ti.com> <4F621939.9040906@ti.com>
 <20120315195753.GA2842@n2100.arm.linux.org.uk>
 <201203152041.53754.arnd@arndb.de> <4F626180.2010902@ti.com>
Message-ID: <20120320140213.GG14084@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 10:39:12PM +0100, Cousson, Benoit wrote:
> On 3/15/2012 9:41 PM, Arnd Bergmann wrote:
> >The numbers definitely need to become local to each of the controllers, but
> >that is the case pretty much automatically using the proposed binding,
> >because each dma request identifier starts with the phandle of the
> >controller.
> 
> Indeed, and in the case of the OMAP SDMA controller, it can handle
> up to 127 DMA request lines numbered from 0 to 126... So a local
> number seems to be a good representation... especially for a number.
> I'm not sure to understand the issue with this binding.
> 
> And AFAIK, there is the only one general purpose DMA controller in
> OMAP so far. The other ones are private to some IPs like MMC or USB,
> so they do not need necessarily need any DT representation.

AM335x has an EDMA controller instead of SDMA. This is the same EDMA
found on mach-davinci/ parts.

-Matt
