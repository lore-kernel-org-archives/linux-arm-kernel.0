From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Oct 2014 11:22:43 +0000
Subject: [PATCH] audio: sai: Add Power Management support
In-Reply-To: <718ee124537a4f4091bdf5242d256705@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1414552896-20797-1-git-send-email-b18965@freescale.com>
 <20141029113634.GF18557@sirena.org.uk>
 <718ee124537a4f4091bdf5242d256705@BY2PR0301MB0613.namprd03.prod.outlook.com>
Message-ID: <20141030112243.GV18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 03:30:40AM +0000, Li.Xiubo at freescale.com wrote:

> One more thing, if the device is not performance critical, then shouldn't we
> Take care of the cache memory consumption to determine using flat or rbtree
> Type ?

Yes, it's always fine to use a rbtree if it makes sense - it was just an
unusual choice for a device like this that didn't seem to be discussed.

Depending on the register map a flat cache can actually be more memory
efficient sometimes since there's some overhead for the rbtree data
structures, if you've just got one block of registers with no gaps a
flat cache is going to be a win there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/56a2912c/attachment.sig>
