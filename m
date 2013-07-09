From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Jul 2013 08:45:54 +0100
Subject: v3.10 - big endian core support
In-Reply-To: <51DB84D5.3000700@gmail.com>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
 <51DA5089.5080109@gmail.com>
 <20130708084911.GA22057@mudshark.cambridge.arm.com>
 <51DA8BBF.7080104@gmail.com>
 <20130708110202.GD22057@mudshark.cambridge.arm.com>
 <20130708170352.GA24361@mudshark.cambridge.arm.com>
 <51DB64FB.8030208@gmail.com> <51DB84D5.3000700@gmail.com>
Message-ID: <20130709074553.GA25885@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 04:34:45AM +0100, jgq516 at gmail.com wrote:
> On 07/09/2013 09:18 AM, jgq516 at gmail.com wrote:
> > On 07/09/2013 01:03 AM, Will Deacon wrote:
> >> On Mon, Jul 08, 2013 at 12:02:02PM +0100, Will Deacon wrote:
> >>> On Mon, Jul 08, 2013 at 10:51:59AM +0100, jgq516 at gmail.com wrote:
> >>>> The printascii can output before "b __enable_mmu", after move it to
> >>>> __mmap_switched, nothing can be printed. But if disable LPAE, 
> >>>> printascii
> >>>> works again in __mmap_switched.
> >>> Ok, so the page tables are broken. The code is there to swap the two 
> >>> words,
> >>> but perhaps something ends up being off-by-4 or the like. I'll try 
> >>> and take
> >>> a look.
> >> Right, I managed to have a quick play with a 3.10 kernel and the good 
> >> news
> >> is that the page tables are fine. The bad part is that using
> >> CONFIG_ARM_ATAG_DTB_COMPAT to get my command-line from ATAGs into the 
> >> FDT
> >> results in a NULL command line, so I don't see any output. If I 
> >> hardcode the
> >> command line in the kernel image, things work fine.
> >>
> Hi Will,
> 
> Which kernel tree are you used? I tried latest mainline kernel (used 
> vexpress_defconfig
> and vexpress-v2p-ca15_a7.dtb) without any modification, but it hangs as 
> follows.

Just try 3.10 at the moment -- we're currently in the middle of the merge
window and I know that there is some timer breakage that people have been
talking about.

Will
