From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 7 Apr 2014 10:45:36 -0600
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <CAFJTrDuQv87t4N1pbw_mCZ=pZ82pX6cab+PmuhO1Fvvax==xdg@mail.gmail.com>
References: <CAFJTrDt7OrtE4B52419F2KGbmXeLR9NEcgF6yMTMUBe5vdKwfg@mail.gmail.com>
 <20140326180634.4ac266b2@skate>
 <20140326171828.GA31887@obsidianresearch.com>
 <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
 <20140401164110.GA26093@obsidianresearch.com>
 <CAFJTrDu1=Hoa6NS3DaFphMUXgJYunybbdCoGiBVe1qKNQ4s3MA@mail.gmail.com>
 <20140403182322.GA9509@obsidianresearch.com>
 <20140403202455.599d1c6b@skate>
 <CAFJTrDuQv87t4N1pbw_mCZ=pZ82pX6cab+PmuhO1Fvvax==xdg@mail.gmail.com>
Message-ID: <20140407164536.GA9952@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 02:03:55PM +0100, Matthew Minter wrote:

> However I am somewhat stumped on where to look next. I am going to

Things to try:
 - Look at the PCI Interrupt Cause Register, see this message
   from Thomas and the related thread:
 http://www.spinics.net/lists/arm-kernel/msg318400.html
   Do this before and after the faulting instruction. If it doesn't
   change then the fault is generated internally to the SOC
 - diff the lspci -vv output against the non-hotplug case that works
 - Dump and verify all the mbus registers, not just through debugfs.
 - Check if the PLX has some special sequence required
   to hotplug

Cheers,
Jason
