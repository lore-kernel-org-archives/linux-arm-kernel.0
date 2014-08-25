From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Aug 2014 18:10:34 +0200
Subject: [PATCH] i2c: mv64xxx: continue probe when clock-frequency is
 missing
In-Reply-To: <1408981819-3477-1-git-send-email-wens@csie.org>
References: <1408981819-3477-1-git-send-email-wens@csie.org>
Message-ID: <20140825161033.GF15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 11:50:19PM +0800, Chen-Yu Tsai wrote:
> The "clock-frequency" DT property is listed as optional, However,
> the current code stores the return value of of_property_read_u32 in
> the return code of mv64xxx_of_config, but then forgets to clear it
> after setting the default value of "clock-frequency". It is then
> passed out to the main probe function, resulting in a probe failure
> when "clock-frequency" is missing.
> 
> This patch checks and then throws away the result of
> of_property_read_u32, instead of storing it and having to clear it
> afterwards.
> 
> This issue was discovered after the property was removed from all
> sunxi DTs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Cc: stable at vger.kernel.org

Good catch!

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/73a862e2/attachment.sig>
