From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 27 Aug 2013 11:01:20 +0800
Subject: [PATCH v4 0/3] arm: mvebu: fix resource leak
In-Reply-To: <20130826204523.GD24470@titan.lakedaemon.net>
References: <1377517018-7716-1-git-send-email-jszhang@marvell.com>
 <20130826204523.GD24470@titan.lakedaemon.net>
Message-ID: <20130827110120.0a9fab2a@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason,

On Mon, 26 Aug 2013 13:45:23 -0700
Jason Cooper <jason@lakedaemon.net> wrote:

> On Mon, Aug 26, 2013 at 07:36:55PM +0800, Jisheng Zhang wrote:
> > These patches try to fix resource leak by adding missing of_node_put(),
> > iounmap or using devm_ioremap_resource() if available.
> > 
> > v4:
> >   - re-generate since Ezequiel's patches add DT support to the
> > mvebu-mbus driver
> 
> grrr.  I hate to ask this, but can you please rebase patches 1 and 2
> against mvebu/fixes-non-critical?  No need to add back in the mvebu-mbus
> hunk.

patch 1 also fixes one similar trivial issue introduced since 994c8c94b419e
"ARM: mvebu: Remove the harcoded BootROM window allocation" in linux-next tree

patch 2 is updated to fix similar trivial issue introduce since 6839cfa82f99
"bus: mvebu-mbus: Introduce device tree binding"

These two commits aren't included in mvebu/fixes-non-criticial yet. Could you
please give suggestion?

Thanks in advance,
Jisheng
