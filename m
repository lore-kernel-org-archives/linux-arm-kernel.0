From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 9 Jul 2013 17:36:06 +0200
Subject: v3.10 - big endian core support
In-Reply-To: <20130708170352.GA24361@mudshark.cambridge.arm.com>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
 <51DA5089.5080109@gmail.com>
 <20130708084911.GA22057@mudshark.cambridge.arm.com>
 <51DA8BBF.7080104@gmail.com>
 <20130708110202.GD22057@mudshark.cambridge.arm.com>
 <20130708170352.GA24361@mudshark.cambridge.arm.com>
Message-ID: <20130709173606.488fe85b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Will Deacon,

On Mon, 8 Jul 2013 18:03:53 +0100, Will Deacon wrote:
> On Mon, Jul 08, 2013 at 12:02:02PM +0100, Will Deacon wrote:
> > On Mon, Jul 08, 2013 at 10:51:59AM +0100, jgq516 at gmail.com wrote:
> > > The printascii can output before "b __enable_mmu", after move it to
> > > __mmap_switched, nothing can be printed. But if disable LPAE, printascii
> > > works again in __mmap_switched.
> > 
> > Ok, so the page tables are broken. The code is there to swap the two words,
> > but perhaps something ends up being off-by-4 or the like. I'll try and take
> > a look.
> 
> Right, I managed to have a quick play with a 3.10 kernel and the good news
> is that the page tables are fine. The bad part is that using
> CONFIG_ARM_ATAG_DTB_COMPAT to get my command-line from ATAGs into the FDT
> results in a NULL command line, so I don't see any output. If I hardcode the
> command line in the kernel image, things work fine.

Ben Dooks has a separate branch on top of this base branch for
big-endian support, that adds atags compat code to convert the ATAGs
data from LE to BE. See the baserock/311/be/atags branch in
git://git.baserock.org/delta/linux. Or
http://git.baserock.org/cgi-bin/cgit.cgi/delta/linux.git/log/?h=baserock/311/be/atags.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
