From: broonie@kernel.org (Mark Brown)
Date: Sun, 20 Oct 2013 17:38:19 +0100
Subject: [PATCH v3 2/2] ASoC: kirkwood: fix loss of external clock at
 probe time
In-Reply-To: <20131018203555.4d974251@armhf>
References: <20131018203555.4d974251@armhf>
Message-ID: <20131020163819.GO2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 08:35:55PM +0200, Jean-Francois Moine wrote:
> At probe time, when the clock driver is not yet initialized, the
> external clock of the kirkwood sound device will not be usable.

This doesn't apply against -next, could you please check and resend?

  git://git.kernel.org/pub/scm/linux/kernel/git/broone/sound.git topic/kirkwood

or the for-next branch.

> It also removes the test about same internal and external clocks which
> can never occur.

It seems like reasonable defensiveness to have the test there in case
someone has a broken DT, though it'd be better to complain about the DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131020/3521b125/attachment.sig>
