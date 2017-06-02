From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Jun 2017 09:36:15 +0100
Subject: Need help booting allmodconfig on arm64
In-Reply-To: <031b1119-6366-c41f-bf65-01561583ef41@codeaurora.org>
References: <CAOZdJXUr6wAE5CZBzmADOAVBGL692FVzaaGwaC7hzJ7GtJmxtA@mail.gmail.com>
 <20170601225012.GI22219@n2100.armlinux.org.uk>
 <031b1119-6366-c41f-bf65-01561583ef41@codeaurora.org>
Message-ID: <20170602083615.GA28299@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 06:26:34PM -0500, Timur Tabi wrote:
> On 06/01/2017 05:50 PM, Russell King - ARM Linux wrote:
> >>
> >>It boots to my initramfs, but not my SATA rootfs.  I think the problem
> >>is that /init is a shell script, and there's no interpreter?
> >Have you checked that BINFMT_SCRIPT is not modular?
> 
> That helped, thanks.
> 
> Now I don't have any /dev/sdX entries, so I can't mount my SATA
> drive. I'm trying to parse the initramfs disks, but I don't know
> what to look for.  How do the /dev/sdX entries normally appear?

Do you laod the relevant drivers in your initramfs?

Per the commadns you gave, the SATA driver would be modular in your config:

CONFIG_SATA_AHCI=m
CONFIG_SATA_AHCI_PLATFORM=m

Thanks,
Mark.
