From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 21 Mar 2011 16:39:57 +0300
Subject: [PATCH 17/20] video: msm: Prevent framebuffer glitch
	during	initialization
In-Reply-To: <1300485574-27600-1-git-send-email-carlv@codeaurora.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
	<1300485574-27600-1-git-send-email-carlv@codeaurora.org>
Message-ID: <4D87552D.4070205@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Carl Vanderlip wrote:

> Holds a reference to the mdp_clk until lateinit, and moves the frambuffer
> initialization to device_init.

    Maybe I'm just blind but I don't see where the patch does the latter...

> The framebuffer lcdc driver will grab a
> reference to mdp_clk, which prevents the clock from being disabled by
> clock_late_init.

> Authors:
> Dima Zavin <dima@android.com>
> Rebecca Schultz Zavin <rebecca@android.com>
> Colin Cross <ccross@android.com>

> Signed-off-by: Carl Vanderlip <carlv@codeaurora.org>
> ---
>  drivers/video/msm/mdp.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)

> diff --git a/drivers/video/msm/mdp.c b/drivers/video/msm/mdp.c
> index 0bb19fa..b3f334ad 100644
> --- a/drivers/video/msm/mdp.c
> +++ b/drivers/video/msm/mdp.c
> @@ -38,6 +38,7 @@ struct class *mdp_class;
>  
>  static DECLARE_WAIT_QUEUE_HEAD(mdp_ppp_waitqueue);
>  static unsigned int mdp_irq_mask;
> +struct clk *mdp_clk_to_disable_later;

    Why not just 'mdp_clk'? :-)

WBR, Sergei
