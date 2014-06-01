From: broonie@kernel.org (Mark Brown)
Date: Sun, 1 Jun 2014 11:42:02 +0100
Subject: [PATCH] spi/pxa2xx: fix runtime PM enabling order
In-Reply-To: <1401466689-24335-1-git-send-email-ao2@ao2.it>
References: <1401466689-24335-1-git-send-email-ao2@ao2.it>
Message-ID: <20140601104202.GV5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 06:18:09PM +0200, Antonio Ospite wrote:
> In commit 7dd62787334ac6e0e2a0ef3f20bb1936ac431b04 (spi/pxa2xx: Convert
> to core runtime PM) master->auto_runtime_pm was set to true.

Applied, thanks.

> I must admit I copied from 268d76430d1b68c340687357ffd18b4b12d02269 without
> understanding much of what is going on, but fact is that the patch makes my
> board boot again.

> Can anyone confirm that this is indeed the correct fix?

We need to either have the clocks and whatever enabled until runtime PM
is enabled or have runtime PM enabled before the controller and hence
clients can be registered.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140601/b01d2b66/attachment.sig>
