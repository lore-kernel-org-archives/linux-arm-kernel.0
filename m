From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 3 Feb 2013 20:44:39 -0500
Subject: [PATCH v2] gpio: mvebu: Add clk support to prevent lockup
In-Reply-To: <1359887666-17552-1-git-send-email-andrew@lunn.ch>
References: <1359887666-17552-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130204014439.GI14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 03, 2013 at 11:34:26AM +0100, Andrew Lunn wrote:
> The kirkwood SoC GPIO cores use the runit clock. Add code to
> clk_prepare_enable() runit, otherwise there is a danger of locking up
> the SoC by accessing the GPIO registers when runit clock is not
> ticking.
> 
> Reported-by: Simon Baatz <gmbnomis@gmail.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Since v1:
> ChangeLog: tclk->runit clock
> 
>  arch/arm/boot/dts/kirkwood.dtsi |    2 ++
>  drivers/gpio/gpio-mvebu.c       |    7 +++++++
>  2 files changed, 9 insertions(+)

Linus,

I merge-tested this against your gpio/fixes branch since you had a patch
to the same file:

11c0cee gpio: mvebu: Don't free chip label memory

There were no conflicts.  If you don't mind, I'd like to take this
through mvebu/fixes -> arm-soc since this is one of four patches to fix
one reported issue.  I'd like to keep them in the same branch.

If this causes a headache for you, please let me know and you can take
it.

Otherwise, applied to mvebu/fixes with Simon's Tested-by:

thx,

Jason.
