From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 Dec 2011 17:51:33 -0800
Subject: [AT91 PULL] gpio cleanup pull request for 3.3
In-Reply-To: <20111129020213.GI15008@game.jcrosoft.org>
References: <20111123171935.GC15531@game.jcrosoft.org>
 <201111281858.54217.arnd@arndb.de>
 <20111129020213.GI15008@game.jcrosoft.org>
Message-ID: <CAOesGMhqw-Gf=H3J04twGq5+b+8MOhSJ-cYyt9Dai6BRS-PaVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Christophe,

The branch that was pulled by Arnd is not the same patches that were
posted for review (at least not the same as v3 of the series).

In the series you posted for review, the code was correct. In your
branch it breaks with:

arch/arm/mach-at91/board-stamp9g20.c:126: error: expected '}' before ';' token

I.e. a trivial ; vs , error, but it's the only one in the whole file
(it's done on two consecutive lines). It can be found by building
stamp9g20_defconfig or pcontrol_g20_defconfig.

Please use more care in the future to avoid this. In particular, it is
troubling that the code in your branch does not match the series you
posted without any kind of notice about it.


-Olof
