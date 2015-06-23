From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jun 2015 17:48:51 -0300
Subject: mx6 hdmi resolution behaviour
In-Reply-To: <20150623204154.GD7557@n2100.arm.linux.org.uk>
References: <CAOMZO5AbC8PCo7J7ovw4izPBK08UkDgKGG++d+9xty4GJ0SzKQ@mail.gmail.com>
 <20150623164443.GC7557@n2100.arm.linux.org.uk>
 <CAOMZO5BjuOGgqsUNG6K6N-QU1a4oWTdynxsoAECYLeQK_9Kk9g@mail.gmail.com>
 <20150623204154.GD7557@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5CkxjtH7ZnOcbDWdwwwHH4xT4UhXXWpA3O9afbP9XRBaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 5:41 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> I've just tried this (the HBi1 was booted previously with the HDMI socket
> disconnected).  Just now, I turned the TV on, and then connected it to
> the HDMI.

Thanks for testing it.

> The TV reported a resolution of 1024x768, and the kernel log was silent.

That's the point that makes me confused: shouldn't it report a higher
resolution like 1080p?

Why only 1024x768 even if the monitor supports higher resolution?

If we boot with the cable connected then it jumps to 1080.

> My guess would be that your HDMI sink is reporting slightly non-standard
> 1024x768 timings, which cause the IPU restrictions to be violated.  Maybe
> dumping the EDID of the HDMI device would reveal this?
>
> # edid-decode < /sys/class/drm/card0-HDMI-A-1/edid
>
> might provide some hints?

Thanks, will try it. Need to install this edid package in my rootfs.
