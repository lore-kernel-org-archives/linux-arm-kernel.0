From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Apr 2014 18:22:16 +0200
Subject: [PATCH v5] ARM: sun4i: spi: Allow transfers larger than FIFO size
In-Reply-To: <1396318611-8997-1-git-send-email-mr.nuke.me@gmail.com>
References: <20140331104522.GD26751@lukather>
 <1396318611-8997-1-git-send-email-mr.nuke.me@gmail.com>
Message-ID: <20140401162216.GN26751@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 09:16:51PM -0500, Alexandru Gagniuc wrote:
> SPI transfers were limited to one FIFO depth, which is 64 bytes.
> This was an artificial limitation, however, as the hardware can handle
> much larger bursts. To accommodate this, we enable the interrupt when
> the Rx FIFO is 3/4 full, and drain the FIFO within the interrupt
> handler. The 3/4 ratio was chosen arbitrarily, with the intention to
> reduce the potential number of interrupts.
> 
> Since the SUN4I_CTL_TP bit is set, the hardware will pause
> transmission whenever the FIFO is full, so there is no risk of losing
> data if we can't service the interrupt in time.
> 
> For the Tx side, enable and use the Tx FIFO 3/4 empty interrupt to
> replenish the FIFO on large SPI bursts. This requires more care in
> when the interrupt is left enabled, as this interrupt will continually
> trigger when the FIFO is less than 1/4 full, even though we
> acknowledge it.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Hmmm, you forgot to Cc Mark Brown. Please resubmit it Ccing whoever
shows up using get_maintainer, otherwise, your patch won't be applied.

You also forgot the changes between this version and the previous one.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140401/6d6755ec/attachment.sig>
