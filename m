From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 15 Jun 2011 15:50:37 -0400 (EDT)
Subject: [PATCH] Support multiple MEM tags with atags->fdt conversion
In-Reply-To: <1308094074-24898-1-git-send-email-davidb@codeaurora.org>
References: <1308094074-24898-1-git-send-email-davidb@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1106151540230.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Jun 2011, David Brown wrote:

> Some targets have multiple memory regions.  Parse up to 8 of these
> when converting the atags to fdt.
> 
> Signed-off-by: David Brown <davidb@codeaurora.org>

I've added your patch to my zImage patch queue.

> With this change, I am able to boot MSM8x60 combining ATAGS and my DT.
> It seems to work as long as my device tree has placeholders for all of
> the properties I need.

I think those missing nodes should simply be created if missing.  I 
however don't see any function in the libfdt API to do that -- there is 
fdt_add_subnode() but no fdt_add_node().  Any DT expert please?

Also, should the DTB be enlarged in order to add new nodes, or even 
modify existing ones with larger properties?  In other words, 
should something like fdt_move(fdt, fdt, fdt_totalsize(fdt)+HEADROOM) be 
used beforehand?


Nicolas
