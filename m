From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 3 Apr 2014 20:24:55 +0200
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <20140403182322.GA9509@obsidianresearch.com>
References: <CAFJTrDt7OrtE4B52419F2KGbmXeLR9NEcgF6yMTMUBe5vdKwfg@mail.gmail.com>
 <20140326180634.4ac266b2@skate>
 <20140326171828.GA31887@obsidianresearch.com>
 <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
 <20140401164110.GA26093@obsidianresearch.com>
 <CAFJTrDu1=Hoa6NS3DaFphMUXgJYunybbdCoGiBVe1qKNQ4s3MA@mail.gmail.com>
 <20140403182322.GA9509@obsidianresearch.com>
Message-ID: <20140403202455.599d1c6b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 3 Apr 2014 12:23:22 -0600, Jason Gunthorpe wrote:

> Your oops seem to suggest that the very first MMIO read from the AHCI
> is causing this:
> 
> > [? 191.654496] Unhandled fault: external abort on non-linefetch
> > (0x1008) at 0xf0460004
> 
> And the address 0xf0460004 is certainly funny - that doesn't look like
> it is valid at all, but prehaps it is a bogus report (?) 

Notice that the address reported by the Unhandled fault message is a
*virtual* address, not a *physical* address. So you have to look to
what physical address it corresponds to draw some conclusions, I
believe.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
