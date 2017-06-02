From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Jun 2017 00:10:06 +0100
Subject: Need help booting allmodconfig on arm64
In-Reply-To: <8fca2513-759d-3747-63f1-cd7d11b34ec2@codeaurora.org>
References: <CAOZdJXUr6wAE5CZBzmADOAVBGL692FVzaaGwaC7hzJ7GtJmxtA@mail.gmail.com>
 <20170601225012.GI22219@n2100.armlinux.org.uk>
 <031b1119-6366-c41f-bf65-01561583ef41@codeaurora.org>
 <20170602083615.GA28299@leverpostej>
 <0dd92218-037d-3d1f-7b3c-10adbc3bc832@codeaurora.org>
 <20170602200150.GA4902@n2100.armlinux.org.uk>
 <8fca2513-759d-3747-63f1-cd7d11b34ec2@codeaurora.org>
Message-ID: <20170602231006.GC4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 06:01:55PM -0500, Timur Tabi wrote:
> On 06/02/2017 03:01 PM, Russell King - ARM Linux wrote:
> >ATA devices appear via the SCSI layer, which means you need the SCSI disk
> >driver, CONFIG_BLK_DEV_SD, for ATA disks to be visible as block devices.
> 
> Great, that fixed that problem.
> 
> I also had to set CONFIG_UNIX=y and CONFIG_AUTOFS4_FS=y so that udev would
> start, but it's still not quite 100% there.  lsmod still shows no drivers
> being loaded.  All of the modules were copied on the initramfs, why aren't
> they being loaded?
> 
> A couple boot log messages stand out:
> 
> [ TIME ] Timed out waiting for device
> dev-disk-by\x2duuid-AB6C\x2d1CCA.device.
> [DEPEND] Dependency failed for /boot/efi.
> [DEPEND] Dependency failed for Local File Systems.

Sounds like systemd?  Systemd has a list of requirements that it makes
of the kernel, I guess you're missing some of those requirements.
Check the systemd docs (/usr/share/doc/systemd/README ?) under
"REQUIREMENTS".

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
