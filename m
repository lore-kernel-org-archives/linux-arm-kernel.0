From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Feb 2016 17:47:53 +0000
Subject: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D64026CB@penmbx01>
References: <1453863463-30515-1-git-send-email-wenyou.yang@atmel.com>
 <1453863463-30515-2-git-send-email-wenyou.yang@atmel.com>
 <20160129001603.GM4130@sirena.org.uk>
 <B256D81BAE5131468A838E5D7A243641D63FBF8B@penmbx01>
 <20160129113518.GQ4130@sirena.org.uk>
 <CABxcv=kNKmgRytxB5ppawrAvC-GDRhV4T_UUGvpHgKp9+BsUmQ@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A243641D63FE2C7@penmbx01>
 <CABxcv=nJsWEv9KW-5iPpUnyN8ZVpx6CV07gBRaLNWqd644YOqQ@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A243641D64026CB@penmbx01>
Message-ID: <20160203174753.GJ4455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 02:33:11AM +0000, Yang, Wenyou wrote:

> > I would just remove the "active-semi,act8945a-regulator" node and make "active-
> > semi,vsel-high" a property of the "active-semi,act8945a" node.
> > That way you can remove the mfd cell .of_compatible and OF table in the
> > regulator driver and read the "active-semi,vsel-high" using the platform device's
> > parent of_node.

> > But it's better if you wait for Mark's opinions before re-spining your patches.

> Hi Mark, what is your opinions?

Like Javier says you should make your DT binding look like the DT
bindings for other MFDs and not use of_compatible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/30814480/attachment.sig>
