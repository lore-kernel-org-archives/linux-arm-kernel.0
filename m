From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 14 Mar 2013 10:22:36 -0600
Subject: [PATCH V2] ARM: mvebu: fix RAM size for Armada XP board
 DB-MV784MP-GP
In-Reply-To: <1363276674-24172-1-git-send-email-jason@lakedaemon.net>
References: <20130216164457.GA23237@titan.lakedaemon.net>
 <1363276674-24172-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20130314162236.GA19701@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 03:57:54PM +0000, Jason Cooper wrote:
> The board is supplied with a 4GB RAM module.  This value can be
> overridden by the bootloader based on probed memory size.  We set it to
> a reasonable value here.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> Changes from v1:
>  - grammatical fix suggested by Sergei Shtylyov
>  - correct size suggested by several folks (within 32bit, 1 dword)
> 
> As promised, catching this fix in the -rc cycle.
> 
> For those not familiar, earlier versions of the patch adding this board listed
> 3GB because that is all that was visible.  I mistaken applied v3 of the patch
> instead of v4 which properly listed 4GB.  This patch cleans up my error.

What happens when the kernel tries to treat 0xD0000000 and above as
memory? Lots of internal register blocks overlap 0 -> 4GB - won't this
cause resource conflicts on boot? I'm actually very surprised it boots
at all - what does /proc/iomem say?

Jason
