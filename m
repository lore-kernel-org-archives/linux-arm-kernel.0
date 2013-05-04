From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 4 May 2013 14:12:27 -0400
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <5182EAA0.9070208@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <alpine.LFD.2.02.1305022324371.2891@ionos>
 <5182E11E.5010103@gmail.com> <201305030009.57041.arnd@arndb.de>
 <5182EAA0.9070208@gmail.com>
Message-ID: <20130504181227.GN31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 12:37:20AM +0200, Sebastian Hesselbarth wrote:
> (@Jason C: Are you sure that I should merge dove and orion
> irqchip patches? I doubt that anything touching generic irq
> will not go through irq tree.)

Putting them in the same patch series does not imply they have to go
through the same tree.  But it *does* allow us to see relationships,
conflicts, etc.

Based on how the finally dependencies work out, we may ask the irq
maintainers for an Ack to take it through arm-soc.  This would happen if
we can't remove the dependency between the trees.  The resulting
potential merge conflicts weigh into it, and that's where the irqchip
maintainer's Ack get decided.

If the changes to irqchip are just Makefile/Kconfig, then it's easy.
However, if several other files are changed and conflicting, then we let
it go through irqchip and wait one merge window for the board changes
depending on it.

The goal here is to identify and remove branch dependencies within
arm-soc and between arm-soc and other trees.  A secondary goal is to
identify high-risk series (risk of being dropped), and keep them
in separate branches from other changes.

thx,

Jason.
