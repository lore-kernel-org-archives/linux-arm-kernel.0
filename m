From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Apr 2014 17:22:17 +0100
Subject: mach header files
In-Reply-To: <730e7ebfabf7489bbfee808cd0247411@SIXPR06MB173.apcprd06.prod.outlook.com>
References: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
 <5297747.kWEjnPz8MW@wuerfel>
 <9970caa86d5c454d840c489901d3ca91@SIXPR06MB173.apcprd06.prod.outlook.com>
 <6837506.Q7cFQWf1xJ@wuerfel>
 <730e7ebfabf7489bbfee808cd0247411@SIXPR06MB173.apcprd06.prod.outlook.com>
Message-ID: <20140404162217.GE7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 04:02:58PM +0000, Phil Edworthy wrote:
> Unfortunately, it's not a performance toggle. Functionally, the pl011
> will only work with a DMAC if we use the DMA burst request. That's not
> completely true though as whether it will work depends on the pl011
> driver. With the upstream pl011 linux driver, it's true.
> 
> BTW, the register to control this has nothing to do with the pl011
> hardware. The standard pl011 hardware, afaik, outputs both the DMA
> single request and DMA burst request signals, and which one is wired
> up to the DMAC depends on who designed the SoC. For this hardware,
> the hardware people played safe and provided a register that can be
> used to switch between the single and burst request signals.

That's not how it's supposed to be used.

The idea behind the two requests is that the peripheral signals to the
DMA controller whether it has enough entries in the FIFO for the DMA
controller to do a burst transfer, or whether it should do a series of
single transfers.

It sounds to me like someone hasn't taken the time to read the PL011
documentation and thought about this.  As such, it's probably not worth
bothering trying to get DMA working.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
