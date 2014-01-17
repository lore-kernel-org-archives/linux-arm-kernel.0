From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 17 Jan 2014 12:12:29 -0500 (EST)
Subject: [PATCH v7 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <2909743.WgOIUglCS0@lenovo>
Message-ID: <Pine.LNX.4.44L0.1401171053180.1162-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jan 2014, Florian Fainelli wrote:

> Le mercredi 15 janvier 2014, 15:26:21 Alan Stern a ?crit :
> > On Wed, 15 Jan 2014, Hans de Goede wrote:
> > > Hi All,
> > > 
> > > This version of my ohci and ehci-platform clks, phy and dt support
> > > patch-set, really fixes the 2 small bugs Alan found.
> > 
> > All okay -- this time I can't find anything to complain about.  :-)
> 
> There is one minor issue; which is that the ehci binding claims the driver 
> supports the following optional boolean properties:
> 
> - big-endian-regs : boolean, set this for hcds with big-endian registers
> - big-endian-desc : boolean, set this for hcds with big-endian descriptors
> - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
> 
> while it does not (yet) so this is misleading. Can we at get that fixed before 
> merging? Copy pasting the PPC ehci driver should do the job.

I agree it needs to be fixed.  This can be done in a follow-up patch,
though.  It doesn't have to be in this one because nobody is using
ehci-platform with DT yet.

A simple copy from the PPC driver isn't quite enough, because the
platform data settings would override the DT values.  
ehci_platform_reset has to be changed so that it sets
ehci->big_endian_desc and _mmio if the pdata flags are set, but
otherwise leaves them alone.

Hans, would you like to write another patch to take care of this?

Alan Stern
