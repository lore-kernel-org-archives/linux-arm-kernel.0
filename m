From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Aug 2014 16:12:44 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140829070116.GC13106@ulmo>
References: <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <53FDE0CE.5030807@redhat.com> <20140827141632.GB32243@ulmo>
 <53FF1D6C.6090205@redhat.com> <20140829070116.GC13106@ulmo>
Message-ID: <20140829141244.GH15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 09:01:17AM +0200, Thierry Reding wrote:
> I would think the memory should still be reserved anyway to make sure
> nothing else is writing over it. And it's in the device tree anyway
> because the driver needs to know where to put framebuffer content. So
> the point I was trying to make is that we can't treat the memory in the
> same way as clocks because it needs to be explicitly managed. Whereas
> clocks don't. The driver is simply too generic to know what to do with
> the clocks.

You agreed on the fact that the only thing we need to do with the
clocks is claim them. Really, I don't find what's complicated there
(or not generic).

> It doesn't know what frequency they should be running at

We don't care about that. Just like we don't care about which
frequency is the memory bus running at. It will just run at whatever
frequency is appropriate.

> or what they're used for

And we don't care about that either. You're not interested in what
output the framebuffer is setup to use, which is pretty much the same
here, this is the same thing here.

> so by any definition of what DT should describe they're useless for
> this virtual device.
>
> Furthermore it's fairly likely that as your kernel support progresses
> you'll find that the driver all of a sudden needs to manage some other
> type of resource that you just haven't needed until now because it may
> default to being always on. Then you'll have a hard time keeping
> backwards-compatibility and will have to resort to the kinds of hacks
> that you don't want to see in the kernel.

Not such a hard time. An older DT wouldn't define the new requirements
anyway, so they wouldn't be used, and we would end up in pretty much
the current case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/bd8b3639/attachment.sig>
