From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 7 Apr 2016 10:48:57 +0800
Subject: [PATCH v2 2/3] ARM: imx6: rework GPC to support multiple power
 domains
In-Reply-To: <1458128514-9560-2-git-send-email-l.stach@pengutronix.de>
References: <1458128514-9560-1-git-send-email-l.stach@pengutronix.de>
 <1458128514-9560-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20160407024857.GA3111@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 12:41:53PM +0100, Lucas Stach wrote:
> This largely reworks the GPC driver to better accommodate multiple
> power domains. This allows to extend the driver to support more domains
> (like present on i.MX6SX) easily later on.
> 
> Compatibility to the old DT bindings is provided to keep the currently
> supported i.MX6 devices working with the same feature level as before.
> New DTs and SoC support should only use the new binding from now on.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2: correct spelling in commit message
> ---
>  arch/arm/mach-imx/gpc.c | 435 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 329 insertions(+), 106 deletions(-)

There are too many changes in this single patch.  It makes the review
quite difficult.  Is it possible to split it a bit into some incremental
patches?

Also please rebase against v4.6-rc1, which has the commit eaa2d73ef998
(ARM: imx6: pm: declare pm domain latency on power_state struct)
conflicting with your changes.

Shawn
