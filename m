From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 13:12:03 -0700
Subject: Broken UART I/O wakeups on v3.4-rc4+
In-Reply-To: <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
References: <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
Message-ID: <20120508201203.GE5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Raja, Govindraj <govindraj.raja@ti.com> [120508 02:17]:
> On Tue, May 8, 2012 at 10:35 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > Govindraj,
> >
> > After your commit bce492c04ba8fc66a4ea0a52b181ba255daaaf54 ("ARM: OMAP2+:
> > UART: Fix incorrect population of default uart pads"), the kernel does not
> > return from static suspend when off-mode is enabled upon an incoming
> > serial character.
> >
> > The following steps reproduce the problem:
> >
> > echo 1 > /debug/pm_debug/enable_off_mode
> > echo mem > /sys/power/state
> > (send a serial character after suspend is entered)
> >
> > (N.B., on the BeagleBoard, the GPIO-connected "USER" button can be used to
> > wake the system at this point.)
> >
> 
> The same is discussed in this thread as in here:
> http://www.spinics.net/lists/linux-omap/msg68659.html
> 
> > Could you please fix this? ?We probably aren't too far from the v3.5 merge
> > window opening, so there isn't much time to fix it.
> 
> okay, one possible solution is to probe pins dynamically
> and make rx wakeup capable which myself and Tony
> discussed and came up with this patch [1]

This would be good for the v3.5 merge window.
 
> or to add rx wakeup pad support for each board,
> based on uart used as console.

This should be still done too to avoid bootloader dependency
for setting up the serial ports.

Regards,

Tony
 
> [1]: http://www.spinics.net/lists/linux-omap/msg67822.html
