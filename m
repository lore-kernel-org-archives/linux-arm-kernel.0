From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 3 Apr 2018 10:10:41 +0200
Subject: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
In-Reply-To: <20180329185907.27281-3-ssuloev@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-3-ssuloev@orpaltech.com>
Message-ID: <20180403081041.3ully6bcyfwx2cx6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2018 at 09:59:03PM +0300, Sergey Suloev wrote:
> There is no need to handle 3/4 empty/full interrupts as the maximum
> supported transfer length in PIO mode is 64 bytes for sun4i-family
> SoCs.

That assumes that you'll be able to treat the FIFO full interrupt and
drain the FIFO before we have the next byte coming in. This would
require a real time system, and we're not in one of them.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/31b106f5/attachment.sig>
