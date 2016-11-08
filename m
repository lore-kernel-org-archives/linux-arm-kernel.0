From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2016 16:06:25 +0000
Subject: [PATCH 0/8] firmware: arm_scpi: add support for legacy SCPI
 protocol
In-Reply-To: <20161108154038.GS1041@n2100.armlinux.org.uk>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <20161108145118.GR1041@n2100.armlinux.org.uk>
 <28decdc3-6b86-924f-d3c1-9873a8cfce77@arm.com>
 <20161108154038.GS1041@n2100.armlinux.org.uk>
Message-ID: <20161108160625.GU1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 03:40:38PM +0000, Russell King - ARM Linux wrote:
> As it contains a zero sized Image and .dtb files, I tried copying my
> Image and .dtb over, and also copied my original config.txt (only
> change is AUTORUN: FALSE).  It still doesn't appear to boot beyond
> this point.

Well, it seems that I can't even go back to my original set of firmware
as UEFI has stopped working:

NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v1.0(release):14b6608
NOTICE:  BL1: Built : 14:15:51, Sep  1 2014
NOTICE:  BL1: Booting BL2
NOTICE:  BL2: v1.0(release):14b6608
NOTICE:  BL2: Built : 14:15:51, Sep  1 2014
NOTICE:  BL1: Booting BL3-1
NOTICE:  BL3-1: v1.0(release):14b6608
NOTICE:  BL3-1: Built : 14:15:53, Sep  1 2014
UEFI firmware (version v2.1 built at 14:41:56 on Oct 23 2014)
Warning: Fail to load FDT file 'juno.dtb'.

and UEFI is the most unfriendly thing going - the "boot manager" thing
doesn't let you view the configuration:

[1] Linux from NOR Flash
[2] Shell
[3] Boot Manager
Start: 3
[1] Add Boot Device Entry
[2] Update Boot Device Entry
[3] Remove Boot Device Entry
[4] Reorder Boot Device Entries
[5] Update FDT path
[6] Set Boot Timeout
[7] Return to main menu
Choice:

and dropping into the shell... well, I've no idea how to get a listing
of what it thinks is in the NOR device (or even how to refer to the
NOR device.)  "devices" shows nothing that's even remotely English.

So... my Juno is now useless to me - nothing more than a paperweight,
so this is now _high_ priority.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
