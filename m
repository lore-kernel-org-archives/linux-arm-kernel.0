From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Jan 2014 23:04:53 -0800
Subject: [PATCH v7 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <Pine.LNX.4.44L0.1401151525400.1587-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1401151525400.1587-100000@iolanthe.rowland.org>
Message-ID: <2909743.WgOIUglCS0@lenovo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 15 janvier 2014, 15:26:21 Alan Stern a ?crit :
> On Wed, 15 Jan 2014, Hans de Goede wrote:
> > Hi All,
> > 
> > This version of my ohci and ehci-platform clks, phy and dt support
> > patch-set, really fixes the 2 small bugs Alan found.
> 
> All okay -- this time I can't find anything to complain about.  :-)

There is one minor issue; which is that the ehci binding claims the driver 
supports the following optional boolean properties:

- big-endian-regs : boolean, set this for hcds with big-endian registers
- big-endian-desc : boolean, set this for hcds with big-endian descriptors
- big-endian : boolean, for hcds with big-endian-regs + big-endian-desc

while it does not (yet) so this is misleading. Can we at get that fixed before 
merging? Copy pasting the PPC ehci driver should do the job.
-- 
Florian
