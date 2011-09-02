From: marvin24@gmx.de (Marc Dietich)
Date: Fri, 2 Sep 2011 13:13:37 +0200
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B327A383@HQMAIL01.nvidia.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<201109011313.42547.marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04B327A383@HQMAIL01.nvidia.com>
Message-ID: <201109021313.38224.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

just another measurement point

> Stephen Warren wrote at Thursday:
>
> Here are the results I found:
> 
> Harmony:
> Tegra USB3 -> SMSC9514 hub: NOT affected
> (Unplugging LAN cable, or disabling SMSC9514 LAN driver doesn't change
> this)
> 
> Seaboard (springbank; clamshell):
> Tegra USB1 -> no hub: Affected
> 
> Seaboard (seaboard non-clamshell):
> Tegra USB1 -> no hub: Affected
> Tegra USB3 -> no hub: Affected
> 
> TrimSlice:
> Tegra USB3 -> unknown hub: Affected

PAZ00:
ULPI -> SMCS 2512: Affected
Tegra USB3 -> SMSC 2514: Affected

The patch also cures high latencies/packet drops on wifi connected to ULPI via 
the 2512 hub. The pen drive was connected to USB3/2514.

> This implies there's something different about Harmony.
> 
> Is the USB hub a clue? Seaboard doesn't have one, and although I don't
> know what model TrimSlice uses, I assume it's different since I know
> TrimSlice's Ethernet is not the same as Harmony's.
> 
> I don't see anything in board-harmony.c vs. board-seaboard.c that'd affect
> anything USB-related.
> 
> Perhaps there's some kind of bootloader or BCT difference. However, my
> Harmony and both Seaboards both use (a very old) U-Boot and BCT from
> ChromeOS, so I don't imagine there's actually much difference there.
