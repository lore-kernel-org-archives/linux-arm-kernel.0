From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 23 Sep 2010 09:46:36 +0200
Subject: [PATCH 11/12] DMAENGINE: let PL08X memcpy TXDs wait
In-Reply-To: <AANLkTimGu1R0vqpLK9X30CxkibO6N964D1Y-fQvAdA9D@mail.gmail.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-6-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-7-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-8-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-9-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-10-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-11-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-12-git-send-email-linus.walleij@stericsson.com>
	<AANLkTimGu1R0vqpLK9X30CxkibO6N964D1Y-fQvAdA9D@mail.gmail.com>
Message-ID: <AANLkTi=7gsXT2P-7a=DCTsaUBK=B131VFFCBzNVzpYFv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/23 Dan Williams <dan.j.williams@intel.com>:

> The prep routine is meant to guarantee that all the resources for a
> transaction have been acquired.

A practicality here:

The assumption to fail for physical channel allocation at .tx_submit()
is already in the first patch adding the driver.

Should I squash all the icremental improvements into the original
driver, convert to fail at .prep() and resubmit to make all of this
easier, or do you want me to refactor the patch stack, or refactor
from patch 11/12 or...?

Yours,
Linus Walleij
