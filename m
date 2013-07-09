From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Tue, 09 Jul 2013 09:18:51 +0800
Subject: v3.10 - big endian core support
In-Reply-To: <20130708170352.GA24361@mudshark.cambridge.arm.com>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
 <51DA5089.5080109@gmail.com>
 <20130708084911.GA22057@mudshark.cambridge.arm.com>
 <51DA8BBF.7080104@gmail.com>
 <20130708110202.GD22057@mudshark.cambridge.arm.com>
 <20130708170352.GA24361@mudshark.cambridge.arm.com>
Message-ID: <51DB64FB.8030208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 01:03 AM, Will Deacon wrote:
> On Mon, Jul 08, 2013 at 12:02:02PM +0100, Will Deacon wrote:
>> On Mon, Jul 08, 2013 at 10:51:59AM +0100, jgq516 at gmail.com wrote:
>>> The printascii can output before "b __enable_mmu", after move it to
>>> __mmap_switched, nothing can be printed. But if disable LPAE, printascii
>>> works again in __mmap_switched.
>> Ok, so the page tables are broken. The code is there to swap the two words,
>> but perhaps something ends up being off-by-4 or the like. I'll try and take
>> a look.
> Right, I managed to have a quick play with a 3.10 kernel and the good news
> is that the page tables are fine. The bad part is that using
> CONFIG_ARM_ATAG_DTB_COMPAT to get my command-line from ATAGs into the FDT
> results in a NULL command line, so I don't see any output. If I hardcode the
> command line in the kernel image, things work fine.
>
> What kernel are you using, and how are you passing your command line?
3.4 kernel and command line is passed from uboot, I will try 3.10 
kernel, then cherry pick
some related patches from 3.10 if 3.10 works.

Thanks,
Xiao
> Will
