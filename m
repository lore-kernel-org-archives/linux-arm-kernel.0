From: marex@denx.de (Marek Vasut)
Date: Thu, 26 Jun 2014 11:13:02 +0200
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <20140626054937.GB7859@dragon>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
 <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
 <20140626054937.GB7859@dragon>
Message-ID: <201406261113.02894.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 26, 2014 at 07:49:38 AM, Shawn Guo wrote:
> On Thu, Jun 26, 2014 at 12:43:19AM -0300, Fabio Estevam wrote:
> > On Thu, Jun 26, 2014 at 12:12 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > > On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> > >> From: Fabio Estevam <fabio.estevam@freescale.com>
> > >> 
> > >> When the mx6 PCI conctroller is initialized in the bootloader we see a
> > >> kernel hang inside imx6_add_pcie_port().
> > >> 
> > >> Adding a 30ms delay allows the kernel to boot.
> > > 
> > > We may not want to add a random delay into the driver before we
> > > understand the root cause of the issue.
> > 
> > Yes, that's why I sent this as RFC and also explained it below the ---
> > line that I am actually trying to get some help with this issue.
> > 
> > > Do you see this issue with FSL kernel?
> > 
> > Yes, it also hangs.
> > 
> > It is reproducible in 100% of the boots. Just need to use mainline
> > U-boot (which has PCI driver enabled by default).
> > I am using an Intel Wifi 7260 PCI card. This was also reported by
> > other folks in the U-boot list.
> 
> Richard,
> 
> Can you schedule some time to look at this issue?  I think it will come
> to us sooner or later if any our customer enables PCIe before launching
> kernel?

I have this problem on MX6DL SabreSDP as well. Apparently, this issue happens 
more often on 6DL than it happens on 6Q. I'm clueless here.

I presume FSL won't be willing to release how the PCIe block is exactly wired 
into the GPR registers, right ? Also, I don't think there's some magic register 
which allows controlling the PCIe core and PCIe PHY reset lines directly (like 
on exynos), or is there please?

Best regards,
Marek Vasut
