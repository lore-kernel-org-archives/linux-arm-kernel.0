From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Mar 2013 17:55:30 -0400
Subject: Kirkwood NSA 310 does not boot with 3.8.3
In-Reply-To: <loom.20130316T213930-150@post.gmane.org>
References: <loom.20130316T213930-150@post.gmane.org>
Message-ID: <20130316215530.GZ12700@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 16, 2013 at 08:48:13PM +0000, Lukas Zapletal wrote:
> Hello all,
> 
> I have noticed that in the latest stable (3.8) kernels, support for NSA 310 
> (Marwell based NAS) has been added.
> 
> I tried to boot a kernel with Marwell DT and NSA310 enabled and it can't boot up 
> with strange error:
> 
> <snip>
> ## Booting image at 00800000 ...
>    Image Name:   Linux-3.8.3
>    Created:      2013-03-16  20:35:06 UTC
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3646704 Bytes =  3.5 MB
>    Load Address: 00008000
>    Entry Point:  00008000
>    Verifying Checksum ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> 
> Error: unrecognized/unsupported machine ID (r1 = 0x00000d0b).

Your bootloader doesn't support devicetree.

> Here is my full kernel config: 
> http://lzap.fedorapeople.org/patches/nsa310/config-3.8.3-vanilla-no-boot

You'll need to enable ARM_APPENDED_DTB, concatenate your dtb onto your
zImage, then run mkimage on the result to get the uImage.

thx,

Jason.
