From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Aug 2014 01:52:38 +0200
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 2)
In-Reply-To: <20140818205440.GB2126@drone.musicnaut.iki.fi>
References: <20140718220516.GM24496@titan.lakedaemon.net>
 <20140818205440.GB2126@drone.musicnaut.iki.fi>
Message-ID: <20140818235238.GG9187@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 11:54:40PM +0300, Aaro Koskinen wrote:
> On Fri, Jul 18, 2014 at 06:05:16PM -0400, Jason Cooper wrote:
> > Yeah, it's just one patch, but it's a beautiful one!  Thanks to the
> > efforts of many people over the last couple years, and in particular,
> > Andrew Lunn, Kirkwood has been completely converted to DT.
> 
> Is there instructions how to get OpenRD Client DT boot to work
> with 3.17-rc1? I see that legacy boot has been deleted, so there is
> no other option.
> 
> I tried booting kernel with appended DTB, but it just silently hangs.
> Also tried to enable earlyprintk, but couldn't get even that working...

mvebu_v5_defconfig should work. Starting from 3.17-rc1, that enabled
appended DT by default.

CONFIG_DEBUG_LL_UART_8250=y
CONFIG_DEBUG_UART_PHYS=0xf1012000
CONFIG_DEBUG_UART_VIRT=0xfed12000

Should get earlyprintk going.

       Andrew
