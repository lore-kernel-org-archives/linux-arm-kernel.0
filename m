From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 13 Apr 2011 11:16:47 +0300
Subject: [PATCH 1/2] ux500: Adding support for u8500 Hsem functionality V2
In-Reply-To: <201104121946.01618.arnd@arndb.de>
References: <1302535464-12294-1-git-send-email-mathieu.poirier@linaro.org>
	<201104121946.01618.arnd@arndb.de>
Message-ID: <BANLkTinGt1wey0ofLRUVzS4Ru==OLvChTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 8:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When you do that, this can be a single allocation.
>
> Thinking about it some more, it may actually be worthwhile to still improve
> the API here: I think the owner field should be part of the operations structure,
> because it is constant. It would also be nice to have a "private" pointer
> in struct hwspinlock, so you don't need to wrap it if you don't want to.

These are good improvements, part of which I planned to do so too
(especially to take out the dev, ops and owner fields into a dedicated
structure, and have all the hwspinlock instances, which belong to that
block, point at it).

By introducing a "private" pointer, and removing the platform-specific
wrapping around it, we can also get rid of the 'id' field, and induce
it with a simple pointers arithmetic (namely, id = pointer of instance
- array base address).
