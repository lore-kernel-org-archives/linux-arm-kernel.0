From: marex@denx.de (Marek Vasut)
Date: Tue, 26 Nov 2013 21:47:06 +0100
Subject: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
In-Reply-To: <20131125230935.GA4034@google.com>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
 <20131125230935.GA4034@google.com>
Message-ID: <201311262147.07036.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

> On Tue, Oct 22, 2013 at 09:55:43PM -0700, Tim Harvey wrote:
> > The IMX6 iATU is used for address translation between the AXI bus
> > address space and PCI address space.  This is used for type0 and type1
> > config cycles but is not necessary for outbound io/mem regions.
> > 
> > This patch removes the calls that inappropriately re-configures the ATU
> > viewport for outbound memory and IO after config cycles and removes them
> > altogether as they are not necessary.
> > 
> > This resolves issues with PCI devices behind switches and has been tested
> > with a Gige device behind a PLX PEX860x switch.  More testing is needed
> > for other configurations.
> > 
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> Dropping for now, per Marek and Pratyush's concerns.  Poke me if/when those
> are resolved.

I hope (unless of course I again fail to under load of other stuff to do) to 
look at the PCIe stuff again next week once I'm in the office. In the meantime, 
I'd love to submit new set of patches.

Best regards,
Marek Vasut
