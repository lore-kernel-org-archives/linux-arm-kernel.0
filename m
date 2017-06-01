From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 1 Jun 2017 16:54:33 -0700
Subject: Need help booting allmodconfig on arm64
In-Reply-To: <031b1119-6366-c41f-bf65-01561583ef41@codeaurora.org>
References: <CAOZdJXUr6wAE5CZBzmADOAVBGL692FVzaaGwaC7hzJ7GtJmxtA@mail.gmail.com>
 <20170601225012.GI22219@n2100.armlinux.org.uk>
 <031b1119-6366-c41f-bf65-01561583ef41@codeaurora.org>
Message-ID: <54dae699-cc9d-2c3c-fb81-5e250a51c7f4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2017 04:26 PM, Timur Tabi wrote:
> On 06/01/2017 05:50 PM, Russell King - ARM Linux wrote:
>>>
>>> It boots to my initramfs, but not my SATA rootfs.  I think the problem
>>> is that /init is a shell script, and there's no interpreter?
>> Have you checked that BINFMT_SCRIPT is not modular?
> 
> That helped, thanks.
> 
> Now I don't have any /dev/sdX entries, so I can't mount my SATA drive.
> I'm trying to parse the initramfs disks, but I don't know what to look
> for.  How do the /dev/sdX entries normally appear?

What happens when you enable CONFIG_DEVTMPFS and CONFIG_DEVTMPFS_MOUNT?
-- 
Florian
