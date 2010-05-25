From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 25 May 2010 13:52:15 -0400 (EDT)
Subject: zImage works, but not vmlinux
In-Reply-To: <4BFBF015.6000008@gmail.com>
References: <4BFBF015.6000008@gmail.com>
Message-ID: <alpine.LFD.2.00.1005251346460.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 May 2010, f. achkar wrote:

> I'm newbie to arm linux, so pls if my issue is already addressed just
> point me to that reference. I'm trying to learn, but couldn't pass the
> following stage:
> I have a s3c245 based board, I have a working compressed kernel image
> zImage, this image boots properly via u-boot-1.1.6, however I simply
> failed to load (i.e., boot vmlinux) via u-boot directly from SDRAM.

The vmlinux file isn't a bootable kernel image.

If you want a non compressed kernel then try "make Image" and use the 
resulting Image file.  Then you'll have to load it at the appropriate 
location in RAM (usually 0x8000 from the start of physical memory), 
whereas zImage does relocate itself automatically.

Why don't you want to use zImage?  Given that you're using U-Boot you 
should probably use uImage instead anyway (from 'make uImage").


Nicolas
