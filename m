From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 18 Apr 2014 12:48:23 -0500
Subject: Perf top always show 0.00
In-Reply-To: <CAHrpEqQZ_0G-rmwfaeEzHOFVckyRRSUpYrPdMUgPjRZ1JYyy6g@mail.gmail.com>
References: <CAHrpEqQZ_0G-rmwfaeEzHOFVckyRRSUpYrPdMUgPjRZ1JYyy6g@mail.gmail.com>
Message-ID: <53516567.10405@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2014 12:00 PM, Frank Li wrote:
> I use mx6dq platform. Found below problem.
> 
> Run Perf top. First column always 0, but order look like correct.
> 
>    0.00%  perf          [.] 0x00049420
>      0.00%  [kernel]      [k] kallsyms_expand_symbol.constprop.5
>      0.00%  [kernel]      [k] vsnprintf
>      0.00%  [kernel]      [k] arch_cpu_idle
>      0.00%  [kernel]      [k] format_decode
>      0.00%  [kernel]      [k] number.isra.2
>      0.00%  libc-2.19.so  [.] strstr
>      0.00%  libc-2.19.so  [.] 0x00072498
>      0.00%  libc-2.19.so  [.] memchr
>      0.00%  [kernel]      [k] _raw_spin_unlock_irqrestore
>      0.00%  [kernel]      [k] string.isra.4
>      0.00%  [kernel]      [k] strnlen
>      0.00%  libc-2.19.so  [.] getdelim
>      0.00%  libc-2.19.so  [.] memcpy
>      0.00%  [kernel]      [k] lock_acquire
>      0.00%  libc-2.19.so  [.] strchr
>      0.00%  libc-2.19.so  [.] strcmp
>      0.00%  [kernel]      [k] _raw_spin_unlock_irq
>      0.00%  libc-2.19.so  [.] __libc_calloc
>      0.00%  libc-2.19.so  [.] _IO_feof
>      0.00%  [kernel]      [k] pointer.isra.15

The PMU is possibly worthless:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113802.html

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/151945.html
