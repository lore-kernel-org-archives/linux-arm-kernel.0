From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Jul 2012 20:37:30 +0000
Subject: [PATCH 07/15] ARM: dove: use fixed PCI i/o mapping
In-Reply-To: <4FFB2321.30100@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <201207091550.55912.arnd@arndb.de> <4FFB2321.30100@gmail.com>
Message-ID: <201207092037.30708.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 July 2012, Rob Herring wrote:
> Why use 1M when 64K is enough based on our prior conversations? The more
> we standardize the configuration, the more we can make common. I think
> the majority of the pci setup functions can be consolidated. It's really
> just data differences for the resource setup. I only used 1M alignment
> in case there were some alignment requirements in the h/w and it can't
> handle a starting pci bus address of 0x10000. I think it's just the
> Marvell parts that do this, so if anyone knowledgeable on those parts
> can comment it would help.

IIRC among the plat-orion platforms (dove, kirkwood, mv78xx0, orion), this
one is the only one where you use 64kb in the resource but 1MB for the
mapping, while in the other ones they are always the same. I agree that
the 64kb resource doesn't hurt, we should just be more consistent.

	Arnd
