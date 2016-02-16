From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 22:35:14 +0100
Subject: [PATCH v4 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <20160216222706.6b1d3375@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
 <3647094.zzYms58VAY@wuerfel> <20160216222706.6b1d3375@free-electrons.com>
Message-ID: <2634634.yW5ZfZDXSz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 22:27:06 Thomas Petazzoni wrote:
> Arnd,
> 
> On Tue, 16 Feb 2016 22:20:51 +0100, Arnd Bergmann wrote:
> 
> > > +config SERIAL_MVEBU_CONSOLE
> > > +       bool "Console on Marvell EBU serial port"
> > > +       depends on SERIAL_MVEBU_UART
> > 
> > then this one must become
> > 
> >       depends on SERIAL_MVEBU_UART
> > 
> > so it does not get enabled if the driver is not builtin.
> 
> Hm, what's the different between "depends on SERIAL_MVEBU_UART" and
> "depends on SERIAL_MVEBU_UART" ? Is it the late time that causes my
> eyes to misunderstand what you mean, or some typo on your side ? 
> 


typo: I meant

	depends on SERIAL_MVEBU_UART=y


	Arnd
