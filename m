From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2017 16:48:08 +0000
Subject: [PATCHv2 net-next 01/16] dt-bindings: net: update Marvell PPv2
 binding for PPv2.2 support
In-Reply-To: <20170202175650.1fc06c2d@free-electrons.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170103201842.hdg2uzzesog2jund@rob-hp-laptop>
 <20170202175650.1fc06c2d@free-electrons.com>
Message-ID: <20170203164808.GD27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 05:56:50PM +0100, Thomas Petazzoni wrote:
> For PPv2.2, we wanted to simplify a little bit the register mappings,
> and simply reflect the memory map of the SoC. In the SoC datasheet,
> there are two memory areas for the networking subsystem, which are the
> two areas reflected in:
> 
>         reg = <0x0 0x100000>,
>               <0x100000 0x80000>;
> 
> The per-port registers are inside the second register area. But by
> exposing the entire register area in the Device Tree binding, we allow
> improvements in the driver that need additional registers to be made
> without changing the Device Tree description of the device.

Are you sure that this makes sense?  You have the serdes block at
0x120000-0x125fff, which sits within that range, and that needs to
be configured for SATA and PCIe, so it's not strictly just a network
thing.

I know from my experimentation that disabling the "serdes" by clearing
the SD_EXTERNAL_CONFIG1_REG and SD_EXTERNAL_CONFIG0_REG for SATA
channels prevents SATA working.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
