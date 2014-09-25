From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 21:20:24 +0200
Subject: [PATCH] [RFC] Using hierarchy irqdomian to implement MTK intpol.
In-Reply-To: <alpine.DEB.2.10.1409251609500.4604@nanos>
References: <1411574696-1881-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <alpine.DEB.2.10.1409251609500.4604@nanos>
Message-ID: <201409252120.24570.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014, Thomas Gleixner wrote:
> On Thu, 25 Sep 2014, Joe.C wrote:
> > From: "Joe.C" <yingjoe.chen@mediatek.com>
> > 
> > Here's the first draft of using hierarchy irqdomain to implement MTK intpol
> > support. I have tested it and intpol works fine. Before continue, I'd like
> > to get your comments. This is based on Jiang's hierarchy irqdomian [1] and
> > my mediatek SoC basic support [2].
> > 
> > Simplified block diagram for interrupt:
> > 
> >     ---------      ---------
> >  ---| CIRQ  |------|ARM GIC|
> >  ---|       |------|       |
> >  ---|       |------|       |
> >  ---|       |------|       |
> >  ---|       |------|       |
> >     ---------      ---------
> >  
> > In device tree, interrupt-parent for other devices is cirq, child of gic.
> > This describe HW better and allow device to specify polarity as it is sent
> > by the device. I'm using interrupt-parent to specify irq domain parent in
> > cirq now. Maybe adding another name like 'interrupt-domain-parent' will be
> > better.
> 
> I leave that to the DT folks.

interrupt-parent really defines a domain already, I think using this is
perfectly fine.


	Arnd
