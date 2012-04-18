From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Apr 2012 11:00:39 +0000
Subject: [PATCH v2 0/8] Second patchset for LPC32xx device tree conversion
In-Reply-To: <20120418093604.GL6498@mwanda>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <201204180806.16848.arnd@arndb.de> <20120418093604.GL6498@mwanda>
Message-ID: <201204181100.40123.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Dan Carpenter wrote:
> I'm not sure I understand.  I thought everyone used the develop
> against linux-next and backport the fixes model.  Are we going to
> try merge these in 3.4?  It will still spend some time in linux-next
> before we submit it, right?

Correct, but the point is that you cannot add patches on top of -next
and have them included in a future -next version, because they never
merge cleanly.

The ideal workflow is:

1. develop on -rc
2. merge with latest -next, test and make sure it works there
3. submit for review against -rc
4. have patches included in -next once reviewed, but based on -rc
5. when merge window opens, have patches sent for upstream inclusion

The last two steps are slightly different for your own subsystem
compared to someone else's subsystem: In this case, Roland is the
author and sends the patches to me to have them included in -next
and I send them to Linus in the next merge window.

	Arnd
