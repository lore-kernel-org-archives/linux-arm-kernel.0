From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Oct 2016 22:10:20 +0200
Subject: [PATCH] nvmem: sunxi-sid: SID content is not a valid source of
 randomness
In-Reply-To: <1477144408-15896-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1477144408-15896-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20161024201020.h6akyqad2o42xkhq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 22, 2016 at 03:53:28PM +0200, Corentin Labbe wrote:
> Since SID's content is constant over reboot,

That's not true, at least not across all the Allwinner SoCs, and
especially not on the A10 and A20 that this driver supports.

> it must not be used as source of randomness.

And I don't think that's true either. A constant entropy provider will
not add any entropy, but will not remove any, would it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/1739c38f/attachment.sig>
