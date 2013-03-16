From: lukas-x@zapletalovi.com (Lukas Zapletal)
Date: Sat, 16 Mar 2013 20:48:13 +0000 (UTC)
Subject: Kirkwood NSA 310 does not boot with 3.8.3
Message-ID: <loom.20130316T213930-150@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I have noticed that in the latest stable (3.8) kernels, support for NSA 310 
(Marwell based NAS) has been added.

I tried to boot a kernel with Marwell DT and NSA310 enabled and it can't boot up 
with strange error:

<snip>
## Booting image at 00800000 ...
   Image Name:   Linux-3.8.3
   Created:      2013-03-16  20:35:06 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3646704 Bytes =  3.5 MB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.

Error: unrecognized/unsupported machine ID (r1 = 0x00000d0b).
                                                             
Available machine support:
                          
ID (hex)        NAME
ffffffff        Marvell Kirkwood (Flattened Device Tree)
                                                        
Please check your kernel config and/or bootloader.
</snip>

Particularly, I dont understand the ID code - it really does not look right. 
This is vanilla 3.8.3. Is there an ARM-dedicated git branch I should rather use 
for early support for NSA310?

Here is my full kernel config: 
http://lzap.fedorapeople.org/patches/nsa310/config-3.8.3-vanilla-no-boot

I hope this is the right mailing list to ask, I apologize otherwise.
