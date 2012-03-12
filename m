From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Mar 2012 10:27:16 -0400
Subject: [PATCH 1/2] ARM: kirkwood: Basic support for DNS-320 and DNS-325
In-Reply-To: <op.wa197mq94cuzmg@gonzo.lentin.co.uk>
References: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
 <1331476406-9844-2-git-send-email-jm@lentin.co.uk>
 <20120312030232.GX5050@titan.lakedaemon.net>
 <201203120817.19777.arnd@arndb.de>
 <op.wa197mq94cuzmg@gonzo.lentin.co.uk>
Message-ID: <20120312142716.GA5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 02:22:24PM -0000, Jamie Lentin wrote:
> On Mon, 12 Mar 2012 08:17:19 -0000, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> >On Monday 12 March 2012, Jason Cooper wrote:
> >>> +     dnskw_gpio_register(39, "dnskw:power:sata0", 1);
> >>> +     dnskw_gpio_register(40, "dnskw:power:sata1", 1);
> >>> +
> >>> +     /* Set NAS to turn back on after a power failure */
> >>> +     dnskw_gpio_register(37, "dnskw:power:recover", 1);
> >>> +}
> >>> +
> >>
> >>I doubt this board is the only one that wants to be added while the
> >>conversion to devicetree is progressing.  It makes more sense to me to
> >>break the above out to a separate file, eg board-dnskw.c.  I'll follow
> >>and break out the dreamplug code to board-dreamplug.c.  Otherwise, I see
> >>board-dt.c becoming a long mess.
> >>
> >>Arnd, sound okay to you?
> >
> >Either way is fine with me. I personally wouldn't expect many more boards
> >to come in before the DT conversion has mostly completed, but I guess you
> >have a better feeling for what other hardware is out there that people
> >are interested in.
> >
> 
> It probably depends on how easy it is to add the gpiochips into
> devicetree. Being able to put the LED, buttons and fans in
> devicetree would make board-dt.c much more manageable. I started to
> look into it and wasn't immediately obvious, but will have a closer
> look.
> 
> Happy to resubmit, breaking it out into a board-dnskw.c though.

Yeah, let's go ahead and do that.  pinmux and the above are going to take
a while to sort out.  In the mean time, there's:

sheevaplug
guruplug
guruplug-serverplus
Lacie-*
Seagate-*
rd-boards-*

just to name a few.  Plus it'll give me something to do while we wait
for pinmux/common clock to land.

thx,

Jason.
