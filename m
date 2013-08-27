From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Aug 2013 10:42:53 -0400
Subject: [PATCH v5 0/3] arm: mvebu: fix resource leak
In-Reply-To: <1377578476-3268-1-git-send-email-jszhang@marvell.com>
References: <1377578476-3268-1-git-send-email-jszhang@marvell.com>
Message-ID: <20130827144253.GC19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jisheng,

On Tue, Aug 27, 2013 at 12:41:13PM +0800, Jisheng Zhang wrote:
> These patches try to fix resource leak by adding missing of_node_put(),
> iounmap or using devm_ioremap_resource() if available.
> 
> v5:
>   - rebase against mvebu/fixes-non-critical

Thanks!

> v4:
>   - re-generate since Ezequiel's patches add DT support to the
> mvebu-mbus driver
> 
> v3:
>   - remove the clk patch since it's already taken by Mike
>   - Add more commit log as suggested by Ezequiel Garcia
> 
> v2:
>   - use devm_ioremap_resource() as suggested by Ezequiel Garcia
>   - use gates_out instead of bail_out as suggested by Mike Turquette
> 
> Jisheng Zhang (3):
>   arm: mvebu: add missing of_node_put() to fix reference leak
>   bus: mvebu: add missing of_node_put() to fix reference leak

Applied patched 1 and 2 to mvebu/fixes-non-critical,

>   pinctrl: mvebu: Convert to use devm_ioremap_resource

Previously Acked patch 3 for LinusW

thx,

Jason.
