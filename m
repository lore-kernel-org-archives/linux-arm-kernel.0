From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Mar 2017 11:18:52 +0100
Subject: [PATCH] spi: sun6i: Allow transfers larger than FIFO size
In-Reply-To: <20170306121443.36954-1-icenowy@aosc.xyz>
References: <20170306121443.36954-1-icenowy@aosc.xyz>
Message-ID: <20170307101852.uuxiu5ycd7zbgrxm@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 08:14:43PM +0800, Icenowy Zheng wrote:
> The spi-sun6i driver have the same problem that spi-sun4i used to have
> -- SPI transfers are limited to one FIFO depth.
> 
> This commit fixes this problem in the same way it's fixed in spi-sun4i.
> See commit 196737912da5 ("spi: sun4i: Allow transfers larger than FIFO size")
> for more information.
> 
> The sun6i SPI controllers features changeable interrupt trigger level, but I
> set it to 3/4 of fifo depth, as same as the the sun4i SPI controllers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170307/0b9ef3ff/attachment-0001.sig>
