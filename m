From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 23 Oct 2012 12:23:12 +0200
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121023100333.GA24418@arwen.pp.htv.fi>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
 <508664CA.7000601@ti.com>
 <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
 <20121023100333.GA24418@arwen.pp.htv.fi>
Message-ID: <20121023122312.56b23e1c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 23 Oct 2012 13:03:33 +0300, Felipe Balbi wrote:

> > But it appears that shmobile prefer to get all resources using
> > bus notifiers.
> > 
> > So we need to form some kind of consensus ... or live with
> > the fact that different systems do it different ways. Which will
> > explode the day we need to use a driver on two systems,
> > each using the other approach :-)
> 
> I much prefer having drivers explicitly manage all their resources,
> which would mean that pinctrl calls need to be done on probe() and, if
> necessary, during suspend()/resume().
> 
> Using bus notifiers for that is quite a hack IMHO.

Agreed. Just like drivers do their ioremap, request_irq and others,
they should also request their pin resources using the pinctrl API.
Hiding this behind a bus notifier is not nice.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
