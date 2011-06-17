From: davidb@codeaurora.org (David Brown)
Date: Fri, 17 Jun 2011 13:23:07 -0700
Subject: [PATCH] Support multiple MEM tags with atags->fdt conversion
In-Reply-To: <alpine.LFD.2.00.1106151540230.2142@xanadu.home> (Nicolas Pitre's
	message of "Wed, 15 Jun 2011 15:50:37 -0400 (EDT)")
References: <1308094074-24898-1-git-send-email-davidb@codeaurora.org>
	<alpine.LFD.2.00.1106151540230.2142@xanadu.home>
Message-ID: <8yalix0qkb8.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15 2011, Nicolas Pitre wrote:

> I think those missing nodes should simply be created if missing.  I 
> however don't see any function in the libfdt API to do that -- there is 
> fdt_add_subnode() but no fdt_add_node().  Any DT expert please?
>
> Also, should the DTB be enlarged in order to add new nodes, or even 
> modify existing ones with larger properties?  In other words, 
> should something like fdt_move(fdt, fdt, fdt_totalsize(fdt)+HEADROOM) be 
> used beforehand?

I've tried adding some padding to my DTB by passing '-p 1024'.  It does
seem to try and do something, but I'm getting a fault in memmove() from
fdt_splice() that I'm still trying to track down.

It looks like the expansion is possible, though, at least once
everything is right.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
