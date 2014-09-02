From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 2 Sep 2014 12:39:59 +0200
Subject: [PATCH v2] i2c: mv64xxx: continue probe when clock-frequency is
 missing
In-Reply-To: <1409581693-15943-1-git-send-email-wens@csie.org>
References: <1409581693-15943-1-git-send-email-wens@csie.org>
Message-ID: <20140902103959.GC1266@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 10:28:13PM +0800, Chen-Yu Tsai wrote:
> The "clock-frequency" DT property is listed as optional, However,
> the current code stores the return value of of_property_read_u32 in
> the return code of mv64xxx_of_config, but then forgets to clear it
> after setting the default value of "clock-frequency". It is then
> passed out to the main probe function, resulting in a probe failure
> when "clock-frequency" is missing.
> 
> This patch checks and then throws away the return value of
> of_property_read_u32, instead of storing it and having to clear it
> afterwards.
> 
> This issue was discovered after the property was removed from all
> sunxi DTs.

Hmm, I don't like that removal. Probably I should take care that this
property is not "optional" but "recommended". The default value is
depending on the driver, mostly because of historic reasons. It is
definately better to explicitly state it. Despite all that...

> 
> Fixes: 4c730a06c19bb ("i2c: mv64xxx: Set bus frequency to 100kHz if clock-frequency is not provided")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Cc: stable at vger.kernel.org
> Acked-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/3867506c/attachment-0001.sig>
