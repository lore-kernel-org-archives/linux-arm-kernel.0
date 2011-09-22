From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 22 Sep 2011 08:57:56 -0400 (EDT)
Subject: booting single uImage on platforms with different base addresses
	for SDRAM
In-Reply-To: <20110922111523.GM17169@n2100.arm.linux.org.uk>
References: <20110922110411.GD20444@tbergstrom-lnx.Nvidia.com>
	<20110922111523.GM17169@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1109220853460.12663@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Sep 2011, Russell King - ARM Linux wrote:

> On Thu, Sep 22, 2011 at 02:04:12PM +0300, Peter De Schrijver wrote:
> > Currently uImages have the load address hardcoded. As we now try to support
> > as many ARM platforms as possible with a single binary, this becomes a
> > problem. On tegra20 SDRAM starts at physical address 0, but on tegra30 SDRAM
> > starts at 0x80000000. It's possible to build a kernel image which can deal
> > with this, but the uImage still uses a hardcoded address. This results
> > in requiring 2 different uImages even though the zImage is the same.
> 
> This is a problem with the uImage format.  It can only be fixed in uboot
> - it's not a kernel problem.
> 
> > Has anyone thought of a solution to this problem?
> 
> There was talk about making '0' or something a special address, and
> fixing uboot to place it appropriately (in much the same way that the
> other boot loaders such as blob's offset from the start of RAM, or
> redboot's scripted loading which takes the load address.)

... or make u-Boot support plain zImage on ARM (like it apparently does 
for MIPS).  The u-Boot load command can accept a destination memory 
address just fine, but u-Boot always insists on relocating it when it is 
a uImage.


Nicolas
