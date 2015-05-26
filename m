From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Tue, 26 May 2015 16:13:03 +0300
Subject: [PATCH] ARM64: kasan: print memory assignment
In-Reply-To: <1432632464-12248-1-git-send-email-linus.walleij@linaro.org>
References: <1432632464-12248-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5564715F.8000209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2015 12:27 PM, Linus Walleij wrote:
> This prints out the virtual memory assigned to KASan in the
> boot crawl along with other memory assignments, if and only
> if KASan is activated.
> 
> Example dmesg from the Juno Development board:
> 
> Memory: 1691156K/2080768K available (5465K kernel code, 444K rwdata,
> 2160K rodata, 340K init, 217K bss, 373228K reserved, 16384K cma-reserved)
> Virtual kernel memory layout:
>     kasan   : 0xffffff8000000000 - 0xffffff9000000000   (    64 MB)
>     vmalloc : 0xffffff9000000000 - 0xffffffbdbfff0000   (   182 GB)
>     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
>               0xffffffbdc2000000 - 0xffffffbdc3fc0000   (    31 MB actual)
>     fixed   : 0xffffffbffabfd000 - 0xffffffbffac00000   (    12 KB)
>     PCI I/O : 0xffffffbffae00000 - 0xffffffbffbe00000   (    16 MB)
>     modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)
>     memory  : 0xffffffc000000000 - 0xffffffc07f000000   (  2032 MB)
>       .init : 0xffffffc0007f5000 - 0xffffffc00084a000   (   340 KB)
>       .text : 0xffffffc000080000 - 0xffffffc0007f45b4   (  7634 KB)
>       .data : 0xffffffc000850000 - 0xffffffc0008bf200   (   445 KB)
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Done on top of Andrey's patch set obviously.
> 
> Andrey: do what you want with this, I think it's kinda nice,
> you can harvest this patch for your patch series if you like,
> or squash into the ARM64 enablement patch, I have no preference.

Thanks. I'll fix s/MB/GB and grab it.
