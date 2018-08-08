From: mpatocka@redhat.com (Mikulas Patocka)
Date: Wed, 8 Aug 2018 15:15:59 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu8384LZwL898wJ8BKjmJNzvd+-cSFUp4X4OpfmRDCP4Ng@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
 <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com>
 <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu87YqLM=FFZ6V8rHhuhskDdsBUuXFpqNKVbXWqdnuNEyA@mail.gmail.com>
 <alpine.LRH.2.02.1808060639200.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8HyHX8qjg1qHV2M9Re+RGQJigjdAFVC_yR4niGkk2ikA@mail.gmail.com>
 <alpine.LRH.2.02.1808060700070.10220@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8384LZwL898wJ8BKjmJNzvd+-cSFUp4X4OpfmRDCP4Ng@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808081514140.2447@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 6 Aug 2018, Ard Biesheuvel wrote:

> No that works fine for me. VDPAU acceleration works as well, but it
> depends on your chromium build whether it can actually use it, I
> think? In any case, mplayer can use vdpau to play 1080p h264 without
> breaking a sweat on this system.

I didn't install the vdpau libraries and firmware. mplayer plays through 
xv and works (it can't play through vdpau). Chromium uses 
I-don't-know-what and locks up.

> Note that the VDPAU driver also relies on memory semantics, i.e., it
> may use DC ZVA (zero cacheline) instructions which are not permitted
> on device mappings. This is probably just glibc's memset() being
> invoked, but I remember hitting this on another PCIe-impaired arm64
> system with Synopsys PCIe IP

> Are you setting the pstate to auto? That helps a lot in my experience.
>
> I.e.,
>
> echo auto > /sys/kernel/debug/dri/0/pstate

I tried that, but it didn't help.

Mikulas
