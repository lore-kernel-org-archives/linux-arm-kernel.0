From: zaks_974@yahoo.com (ZAKIR AHMED)
Date: Wed, 30 Mar 2011 14:40:36 -0000
Subject: Kernel does NOT boot when loaded @ 32MB
Message-ID: <192188.82478.qm@web33203.mail.mud.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi



I am working on kexec for ARM 11 mpcore. 

I am using an ARM MPcore board with Linux 2.6.33. I need to load the kernel 

I have resolved most of the problems with the posts available. Now, I am stuck
at a place where the second kernel starts but hangs. I started debugging this
problem, by just booting the second kernel @32MB. That also does NOT boot.
Looks like, the second kernel does NOT boot @ 32MB



The following is what I have changed 

?? zreladdr-y?? := 0x02008000

params_phys-y?? := 0x02000100

initrd_phys-y?? := 0x02800000



I have also changed the PHYS_OFFSET to 0x02000000.



I have loaded the kernel at 32MB.



I used printascii as suggested to see where it hangs. I am seeing that after
turn_mmu on, it does NOT proceed to switch_data which it should ideally. If I
get the symbols using readelf and forcefully give the phys address itself of
switch_data, it proceeds till the start_kernel and then hangs in printks.



It somehow looks like, I have missed some change some where. 



Could you please let me know if I have missed some steps OR any
pointers/materials to what all needs to change when I want to load the kernel
and boot from a NON standard location?



With Regards,  Zakir Ahmed  ?  "And fear Almighty, and know that you are to meet him in the hereafter"  ?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110330/0f083127/attachment-0001.html>
