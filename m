From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Nov 2015 08:32:34 +0000
Subject: [PATCH] ARM: proc-v7: Put stack in data section, handle XIP case
In-Reply-To: <20151106075319.19378.64286.sendpatchset@little-apple>
References: <20151106075319.19378.64286.sendpatchset@little-apple>
Message-ID: <20151106083233.GS8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 04:53:19PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Adjust the ARM v7 setup code to put the temporary stack in the
> data section and also use PLAT_PHYS_OFFSET to handle the XIP case.
> 
> The common case of XIP=n the code is considered to be position
> independent while for XIP=y PLAT_PHYS_OFFSET is fixed. This
> is based on that early code in head.S invoking PROCINFO_INITFUNC
> seems position independent.
> 
> At this point two places in proc-v7.S make use of the temporary
> stack so the PLAT_PHYS_OFFSET calculation is duplicated.
> 
> The XIP=n case has been tested with CPU Hotplug on r8a7779
> (Cortex A9 Quad) and Chris [CCed] has tested the XIP=y
> case.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Tested-by: Chris.Brandt at renesas.com

Sorry, but what's the problem with XIP=n ?  The above seems to avoid
describing what the problem is there, but it spends an awful lot of
words describing the XIP=n scenario and few describing the XIP=y
scenario.

I think the commit message needs improving.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
