From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Nov 2014 08:05:54 +0100
Subject: [PATCH] i2c: designware: prevent early stop on TX FIFO empty
In-Reply-To: <545CB6C4.8010201@arm.com>
References: <545CB6C4.8010201@arm.com>
Message-ID: <20141121070554.GF1480@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 12:10:44PM +0000, Andrew Jackson wrote:
> If the Designware core is configured with IC_EMPTYFIFO_HOLD_MASTER_EN
> set to zero, allowing the TX FIFO to become empty causes a STOP
> condition to be generated on the I2C bus. If the transmit FIFO
> threshold is set too high, an erroneous STOP condition can be
> generated on long transfers - particularly where the interrupt
> latency is extended.
> 
> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/e2390a9d/attachment.sig>
