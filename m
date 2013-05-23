From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 23 May 2013 13:42:34 -0400
Subject: [PATCH] ARM: mvebu: Fix bug in coherency fabric low level init
 function
In-Reply-To: <1369299242-16506-2-git-send-email-gregory.clement@free-electrons.com>
References: <1369299242-16506-1-git-send-email-gregory.clement@free-electrons.com>
 <1369299242-16506-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130523174234.GS31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
> 
> [gregory.clement at free-electrons.com: fixed the commit's topic]
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency_ll.S | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
