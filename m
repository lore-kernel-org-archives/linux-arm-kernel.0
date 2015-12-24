From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Dec 2015 11:01:09 +0000
Subject: [PATCH 05/12] tty: amba-pl011: add register lookup table
In-Reply-To: <20151224065437.GA18445@robwan01-pc.asiapac.arm.com>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNlS-0003jg-46@rmk-PC.arm.linux.org.uk>
 <20151224065437.GA18445@robwan01-pc.asiapac.arm.com>
Message-ID: <20151224110108.GD8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 06:54:40AM +0000, Huang Shijie wrote:
> On Mon, Nov 16, 2015 at 05:40:26PM +0000, Russell King wrote:
> Hi Russell,
> 
> > Add a register lookup table, which allows the register offsets to be
> > adjusted on a per-port basis.
> I met a console hang with my ARM juno-r1 board after the linux-next merge this patch.
> 
> The console hang like this:
> 
> ==================================
> on will start in   1 seconds
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from command line
> EFI stub: Exiting boot services and installing virtual address map...
> ==================================
> 
> The console runs well if I revert this patch. Does anyone also meet the
> same hang issue?

I'd guess that this is some kind of conflict between EFI patches and
this patch set - this patch is a no-op in itself when applied to the
version it was developed against.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
