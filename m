From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 4 Jun 2018 14:31:24 +0200
Subject: [PATCH] rtc: sunxi: fix possible race condition
In-Reply-To: <20180604120540.5782-1-alexandre.belloni@bootlin.com>
References: <20180604120540.5782-1-alexandre.belloni@bootlin.com>
Message-ID: <20180604123124.ix5iql3wfgjqymsv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2018 at 02:05:40PM +0200, Alexandre Belloni wrote:
> The IRQ is requested before the struct rtc is allocated and registered, but
> this struct is used in the IRQ handler. This may lead to a NULL pointer
> dereference.
> 
> Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
> before requesting the IRQ.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/e4f3741d/attachment.sig>
