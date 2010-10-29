From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 29 Oct 2010 00:12:14 -0400 (EDT)
Subject: [PATCH] ARM: orion5x/kirkwood/mv78xx0: fix MPP configuration
	corner cases
In-Reply-To: <1287907960-31563-1-git-send-email-mike@compulab.co.il>
References: <1287907960-31563-1-git-send-email-mike@compulab.co.il>
Message-ID: <alpine.LFD.2.00.1010290007070.6603@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 24 Oct 2010, Mike Rapoport wrote:

> Wrong MPP configuration would cause <cpu>_mpp_conf loop	infinitely
> because the mpp list iterator would not be incremented.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  arch/arm/mach-kirkwood/mpp.c |    5 +++--
>  arch/arm/mach-mv78xx0/mpp.c  |    5 +++--
>  arch/arm/mach-orion5x/mpp.c  |    5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
[...]

Instead of adding gotos, could you simply replace the 
"while (*mpp_list)" loop with "for ( ; *mpp_list; mpp_list++)" ?


Nicolas
