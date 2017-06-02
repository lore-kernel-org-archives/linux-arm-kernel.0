From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jun 2017 21:01:50 +0100
Subject: Need help booting allmodconfig on arm64
In-Reply-To: <0dd92218-037d-3d1f-7b3c-10adbc3bc832@codeaurora.org>
References: <CAOZdJXUr6wAE5CZBzmADOAVBGL692FVzaaGwaC7hzJ7GtJmxtA@mail.gmail.com>
 <20170601225012.GI22219@n2100.armlinux.org.uk>
 <031b1119-6366-c41f-bf65-01561583ef41@codeaurora.org>
 <20170602083615.GA28299@leverpostej>
 <0dd92218-037d-3d1f-7b3c-10adbc3bc832@codeaurora.org>
Message-ID: <20170602200150.GA4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 08:50:08AM -0500, Timur Tabi wrote:
> On 6/2/17 3:36 AM, Mark Rutland wrote:
> >CONFIG_SATA_AHCI=m
> >CONFIG_SATA_AHCI_PLATFORM=m
> 
> Ah, I had to set CONFIG_ATA=y for those two lines to take. Unfortunately,
> even with this fix, there still aren't any /dev/sdX entries.
> 
> I pasted by /dev tree to https://pastebin.com/3najnguB and my dmesg to
> https://pastebin.com/EvFEJJth.
> 
> You can see the SATA driver loading and probing, isn't that enough to create
> the /dev entries?

ATA devices appear via the SCSI layer, which means you need the SCSI disk
driver, CONFIG_BLK_DEV_SD, for ATA disks to be visible as block devices.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
