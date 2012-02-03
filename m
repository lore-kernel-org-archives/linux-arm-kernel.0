From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 3 Feb 2012 13:34:43 -0700 (MST)
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <alpine.DEB.2.00.1202031243270.27947@utopia.booyaka.com>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
 <20120126042155.GA3185@suse.de>
 <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
 <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
 <20120203205401.5ddf241d@notabene.brown>
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <20120203231113.25ae2d3a@notabene.brown>
 <alpine.DEB.2.00.1202031243270.27947@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1202031332540.27947@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012, Paul Walmsley wrote:

> 2. CORE & PER powerdomains are awakened

Incidentally, there might be a missing clkdm_add_wakeup() in 
mach-omap2/pm34xx.c to wake up PER when CORE is awakened.  For people who 
are seeing some input character corruption when CORE/PER enters a 
low-power state, that might be worth experimenting with.


- Paul
