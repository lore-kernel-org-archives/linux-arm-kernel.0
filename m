From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Oct 2012 13:29:03 +0300
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdb+f44jw1vTYvJT0bnMOP8XQe8ztDUHiwtS2JHtPWAGXw@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
 <508664CA.7000601@ti.com>
 <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
 <20121023100333.GA24418@arwen.pp.htv.fi>
 <20121023122312.56b23e1c@skate>
 <CACRpkdb+f44jw1vTYvJT0bnMOP8XQe8ztDUHiwtS2JHtPWAGXw@mail.gmail.com>
Message-ID: <20121023102903.GA24820@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 23, 2012 at 12:29:28PM +0200, Linus Walleij wrote:
> On Tue, Oct 23, 2012 at 12:23 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> >
> > On Tue, 23 Oct 2012 13:03:33 +0300, Felipe Balbi wrote:
> >
> >> > But it appears that shmobile prefer to get all resources using
> >> > bus notifiers.
> >> >
> >> > So we need to form some kind of consensus ... or live with
> >> > the fact that different systems do it different ways. Which will
> >> > explode the day we need to use a driver on two systems,
> >> > each using the other approach :-)
> >>
> >> I much prefer having drivers explicitly manage all their resources,
> >> which would mean that pinctrl calls need to be done on probe() and, if
> >> necessary, during suspend()/resume().
> >>
> >> Using bus notifiers for that is quite a hack IMHO.
> >
> > Agreed. Just like drivers do their ioremap, request_irq and others,
> > they should also request their pin resources using the pinctrl API.
> > Hiding this behind a bus notifier is not nice.
> 
> So the biggest implementation of the notifier approach to resource
> handling is the SH clock thing:
> drivers/base/power/clock_ops.c

that's different right ? It's just creating the list of clocks, device
drivers still have to call pm_clk_add().

That's ok, I guess, otherwise all struct device would allocate memory
which hardly ever used (so far).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/73258827/attachment.sig>
