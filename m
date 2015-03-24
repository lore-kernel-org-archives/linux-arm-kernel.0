From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Mar 2015 11:23:45 -0400 (EDT)
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <CAKv+Gu_N7rcLev33pM6VKEBH0ospZZJLDRrVYCo6OUo3HqK-vA@mail.gmail.com>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <20150324135439.GC3579@e103592.cambridge.arm.com>
 <CAKv+Gu_N7rcLev33pM6VKEBH0ospZZJLDRrVYCo6OUo3HqK-vA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1503241119110.27567@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Mar 2015, Ard Biesheuvel wrote:

> On 24 March 2015 at 14:54, Dave Martin <Dave.Martin@arm.com> wrote:
> > How big is your kernel?  It would be good to compare the veneer
> > count with a more normal-sized kernel.
> >
> 
> With all my patches applied, I can actually build allyesconfig which
> produces a 74 MB zImage. But this is obviously never going to be able
> to execute with the usual policy of placing zImage around 32 MB into
> DRAM, and expecting it to be able to decompress.

It should work nevertheless.  zImage knows the size of the decompressed 
kernel and will figure out that it needs to relocate itself above the 
final kernel area first.  It might overwrite your DTB and initrd in the 
process if they're not sufficiently high in memory though.


Nicolas
