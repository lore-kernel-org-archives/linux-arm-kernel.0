From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 20 May 2013 12:07:14 +0200
Subject: [RFC PATCH 0/5] ARM: mv78x00: First step to convert mv78x00 to
 Device Tree
In-Reply-To: <5199F3E8.8060008@free-electrons.com>
References: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
 <20130520094318.GD26249@lunn.ch>
 <5199F3E8.8060008@free-electrons.com>
Message-ID: <20130520100714.GF26249@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 11:59:04AM +0200, Gregory CLEMENT wrote:
> On 05/20/2013 11:43 AM, Andrew Lunn wrote:
> > On Sun, May 19, 2013 at 11:39:33PM +0200, Gregory CLEMENT wrote:
> >> Hello,
> >>
> >> This patch set is a first step in order to convert mach-mv78x00 to
> >> device tree before it joins mach-mvebu.
> >>
> >> I managed to test it on the RD-78X00-mASA board. All the peripherals I
> >> have tested work as they work before the migration to the device tree:
> >> - UART
> >> - Ethernet
> >> - USB
> >> - SATA
> >>
> >> My main concern is that the mv78x00 are MP but not SMP
> >> capable. Currently the same kernel run on the 2 cores and it is in the
> >> board file that the peripherals are assigned for each CPU. (Actually I
> >> didn't test this behavior, but the code is written in this way.)
> >>
> >> I don't know how to assign a peripheral to a given CPU with the device
> >> tree. The only way I have in mind is to have a dts per CPU, but I am
> >> not sure it is very convenient.
> >>
> >> So for now the code assigns all the peripherals to the CPU.
> > 
> > Hi Gregory
> 
> Hi Andrew,
> 
> > 
> > Could you explain what you have in a bit more detail. Are you just
> > bringing up one CPU and assigning all peripherals to that? Or do all
> > peripherals get assigned to the first CPU but both are running?
> 
> Currently I didn't find (but I didn't looked for so much) how to
> boot the kernel on both CPU even with the legacy code. So I am just
> bringing up one CPU and assigning all peripherals to that.

Hi Gregory

Did you try looking at UART 1. It could be there is a second uboot
instance running on it which is for CPU1.

> > It might be interesting to ask on the buffalo forums if anybody is
> > actually using mainline on TS-WLX.
> 
> Do you know where is this forum?

http://forum.buffalo.nas-central.org

	Andrew
