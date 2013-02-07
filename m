From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 7 Feb 2013 14:30:27 +0200
Subject: [PATCH] OMAPDSS: enable omapdss for ARCH_MULTIPLATFORM
In-Reply-To: <201302071155.12565.arnd@arndb.de>
References: <1358891160-9534-1-git-send-email-robdclark@gmail.com>
 <3969096.QosOfOb9QT@wuerfel> <511392B0.4040409@ti.com>
 <201302071155.12565.arnd@arndb.de>
Message-ID: <51139E63.2030302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-02-07 13:55, Arnd Bergmann wrote:

> omapdrm still has the 'select' statement in it if you only send the
> first patch, so it should not be possible to disable omapdss when
> it is actually needed.

Yes, you're right. After adding ARCH_MULTIPLATFORM, the kconfig enables
omapdss fully even if enabled by select. So select is only a problem if
omapdss is enabled when omapdss's dependencies are missing.

> I suggested doing only the minimum that is needed to unbreak the
> allyesconfig build, which is to enable just omapdss but not omapfb
> and the displays, in case they don't actually build on anything else.

omapfb and the displays build also fine on all platforms. But it's true
that they are not needed to fix allyesconfig.

> I would suggest only the first patch, since Linus quite specifically
> asked only for serious bug fixes. I think an allyesconfig build
> breakage is serious enough, but doing multiple patches for one
> bug should not be necessary and is much harder to justify.

Well, as I see, the bug is omapdrm using "select", not "depends on". So
if I'd have to pick one patch, I'd send 0003. That would fix allyesconfig.

Applying only 0003 means that omapdrm (and omapdss) won't be built on
ARCH_MULTIPLATFORM, but building omapdrm on ARCH_MULTIPLATFORM is a
feature added in this merge window, so leaving it out is not a regression.

But I'm not sure if I'm being overly pedantic here. Patch 0001 would fix
allyesconfig, and allow building omapdrm with ARCH_MULTIPLATFORM.
However, the fixing there happens as a side effect, and so the 0001
patch isn't even called a "fix" in its subject. That's the reason I'm a
bit reluctant with the 0001 patch as a fix.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130207/8ad26331/attachment.sig>
