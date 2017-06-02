From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 2 Jun 2017 08:50:08 -0500
Subject: Need help booting allmodconfig on arm64
In-Reply-To: <20170602083615.GA28299@leverpostej>
References: <CAOZdJXUr6wAE5CZBzmADOAVBGL692FVzaaGwaC7hzJ7GtJmxtA@mail.gmail.com>
 <20170601225012.GI22219@n2100.armlinux.org.uk>
 <031b1119-6366-c41f-bf65-01561583ef41@codeaurora.org>
 <20170602083615.GA28299@leverpostej>
Message-ID: <0dd92218-037d-3d1f-7b3c-10adbc3bc832@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/2/17 3:36 AM, Mark Rutland wrote:
> CONFIG_SATA_AHCI=m
> CONFIG_SATA_AHCI_PLATFORM=m

Ah, I had to set CONFIG_ATA=y for those two lines to take. 
Unfortunately, even with this fix, there still aren't any /dev/sdX 
entries.

I pasted by /dev tree to https://pastebin.com/3najnguB and my dmesg to 
https://pastebin.com/EvFEJJth.

You can see the SATA driver loading and probing, isn't that enough to 
create the /dev entries?

When my /init script runs, I think it's trying to mount the SATA drive:

Begin: Waiting for root file system ... Begin: Running 
/scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.

(this repeats for another minute).

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
