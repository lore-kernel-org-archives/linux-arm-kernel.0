From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Sep 2014 21:49:49 -0700
Subject: [PATCH] ARM: imx: fix .is_enabled() of shared gate clock
In-Reply-To: <1410831334-7859-1-git-send-email-shawn.guo@freescale.com>
References: <1410831334-7859-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140923044949.GA7487@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 09:35:33AM +0800, Shawn Guo wrote:
> Commit 63288b721a80 ("ARM: imx: fix shared gate clock") attempted to fix
> an issue with particular enable/disable sequence from two shared gate
> clocks.  But unfortunately, while it partially fixed the issue, it also
> did something wrong in .is_enabled() function hook.  In case of shared
> gate, the function shouldn't really query the hardware state via
> share_count, because the function is trying to query the enabling state
> of the clock in question, not the hardware state which is shared by
> multiple clocks.
> 
> Fix the issue by returning the enable_count of the clock itself which is
> maintained by clock core, in case it's a clock sharing hardware gate
> with others.  As the result, the initialization of share_count per
> hardware state is not needed now.  So remove it.
> 
> Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> Fixes: 63288b721a80 ("ARM: imx: fix shared gate clock")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Hi arm-soc folks,
> 
> Please apply it for 3.17.  Thanks.

Applied.


-Olof
