From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Nov 2016 18:34:13 +0100
Subject: [PATCH v2 02/14] ASoC: sun4i-codec: Expand quirks to handle
 register offsets and card creation
In-Reply-To: <20161103075556.29018-3-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-3-wens@csie.org>
Message-ID: <20161103173413.xoljqlfpqlfaeiyj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:55:44PM +0800, Chen-Yu Tsai wrote:
> The A31 has a similar codec to the A10/A20. The PCM parts are very
> similar, with just different register offsets. The analog paths are
> very different. There are more inputs and outputs.
> 
> The A31s, A23, and H3 have a similar PCM interface, again with register
> offsets slightly rearranged. The analog path controls, while very
> similar between them and the A31, have been moved a separate bus which
> is accessed through a message box like interface in the PRCM address
> range. This would be handled by a separate auxiliary device tied in
> through the device tree in its supporting create_card function.
> 
> The quirks structure is expanded to include different register offsets
> and separate callbacks for creating the ASoC card. The regmap_config,
> quirks, and of_device_match tables have been moved to facilitate this.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/a5744aaa/attachment.sig>
