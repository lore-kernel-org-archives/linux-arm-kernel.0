From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Sep 2013 20:40:09 -0400
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131001004009.GK31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 06:03:29PM -0300, Ezequiel Garcia wrote:
> These clocks should never be gated, since the ethernet interfaces forget
> the assigned MAC address assigned if their clock source is turned off.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Cc: Mike Turquette <mturquette@linaro.org>
> 
>  drivers/clk/mvebu/kirkwood.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

I'm inclined to leave this as a hack in board-dt.c...  At some point we
are going to move kirkwood over to mach-mvebu/, and there will be eyes
on the code.  There's less chance of 're-discovering' this for cleanup
if it's in the clock driver, looking all proper and such.  Even with the
clear comment.

thx,

Jason.
