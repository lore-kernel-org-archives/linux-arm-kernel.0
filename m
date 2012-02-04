From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 4 Feb 2012 09:55:49 -0700 (MST)
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <alpine.DEB.2.00.1202040943450.9453@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
 <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
 <20120203205401.5ddf241d@notabene.brown>
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
 <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
 <20120204163931.GH1275@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1202040943450.9453@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1202040952250.9453@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 4 Feb 2012, Paul Walmsley wrote:

> The default behavior needs to be what you state: to not lose characters.  
> And indeed that is what it is in v3.3: the UART will not enter idle when 
> the PM runtime autosuspend timeout is -1.  

One technical correction on this section -- rather, the CORE* clockdomains 
will not be allowed to go idle when the PM runtime autosuspend timeout is 
-1.  And that is what causes the character loss.  The rest of the E-mail 
stands.

The question of whether the UART should be allowed to enter idle is a 
different one, since the current driver is not properly working in this 
regard, which is why we're not getting RX timeout events, etc.  We should 
be able to have the proper RX timeout behavior, and therefore use normal 
FIFO thresholds, by fixing some of the bugs in the existing driver.


- Paul
