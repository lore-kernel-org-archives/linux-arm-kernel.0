From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 1 Feb 2010 22:27:27 +0800
Subject: About kernel decompressors (fwd)
In-Reply-To: <20100201121454.GA20387@atrey.karlin.mff.cuni.cz>
References: <20100201121454.GA20387@atrey.karlin.mff.cuni.cz>
Message-ID: <f17812d71002010627u795ff155l62c96bf64240b584@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It sounds to me like this is because of the 1.4M (cannot
remember the exact size) constraint of the kernel size
on NAND that the bootloader is able to load?

On Mon, Feb 1, 2010 at 8:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I guess Andrea wanted me ?to forward this....
>
> ----- Forwarded message from Andrea Adami <andrea.adami@gmail.com> -----
> Date: Mon, 1 Feb 2010 13:08:44 +0100
> From: Andrea Adami <andrea.adami@gmail.com>
> To: pavel at ucw.cz
> Subject: About kernel decompressors
>
> Pavel,
>
> I'd like to add a couple of observations in the "Uncompressing broken
> with commit e7db7b4270" thread.
> Unfortunately I wasn't subscribed and I can't properly reply to the thread...
>
> This is for kernels 2.6.33-rc5 and -rc6 on Sharp corgi (Zaurus
> SL-C860, pxa255, 64M RAM)
>
> 1) after that commit neither gzip, nor lzo can decompress from NAND
> 2) I tested the LZMA patch and this also won't help the boot from nand
> 3) kernel size is uninfluent: I tested 930KiB-lzma kernels and 1240KiB
> gzip-kernels.
> 4) I tried to set stack size to 8192, still no boot
>
> 5) all the 3 above kernels boot just fine from kexec (I launch them
> with linux-kexecboot-2.6.26)
>
> >From nand, the boot stops immediately after
> **** JUMP to LINUX! ****
>
>
> Cheers
>
> Andrea
>
> ----- End forwarded message -----
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
