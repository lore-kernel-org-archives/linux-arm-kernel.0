From: andy@aeruder.net (Andrew Ruder)
Date: Wed, 29 Jan 2014 09:39:28 -0600
Subject: [BUG] reproducable ubifs reboot assert and corruption
In-Reply-To: <52E8AB0F.2090905@nod.at>
References: <20140122051510.GB17284@gmail.com>
 <CAFLxGvwmzftdQKSjjjwpFLS8g3EJqMrQ2gU2scBsh2MvG7Wyyw@mail.gmail.com>
 <20140127163939.GA27809@gmail.com>
 <20140129053238.GA6035@gmail.com> <52E8AB0F.2090905@nod.at>
Message-ID: <20140129153928.GA7278@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 08:17:35AM +0100, Richard Weinberger wrote:
> So you can trigger this by running fsstress on /mnt and then call
> mount -o remount,ro /mnt?

That's all it takes.  I actually run the remount until it succeeds,
obviously with fsstress going in the background there is a pretty narrow
window where it needs to sneak in with a write between the start of the
sync_filesystem and before the remount check for writers (-EBUSY).

> Can you also trigger it on nandsim or mtdram?

Haven't tried, but I can.  I just don't really have that great of
a development environment for doing this on a desktop machine.

> I did a quick test on my testbed using mtdram and was unable to trigger it.
> But I fear my box is too fast.

I think there is definitely a speed component of my 416 MHz PXA 270 that
makes this pretty easy to hit.  What if you did something like (changing
the ubiattach and mount lines obviously)?

I'll see if I can do this in a qemu, but it might take me a while to get
that setup.

- Andy
