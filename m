From: ynvich@gmail.com (Sergei Ianovich)
Date: Sat, 14 Dec 2013 23:34:20 +0400
Subject: [PATCH v2 03/16] ARM: dts: provide DMA config to pxamci
In-Reply-To: <201312142006.26979.arnd@arndb.de>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-4-git-send-email-ynvich@gmail.com>
 <201312142006.26979.arnd@arndb.de>
Message-ID: <1387049660.7152.317.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-12-14 at 20:06 +0100, Arnd Bergmann wrote:
> On Friday 13 December 2013, Sergei Ianovich wrote:
> > Non-dts implementation supply required DMA channel numbers as
> > IORESOURCE_DMA. However, there is was no way to get them from
> > device tree.
> 
> Please update this changeset comment, I think it still refers to
> the earlier version.

---
Non-dts implementation supply required DMA channel numbers as
IORESOURCE_DMA. We can also get them from the device tree, if it
is present.
---

Is this fine?

Should I post v3, if so? 

> > Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> > CC: Daniel Mack <zonque@gmail.com>
> > CC: Arnd Bergmann <arnd@arndb.de>
> 
> The patch looks ok in case we are merging your patches for 3.14
> and Daniel's patches later than that. If they end up in the
> same merge window however, we'd have to be care to resolve
> the obvious conflict in a proper way.

The most recently published Daniel's patch (Aug 2013) wraps
IORESOURCE_DMA handling on DT presence in a similar way, but doesn't do
any actual DT processing. So there is no conflict at the moment. Daniel
can comment better on this, though.
