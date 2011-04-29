From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 29 Apr 2011 21:32:24 +0800
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <20110429075346.GU17290@n2100.arm.linux.org.uk>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104281925500.24613@xanadu.home>
	<20110429075346.GU17290@n2100.arm.linux.org.uk>
Message-ID: <20110429133223.GB11885@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Apr 29, 2011 at 08:53:46AM +0100, Russell King - ARM Linux wrote:
[...]
> Linus wants this information _out_ of the kernel tree (remember he
> referred to the "crazy clock files") which in his opinion should be in
> some kind of pre-loader to the kernel and not the kernel itself.
> Remember that this is what sparked this whole shebang in the first
> place.
> 
If I understand correctly, you are suggesting put dts into bootloader
tree.  Here are the possible problems I can see.

* Thought u-boot is the most popular bootloader, it's not the only
  option.  Some platforms sitting on mainline does not use it, e.g.
  mach-mxs.  That means the dts file for the same platform has to
  get maintained in various bootloader tree.

* Maintaining dts file in bootloader tree will get kernel depend on
  bootloader so heavily.  The kernel code and dts file will easily
  get out of sync, which may stop kernel booting immediately.

Also, I failed to understand how Linus could complain about getting
dts files maintained in kernel tree, which is the thing that powerpc
have been doing for quite some time.  As dtc is sitting in the
kernel tree (scripts/dtc/), it's hard for me to understand why dts
can not be put in the tree.

-- 
Regards,
Shawn
