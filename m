From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 14:47:46 +0100
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <20110429133223.GB11885@S2100-06.ap.freescale.net>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104281925500.24613@xanadu.home>
	<20110429075346.GU17290@n2100.arm.linux.org.uk>
	<20110429133223.GB11885@S2100-06.ap.freescale.net>
Message-ID: <20110429134746.GP5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 09:32:24PM +0800, Shawn Guo wrote:
> Hi Russell,
> 
> On Fri, Apr 29, 2011 at 08:53:46AM +0100, Russell King - ARM Linux wrote:
> [...]
> > Linus wants this information _out_ of the kernel tree (remember he
> > referred to the "crazy clock files") which in his opinion should be in
> > some kind of pre-loader to the kernel and not the kernel itself.
> > Remember that this is what sparked this whole shebang in the first
> > place.
> > 
> If I understand correctly, you are suggesting put dts into bootloader
> tree.  Here are the possible problems I can see.

No, I'm talking about putting it into an entirely separate "ARM
device tree description" project.

> Also, I failed to understand how Linus could complain about getting
> dts files maintained in kernel tree, which is the thing that powerpc
> have been doing for quite some time.  As dtc is sitting in the
> kernel tree (scripts/dtc/), it's hard for me to understand why dts
> can not be put in the tree.

You need to read:

http://lists.arm.linux.org.uk/lurker/message/20110330.192132.f01e0669.en.html

and understand Linus' position on this:

   Something needs to be done. A small part is to make sure the source
   code is more hierarchical, so that we don't have those crazy shared
   data-files that are ugly as hell and get conflicts because different
   boards all think they need to care.

|| But the larger problem is that somebody really REALLY needs to think   ||
|| about how to get those crazy board details out of the kernel entirely. ||
|| Having per-board drivers for real hardware is sane - having to have    ||
|| per-board detail files for clock chips is just crazy. Split off that   ||
|| thing a "Linux ARM second-stage bootloader" project that has the       ||
|| per-board tables or something. Don't pollute the main kernel with      ||
|| crazy details like this.                                               ||

That is pretty clear to me that Linus does _not_ want these kinds of
details in the main kernel source _at_ _all_.  No matter how they're
represented, be it .c file or .dts file.
