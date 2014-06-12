From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Jun 2014 13:18:06 +0100
Subject: Kconfig fails: big select-based circular dependency
In-Reply-To: <CAMuHMdV0F_FhtJwrzJLbxTbQPKs1XzR=Yb0wjMw2TBuXNPObpA@mail.gmail.com>
References: <20140607090944.GL23430@n2100.arm.linux.org.uk>
 <20140612094745.GD23430@n2100.arm.linux.org.uk>
 <6077426.uLBS643pC0@wuerfel>
 <20140612113445.GF23430@n2100.arm.linux.org.uk>
 <CAMuHMdV0F_FhtJwrzJLbxTbQPKs1XzR=Yb0wjMw2TBuXNPObpA@mail.gmail.com>
Message-ID: <20140612121806.GY5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 01:57:03PM +0200, Geert Uytterhoeven wrote:

> Should we have a better separation between select and depends, i.e.
> should kconf plainly reject both being used on the same symbol?

> Is it ever valid to have a symbol that's both selected and used with depends on?

Architecture feature Kconfig symbols typically have the pattern that the
architecture selects ARCH_HAS_FOO and then code that needs the feature
depends on ARCH_HAS_FOO.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140612/87c4478b/attachment.sig>
