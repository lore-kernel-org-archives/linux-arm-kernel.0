From: w@1wt.eu (Willy Tarreau)
Date: Thu, 23 May 2013 20:15:19 +0200
Subject: [PATCH] ARM: mvebu: Fix bug in coherency fabric low level init
 function
In-Reply-To: <1369299242-16506-2-git-send-email-gregory.clement@free-electrons.com>
References: <1369299242-16506-1-git-send-email-gregory.clement@free-electrons.com>
 <1369299242-16506-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130523181519.GF2680@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Thu, May 23, 2013 at 10:54:02AM +0200, Gregory CLEMENT wrote:
> From: Nadav Haklai <nadavh@marvell.com>
> 
> When adding CPU to the SMP group and enabling the coherency on this
> CPU we must protect the register access.
> The previous implementation claims to be atomic but doesn't provide
> any protection against parallel access to the coherency fabric control
> and configuration registers.
> 
> This patch fixes this by using the ldrex and strex mechanism.
> This method should be used in all accesses to those registers.

I don't know how to tell whether the fix works since it's unclear
to me what issue it fixes, but at least I can say that it doesn't
break my armada370 on 3.10-rc2 + latest fixes from your dev branch.

Best regards,
Willy
