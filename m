From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 9 Dec 2009 11:00:54 +0800
Subject: [PATCH] mx27: mxt_td60: Add USB Support
In-Reply-To: <37367b3a0912070339o44b6badcjbcd47034f5589b72@mail.gmail.com>
References: <1259948719-10008-1-git-send-email-acassis@gmail.com>
	<20091204180554.GX14091@buzzloop.caiaq.de>
	<37367b3a0912070339o44b6badcjbcd47034f5589b72@mail.gmail.com>
Message-ID: <20091209030051.GC28375@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 09:39:04AM -0200, Alan Carvalho de Assis wrote:
> > On Fri, Dec 04, 2009 at 03:45:19PM -0200, Alan Carvalho de Assis wrote:

> > Ideally, you would make that a more generic driver of its own, which lives
> > in
> > drivers/usb/otg/ and is named something like 'transceiver-gpio'. You would
> > instanciate it by passing a platform data struct to set the gpios you want
> > it
> > to use. This might sound overdone, but it would make your code reusable.
> >
> > The calls to mxc_gpio_mode() would remain in your platform code, of course.
> >
> 
> Ok, I need your support here. I'm using mxc-master and I looked for
> something related to "transceiver gpio", but no success. I found some
> gpio related to usb gadget, but this is not the case. Could you point
> me to right function?

What I was thinking of is a very small kind of driver that is
initialized similar to the ulpi transceiver but instead of taking ULPI
lowevel operations, it is fed with a struct to specify the GPIOs to use.

Daniel
