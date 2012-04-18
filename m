From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 18 Apr 2012 09:16:35 -0400
Subject: [PATCH V5 0/4] ARM: Kirkwood: Add support for DNS-320 and
 DNS-325 using devicetree
In-Reply-To: <1334743603-8488-1-git-send-email-jm@lentin.co.uk>
References: <1334743603-8488-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20120418131635.GK15711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 11:06:39AM +0100, Jamie Lentin wrote:
> Reworked patch for latest feedback. I'm still basing this on Jason Cooper's
> tree, given how much time has passed should I be rebasing against something
> else or is this still fine?

Typically, work should be based against a stable tag.  In this case, the
changes in my branch were merged in for 3.4-rc1, so you could base from
there.

It's fine the way it is, I'll let you know if I run into any problems.

> One thing I noticed is that with only the first patch applied (which no
> longer calls kirkwood_nand_init) the device either locks up or serial console
> dies at "Gating clock of unused units", presumably as CGC_RUNIT isn't set.
> Is this something known or is it worth further investigation?

That could potentially mess up a future bisect.  However, it would only
crop up for dnskw boards.  I'll let Grant weigh in on this since he's
the one who asked that the nand init be removed.

thx,

Jason.
