From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 May 2011 08:25:16 +0100
Subject: IrDA driver fails on PXA255
In-Reply-To: <alpine.DEB.2.00.1105281913490.15709@chino.kir.corp.google.com>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<20110528234614.GV24876@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105281913490.15709@chino.kir.corp.google.com>
Message-ID: <20110529072516.GW24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 28, 2011 at 07:22:44PM -0700, David Rientjes wrote:
> arm, pxa2xx: enable DMA support for pxa2xx IRDA interface
> 
> The pxa2xx-ir driver allocates with GFP_DMA, so it must always have 
> ZONE_DMA.

Wrong way.  If there's no restrictions, drivers shouldn't be using
GFP_DMA.  For the majority of SoCs, that's the case.
