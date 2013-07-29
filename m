From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 29 Jul 2013 22:43:15 +0200
Subject: NSA310 + DT
In-Reply-To: <20130729192112.GY29916@titan.lakedaemon.net>
References: <20130710073706.GA28212@lunn.ch> <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
Message-ID: <20130729204315.GK24782@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 03:21:12PM -0400, Jason Cooper wrote:
> Hi Finn,
> 
> On Mon, Jul 29, 2013 at 07:05:32PM +0200, Finn Hoffmann wrote:
> > Hello,
> > 
> > I have tried to get a current Kernel running on my NSA310.
> 
> Nice.
> 
> > Everything works well on Kernels before DT with the mentioned
> > patches from https://github.com/peeter123/NSA310-320-debian .
> > I have linux-3.10.2 running and after I changed the dts file to lm85
> > sensors and fanconrtol work but GPIO does not.
> > I tried https://github.com/lunn/linux/tree/v3.11-rc1-nsa310-tdc and
> > linux-3.11.0-rc3.
> > Both have the problem that r8169 is not working:
> > r8169: eth0: unknown chipset (mac_version = 0).
> > and console is spammed with
> > r8169 0000:01:00.0 eth0: rtl_phyar_cond == 0 (loop: 20, delay: 25).
> > until I take eth0 down.
> > GPIO is working.

Hi Finn

Thanks for testing my tree. I based it on the patches found in 
https://github.com/peeter123/NSA310-320-debian.

The patch-3.6.9-nsa310.diff does not contain any changes to the
ethernet driver. So you best bet is to ask on the netdev mailing
list.

Once you have it solved, it would be nice if you can send a tested-by:
signoff to my patches.

	Andrew
