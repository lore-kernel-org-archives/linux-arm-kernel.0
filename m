From: rmartinez@teltronic.es (=?iso-8859-1?Q?Ricardo_Mart=EDnez?=)
Date: Fri, 13 Nov 2009 12:32:16 +0100
Subject: ARM926 Software reset problems
Message-ID: <B3925569A02247AFA3847BB80F9342EF@teltronic.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
 
I'm trying to soft reset an ARM926EJ.
 
I'm using 
    cpu_arm926_reset(ulong address) function which:
           - flushes I/D caches
            - jumps to "address", whose value in my case is NOR flash base
address where U-Boot stays (after remapping).
 
    But it sometimes work, but most times hangs. Can this be caused by MMU
not being switched off? 
 
Any other hints?
 
If you think it might be caused by MMU, how can MMU be disabled?
 
Is there any other prefered method to soft reboot ARM926 from Linux? I've
taken a look at some PXA, OMAP & AT91 code about soft rebooting. It seems
they use Watchdog timer to reset, but my CPU does not have a watchdog.
 
Thanks in advance,
Ricardo Martinez
 
