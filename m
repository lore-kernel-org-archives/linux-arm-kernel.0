From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 19 Aug 2014 21:21:40 +0300
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 2)
In-Reply-To: <20140818235238.GG9187@lunn.ch>
References: <20140718220516.GM24496@titan.lakedaemon.net>
 <20140818205440.GB2126@drone.musicnaut.iki.fi>
 <20140818235238.GG9187@lunn.ch>
Message-ID: <20140819182139.GB4885@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 19, 2014 at 01:52:38AM +0200, Andrew Lunn wrote:
> On Mon, Aug 18, 2014 at 11:54:40PM +0300, Aaro Koskinen wrote:
> > Is there instructions how to get OpenRD Client DT boot to work
> > with 3.17-rc1? I see that legacy boot has been deleted, so there is
> > no other option.
> 
> mvebu_v5_defconfig should work. Starting from 3.17-rc1, that enabled
> appended DT by default.
> 
> CONFIG_DEBUG_LL_UART_8250=y
> CONFIG_DEBUG_UART_PHYS=0xf1012000
> CONFIG_DEBUG_UART_VIRT=0xfed12000
> 
> Should get earlyprintk going.

In the end the issue was just a screwed up command line (console and
root missing). It seems that CONFIG_CMDLINE_EXTEND is doing nothing
when booting with DT. :-/

Thanks,

A.
