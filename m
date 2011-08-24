From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Aug 2011 22:43:11 +0100
Subject: MX53Loco reports half of the total memory
In-Reply-To: <20110824205415.GN31404@pengutronix.de>
References: <CAOMZO5C6gaJUD3RTCwGqDhcojx3Thww22c+tsdC4bvTUmiSw6w@mail.gmail.com>
	<20110824205415.GN31404@pengutronix.de>
Message-ID: <20110824214311.GA21759@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 10:54:16PM +0200, Sascha Hauer wrote:
> On Wed, Aug 24, 2011 at 05:30:54PM -0300, Fabio Estevam wrote:
> > Hi,
> > 
> > On a mx53loco board U-boot reports 1GB of total available memory:
> > 
> > 
> > U-Boot 2011.06-04814-geee1e2f (Aug 22 2011 - 13:37:53)
> > 
> > CPU:   Freescale i.MX53 family rev2.1 at 800 MHz
> > Reset cause: POR
> > Board: MX53 LOCO
> > DRAM:  1 GiB
> > MMC:   FSL_ESDHC: 0, FSL_ESDHC: 1
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Net:   got MAC address from fuse: 00:04:9f:01:c6:57
> > FEC
> > Hit any key to stop autoboot:  0
> > MX53LOCO U-Boot >
> > 
> > When booting 3.1-rc3 only 512MB is reported:
> > ...
> 
> You probably missed the following in your boot log:
> 
> Ignoring RAM at b0000000-cfffffff (vmalloc region overlap).
> 
> > ...
> > Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> > Memory: 512MB = 512MB total
> > Memory: 515420k/515420k available, 8868k reserved, 0K highmem
> > Virtual kernel memory layout:
> > ...
> > 
> > Shouldn't the kernel report the whole 1GB?
> 
> Try compiling the kernel with CONFIG_VMSPLIT_2G. On my board this gives:

Or enable highmem.
