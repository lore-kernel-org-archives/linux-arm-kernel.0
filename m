From: rmartinez@teltronic.es (=?iso-8859-1?Q?Ricardo_Mart=EDnez?=)
Date: Thu, 12 Nov 2009 20:36:32 +0100
Subject: Soft reset problems
Message-ID: <1179F41EAF7A40E79DC5B4B251AAD038@teltronic.es>
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
 
If you think it might be caused by MMU, how can be MMU disabled?
 
Is there any other prefered method to soft reboot ARM926 from Linux? I've
taken a look at some PXA, OMAP & AT91 code about soft rebooting. It seems
they use Watchdog timer to reset, but my CPU does not have a watchdog.
 
Thanks in advance,
Ricardo Martinez
 
 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091112/95626f1a/attachment-0001.htm>
