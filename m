From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 22:16:29 +0200
Subject: [PATCH 2/4] ARM: dts: uniphier: delete i2c aliases
In-Reply-To: <1445427390-22750-3-git-send-email-yamada.masahiro@socionext.com>
References: <1445427390-22750-1-git-send-email-yamada.masahiro@socionext.com>
 <1445427390-22750-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <4000897.7Un1B3qMyp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 October 2015 20:36:28 Masahiro Yamada wrote:
> The user space should not expect that a particular I2C channel is
> always visible through the same character device.
> No reason to fix the I2C indexes with aliases.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 

As I said in my reply to the earlier mail, I didn't really like the
idea of having holes in the numbering for the i2c controllers, but
this new approach also doesn't look ideal.

We should have stable bus numbers on any given board, and the aliases
work well for that. I just don't think the aliases need to be stable
between different boards just because they are based on the same
SoC.

I'd suggest staying with the current slightly awkward approach though,
to avoid regressions. Please send a follow-up patch to add the same
aliases on the new boards and drop this patch, unless someone else
can come up with a better idea.

	Arnd
