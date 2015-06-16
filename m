From: gradator@gradator.net (Sylvain Rochet)
Date: Tue, 16 Jun 2015 15:32:55 +0200
Subject: [BUG] at91: macb: does not work
In-Reply-To: <20150616152454.348ae4ea@bbrezillon>
References: <5580205B.1030804@aksignal.cz> <20150616152454.348ae4ea@bbrezillon>
Message-ID: <20150616133255.GA28340@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ji??,

On Tue, Jun 16, 2015 at 03:24:54PM +0200, Boris Brezillon wrote:
> Hi Jiri,
> 
> On Tue, 16 Jun 2015 15:10:51 +0200
> Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:
> 
> > Hi,
> > in v4.1-rc8 does not work ethernet. It normally gets up, but no data are going through.
> > 
> > [    4.400000] macb f802c000.ethernet (unnamed net_device) (uninitialized): invalid hw address, using random
> > [    4.510000] macb f802c000.ethernet eth0: Cadence MACB rev 0x0001010c at 0xf802c000 irq 37 (52:30:8f:6b:9c:b7)
> > [    4.520000] macb f802c000.ethernet eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=f802c000.etherne:03, irq=-1)
> > [   15.510000] macb f802c000.ethernet eth0: link up (100/Full)
> > 
> > / # ip -s link ls eth0
> > 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
> >      link/ether a2:61:fe:17:65:b1 brd ff:ff:ff:ff:ff:ff
> >      RX: bytes  packets  errors  dropped overrun mcast
> >      0          0        0       0       0       0
> >      TX: bytes  packets  errors  dropped carrier collsns
> >      0          0        0       0       0       0
> > 
> > In v4.0.5 it's working.
> 
> On which platform are you testing (SoC and board) ?

I guess I'm also affected by this issue, but contrary to Ji?? my eth0 
interface passes traffic a minute or so after booting up.

This doesn't seem to be related with TM9000 screen and the ETH0/QT1070 
hardware IRQ sharing.

Sylvain
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150616/ade22d02/attachment.sig>
