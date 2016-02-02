From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Feb 2016 18:21:10 +0000
Subject: [PATCH 01/10] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <20160202181929.GB29778@leverpostej>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
 <20160202181929.GB29778@leverpostej>
Message-ID: <20160202182109.GC29778@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 06:19:29PM +0000, Mark Rutland wrote:
> On Tue, Feb 02, 2016 at 07:07:39PM +0100, Gregory CLEMENT wrote:
> > From: Wilson Ding <dingwei@marvell.com>
> > 
> > Armada-3700's uart is a simple serial port, which doesn't
> > support. Configuring the modem control lines. The uart port has a 32
> > bytes Tx FIFO and a 64 bytes Rx FIFO
> > 
> > The uart driver implements the uart core operations. It also support the
> > system (early) console based on Armada-3700's serial port.
> >
> > Known Issue:
> > 
> > The uart driver currently doesn't support clock programming, which means
> > the baud-rate stays with the default value configured by the bootloader
> > at boot time
> 
> This looks like any other early console.
> 
> Why does this not use the earlycon infrastructure?

Ah, it does, and I misread the diff quite badly.

Apologies for the noise.

Mark.
