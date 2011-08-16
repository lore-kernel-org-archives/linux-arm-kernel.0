From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Aug 2011 21:07:08 +0200
Subject: [PATCH 2/4] msm_serial: Add devicetree support
In-Reply-To: <20110816175702.GA27576@huya.qualcomm.com>
References: <1313190008-7551-1-git-send-email-davidb@codeaurora.org>
	<65679699.l4XXDScc0T@wuerfel>
	<20110816175702.GA27576@huya.qualcomm.com>
Message-ID: <3445697.36l0oAAgCs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 August 2011 10:57:02 David Brown wrote:
> How about if I just keep it simple for now.  Since there isn't
> actually a driver for the DMA version, this driver will handle both
> UART blocks, so I'll just do the plain thing in the DT.

Sounds good to me.

> In the future, when a DMA-capable driver exists, we can figure out how
> to determine which driver should be used.  At this point, I'm not even
> sure what the correct answer will be, since a given configuration may
> want to use non-DMA for one msm-hsuart device, and the DMA driver for
> another.  It's kind of board/use specific, but beyond just describing
> what the hardware is.

In order to be absolutely future-proof, you could mandate that you always
list two "compatible" values, one for the generic version and one for
the specific implementation (high-speed or low-speed). It's a simple
change from what you have now and it allows to change the drivers to
bind to just the specific name in case you want to handle them separately
in the future, without having to change the device tree files.

	Arnd
