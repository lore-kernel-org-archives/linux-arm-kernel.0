From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Nov 2018 14:06:27 +0000
Subject: [BUG] Is "mem=" kernel command line parameter broken on ARM?
In-Reply-To: <20181116133236.GA27819@picapica.im>
References: <20181116133236.GA27819@picapica.im>
Message-ID: <20181116140627.GW30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 02:32:36PM +0100, Anton wrote:
> Hello
> 
> 
> I am trying to boot Linux on a custom board having SAMA5D21 chip.
> It has 64MiB of DRAM. So I thought it was a good idea to pass amount
> of physical memory available through command line parameter "mem=64M".

mem specifies not only the amount of memory, but also its location.
mem=64M tells the kernel that there is 64M at physical address zero.
Your device may not have memory at physical address zero, so that
will cause the kernel to try to use something that isn't RAM as
memory.

My guess is that memory starts at 0x20000000 on your platform based
on what you've provided in uboot, but I can't be certain.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
