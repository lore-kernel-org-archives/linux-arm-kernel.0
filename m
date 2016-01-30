From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Jan 2016 23:29:02 +0000
Subject: Fwd: Marvell Kirkwood TS41x GMAC losing connection
In-Reply-To: <C9921470-1302-49D7-A97E-2C9008D337EB@schloeter.net>
References: <44A6A099-58F8-49AF-9827-A4CAD4035E78@schloeter.net>
 <C9921470-1302-49D7-A97E-2C9008D337EB@schloeter.net>
Message-ID: <20160130232902.GC25120@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ ThomasP, lakml

On Fri, Jan 29, 2016 at 09:07:00PM +0100, Thomas Schl?ter wrote:
> Dear ARM Kirkwood Maintainers,
> 
> I tried to post the message below to the linux-arm-kernel mailing list with no success as my mail gets greylisted due to some ?suspicion? I cannot understand. Obviously the list moderator has gone to lunch for a long time, so please excuse that I contact you directly.
> 
> 
> > Anfang der weitergeleiteten Nachricht:
> > 
> > Von: Thomas Schl?ter <thomas@schloeter.net>
> > Betreff: Marvell Kirkwood TS41x GMAC losing connection
> > Datum: 18. Januar 2016 um 21:22:54 MEZ
> > An: linux-arm-kernel at lists.infradead.org
> > 
> > Hello,
> > 
> > I am using a kernel 4.3 on a QNAP TS-412 (Kirkwood/mvebu TS41x 8261).
> > 
> > After less than one hour of using the system, I am losing the network connection on the Marvell GMAC interface. In syslog, I can see some services complaining "write: No buffer space available".
> > When I hook up a USB keyboard and bring the interface down and up again, it works again for some minutes before it crashes again.
> > 
> > During bootup, I see the following messages:
> > 
> > [    9.183115] mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
> > [    9.190408] kirkwood-pinctrl f1010000.pin-controller: pin PIN20 already requested by f1080000.sata; cannot claim for f1076000.ethernet-controller
> > [    9.203553] kirkwood-pinctrl f1010000.pin-controller: pin-20 (f1076000.ethernet-controller) status -22
> > [    9.212920] kirkwood-pinctrl f1010000.pin-controller: could not request pin 20 (PIN20) from group mpp20  on device f1010000.pin-controller
> > [    9.225419] mv643xx_eth f1076000.ethernet-controller: Error applying setting, reverse things back
> > [   10.318914] mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 00:50:89:12:34:56
> > [   11.434761] mv643xx_eth_port mv643xx_eth_port.1 eth1: port 0 with MAC address 00:00:00:00:00:00
> > [   40.663969] mv643xx_eth_port mv643xx_eth_port.0 eth0: link up, 1000 Mb/s, full duplex, flow control disabled
> > 
> > Is it possible that there is a problem with the device tree resulting in a hardware pin of the GMAC being erroneously routed to the SATA port?
> > Indeed, the system and network has been stable from flash / initrd until I put it some hard disks.
> > 
> > Thanks in advance.
> > 
> > Regards,
> > Thomas
> 
