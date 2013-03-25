From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 25 Mar 2013 11:21:13 -0600
Subject: [PATCH] [ARM] Feroceon: fix kexec by setting outer_cache.inv_all
In-Reply-To: <514E0D70.3060202@grapecom.com>
References: <514E0D70.3060202@grapecom.com>
Message-ID: <20130325172113.GC16690@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 10:15:44PM +0200, Elijah Ragozin wrote:
> Hello,
> 
> I have a simple fix for kexec on Marvell Feroceon SoC.
> Originally created and tested on kernel version 2.6.39.2,
> but appliable for the 3.9 kernel as well.
> Could you pls review. The patch is below.

Hmm, I am using kexec on Kirkwood (a Feroceon SOC) and haven't had any
problems with L2 coherency.. What exactly goes wrong here?

The only reason I could think of that this would make a difference is
if something along the boot path was turning on/off the L2? However if
you turn off the L2 then it needs to be invalidated before it is
turned on again. enable_l2 already does this properly..

Is the decompressor fiddling with the L2?

Jason
