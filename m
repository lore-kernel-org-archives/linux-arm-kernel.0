From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Mar 2012 12:09:48 +0000
Subject: [PATCH v9] mfd: Add anatop mfd driver
In-Reply-To: <201203150907.29895.arnd@arndb.de>
References: <1331797421-23731-1-git-send-email-paul.liu@linaro.org>
 <201203150907.29895.arnd@arndb.de>
Message-ID: <20120315120948.GG3138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 09:07:29AM +0000, Arnd Bergmann wrote:

> Very broadly speaking, I wonder whether we could use the regmap
> infrastructure for these things in the future, but I would first
> need to understand whether that is actually in the scope of regmap.

> It seems that you just need a subset of what regmap provides,
> so it could work, but it might not actually be better than what
> you have now.

> Mark, can you comment on that?

There were some other mutterings about using regmap for memory mapped
devices, mostly from the point of view of building framework features
like this on top of it.  regmap currently makes some assumptions that
the I/O is going to be slow so approximately any amount of CPU time can
usefully be spent on avoiding I/O but we can probably do something about
that.  It also uses mutexes to lock I/O which might not be the most
sensible thing for memory mapped devices, but again that's solveable.
Right now there's no memory mapping support but there's no reason that
can't be added.

In short, it does seem sensible to want to have some support for this
for devices that use appropriate idioms.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/37f8408c/attachment.sig>
