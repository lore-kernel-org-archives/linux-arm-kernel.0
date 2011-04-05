From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Apr 2011 12:36:57 +0300
Subject: [PATCH] arm: omap: introduce OMAP MCOP board file
In-Reply-To: <1301995970-23699-1-git-send-email-balbi@ti.com>
References: <1301995970-23699-1-git-send-email-balbi@ti.com>
Message-ID: <20110405093656.GS2176@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 12:32:50PM +0300, Felipe Balbi wrote:
> From: Michael Fillinger <m-fillinger@ti.com>
> 
> MCOP is an FPGA-based Silicon Validation platform
> which is used to test particular IPs inside OMAP
> before we have a real ASIC.
> 
> Signed-off-by: Michael Fillinger <m-fillinger@ti.com>
> 
> [ balbi at ti.com : few cleanups here an there and also
> 	removal of some unnecessary code. ]
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

I should have RFCed this one, but bear with me for a minute.

This is just the bare minimum board-file for MCOP, there's still a bunch
of changes needed to get it actually booting. The attached diff shows
many of them.

Now, we don't want to send that patch upstream for obvious reasons and
we also don't want to add ifdefs to clock data files as that would break
multi-omap. What do you guys suggest ? How should we handle detection of
MCOP so that we choose correct HWMODs and clock data files for it ?

I don't think Linus will like if we add yet another hwmod + clk data
file just for MCOP, so we need to re-use what's in tree.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mcop_remaining.diff
Type: text/x-diff
Size: 30349 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110405/ea0208f9/attachment-0001.bin>
