From: rmartinez@teltronic.es (=?iso-8859-1?Q?Ricardo_Mart=EDnez?=)
Date: Fri, 13 Nov 2009 09:30:27 +0100
Subject: Linux on ARM926EJ: Software reset problems
Message-ID: <56948FFAC219492B8923C0852A8AC413@teltronic.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
 
I'm trying to soft reset an ARM926EJ.
 
I'm using 
    cpu_arm926_reset(ulong address) function which:
           - flushes I/D caches
            - jumps to "address", whose value in my case is NOR flash base
addres where U-Boot stays (after remapping).
 
    But it sometimes work, but most times hangs. Can this be caused by MMU
not being switched off? 
 
Any other hints?
 
If you think it might be caused by MMU, how can MMU be disabled?
 
Is there any other prefered method to soft reboot ARM926 from Linux? I've
taken a look at some PXA, OMAP & AT91 code about soft rebooting. It seems
they use Watchdog timer to reset, but my CPU does not have a watchdog.
 
Thanks in advance,
Ricardo Martinez
 
 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091113/ed82aa81/attachment-0001.htm>
