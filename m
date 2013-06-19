From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 14:06:03 +0200
Subject: [PATCH v3 11/12] ARM: mvebu: Relocate Armada 370 PCIe device tree
 nodes
In-Reply-To: <20130618214049.GA15234@localhost>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306182320.07351.arnd@arndb.de> <20130618214049.GA15234@localhost>
Message-ID: <201306191406.04120.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Ezequiel Garcia wrote:
> Although I'd like the binding to take this into account, for there's no
> point in restricting it -a priori- I can't see any advantage on doing
> fully dynamic window configuration on devices that are fixed in the
> first place. It sounds like bloating the whole thing without a strong
> need.

After the suggestions that Grant made about the of_bus, I think the
fully dynamic model would actually be simpler than what you have here.
You wouldn't actually have to dissect the "ranges" property at all,
just keep the mapping table in memory for all devices that are in use,
with a special case for the internal-regs.

But I think that's fine, we can alway simplify the code later as long
as the binding covers all cases.

	Arnd
