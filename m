From: horms@verge.net.au (Simon Horman)
Date: Sat, 25 May 2013 14:30:10 +0900
Subject: [PATCH v2] ARM: shmobile: BOCK-W: add Ether support
In-Reply-To: <201305170141.59791.sergei.shtylyov@cogentembedded.com>
References: <201305170141.59791.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130525053007.GA9293@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 01:41:59AM +0400, Sergei Shtylyov wrote:
> Register Ether device from bockw_init(), passing the platform data to it, adding
> only the RMII pin group to bockw_pinctrl_map[].  Although the LINK signal exists
> on the board, it's connected to the link/activity LED  output of the PHY, thus
> the link disappears and reappears after each packet. We'd be better off ignoring
> such signal and getting the link state from the PHY indirectly.
> 
> Also, Ether has pin conflict with VIN1, so the latter is not registered when the
> 'sh_eth' driver is enabled now.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is atop of Simon's 'renesas.git' repo, 'renesas-next-20130515v2' tag
> and my recent yet unapplied patches.
> 
> Note that it's compile and run time dependent on the current Linus' tree. 
> 
> Changes from the original posting:
> - refreshed the patch.

Thanks, would it be possible for you to rebase it on top of
renesas-next-20130523.

renesas-next-20130523 is based on v3.10-rc2, so I think it should
have whatever dependencies that were in Linus's tree at the time
that you posted this patch.
