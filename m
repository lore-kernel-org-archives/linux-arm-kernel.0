From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 25 Sep 2015 00:40:34 +0200
Subject: [PATCH 2/6] pci: mvebu: generate proper configuration access
 cycles
In-Reply-To: <20150924224305.GG21513@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
 <E1Zenfg-0004d5-Dg@rmk-PC.arm.linux.org.uk>
 <20150924222322.GF20825@lunn.ch>
 <20150924224305.GG21513@n2100.arm.linux.org.uk>
Message-ID: <20150924224034.GH20825@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I tried
> > 
> > root at dir665:~# setpci -s 1:0.0 0xe8.l
> > 00102000
> > root at dir665:~# setpci -s 1:0.0 0xe8.w=0x2000
> > root at dir665:~# setpci -s 1:0.0 0xe8.l
> > 00102000
> > 
> > but that is not producing the FAIL you had.
> 
> The only bit you have set in your DevSta register is:
> 
> #define  PCI_EXP_DEVSTA_AUXPD   0x0010  /* AUX Power Detected */
> 
> which is not a RW1C bit.

So i cannot actually test this on my hardware :-(

I guess the best i can do is apply the patch, load the wifi driver,
and ensure i can still join a network.

    Andrew
