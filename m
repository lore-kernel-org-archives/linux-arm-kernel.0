From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Tue, 8 May 2012 14:43:56 +0530
Subject: Broken UART I/O wakeups on v3.4-rc4+
In-Reply-To: <alpine.DEB.2.00.1205072249090.9984@utopia.booyaka.com>
References: <alpine.DEB.2.00.1205072249090.9984@utopia.booyaka.com>
Message-ID: <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2012 at 10:35 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Govindraj,
>
> After your commit bce492c04ba8fc66a4ea0a52b181ba255daaaf54 ("ARM: OMAP2+:
> UART: Fix incorrect population of default uart pads"), the kernel does not
> return from static suspend when off-mode is enabled upon an incoming
> serial character.
>
> The following steps reproduce the problem:
>
> echo 1 > /debug/pm_debug/enable_off_mode
> echo mem > /sys/power/state
> (send a serial character after suspend is entered)
>
> (N.B., on the BeagleBoard, the GPIO-connected "USER" button can be used to
> wake the system at this point.)
>

The same is discussed in this thread as in here:
http://www.spinics.net/lists/linux-omap/msg68659.html

> Could you please fix this? ?We probably aren't too far from the v3.5 merge
> window opening, so there isn't much time to fix it.

okay, one possible solution is to probe pins dynamically
and make rx wakeup capable which myself and Tony
discussed and came up with this patch [1]

or to add rx wakeup pad support for each board,
based on uart used as console.

--
Thanks,
Govindraj.R

[1]: http://www.spinics.net/lists/linux-omap/msg67822.html
