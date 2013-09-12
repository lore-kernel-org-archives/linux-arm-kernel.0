From: xobs@kosagi.com (Sean Cross)
Date: Thu, 12 Sep 2013 14:55:27 +0800
Subject: [PATCH v3 3/3] PCI: imx6: Add support for i.MX6 PCIe
 controller
In-Reply-To: <0E83723C55F66F43A6041464FE31119D3CEC9F@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1378958611-4274-1-git-send-email-xobs@kosagi.com>
 <1378958611-4274-4-git-send-email-xobs@kosagi.com>
 <0E83723C55F66F43A6041464FE31119D3CEC9F@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <28FAEAE3B0A54DB68E2F060072F44EF2@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, 12 September, 2013 at 2:35 PM, Zhu Richard-R65037 wrote:
> Hi Sean Cross:
> See my comments marked by Richard.

 
> [Richard] It's better to arrange the memory layout like the following one, then the 8MB mem-space can be allocated.
> ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000 /* configuration space */
> 0x81000000 0 0 0x01f80000 0 0x00010000 /* downstream I/O */
> 0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */

Thank you.  I'll update the DT file with this new ranges. 

> +/* Read from the 16-bt PCIe PHY control registers (not memory-mapped)  
> [Richard]16-bit?

Oops.  Sloppy.  Good catch. 
> [Richard] As we know that lvds1 can be configured as input or output.
> How do you present them by the name of "lvds1_gate"?

This particular clock maps to LVDS1/2_oben and effectively acts as a gate.  Only bits 10 and 11 are exposed in clk-imx6q.c.
> + mdelay(100);
> [Richard] mdelay(100) is too long, please use usleep_range(xxx,xxx

You're right, and 100 is entirely too long to begin with.  I'll cut this value down and use a range, as suggested. 
