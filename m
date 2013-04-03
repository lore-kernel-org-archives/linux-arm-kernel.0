From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Apr 2013 09:41:39 +0800
Subject: [PATCH V2 01/12] spi/mxs: Always set LOCK_CS
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <20130403014137.GI24039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 05:19:44AM -0700, Trent Piepho wrote:
> There are two bits which control the CS line in the CTRL0 register:
> LOCK_CS and IGNORE_CRC.  The latter would be better named DEASSERT_CS
> in SPI mode.
> 
> LOCK_CS keeps CS asserted though the entire transfer.  This should
> always be set.  The DMA code will always set it, explicitly on the
> first segment of the first transfer, and then implicitly on all the
> rest by never clearing the bit from the value read from the ctrl0
> register.
> 
> The only reason to not set LOCK_CS would be to attempt an altered
> protocol where CS pulses between each word.  Though don't get your
> hopes up if you want to do this, as the hardware doesn't appear to do
> this in any sane manner.
> 
> The code can be simplified by just setting LOCK_CS once and then not
> needing to deal with it in the PIO and DMA transfer functions.
> 
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>

Trent,

Just FYI, Mark Brown is taking care of SPI subsystem patches recently.
Please remember copy him on the series when you repost, if you want to
see the series get applied eventually :)

Shawn
