From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jun 2017 08:30:51 +0200
Subject: [GIT PULL] Allwinner clock changes for 4.13
In-Reply-To: <20170616215036.GN20170@codeaurora.org>
References: <20170614192617.bsp5pjxrphlk36sk@flea.home>
 <20170616215036.GN20170@codeaurora.org>
Message-ID: <20170620063051.j2chtseeetoh3mhe@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 02:50:36PM -0700, Stephen Boyd wrote:
> On 06/14, Maxime Ripard wrote:
> > Hi Mike, Stephen,
> > 
> > Here is the patches for 4.13 for the Allwinner SoCs.
> > 
> > In order to reduce the conflicts, this is based on the fixes tag I
> > sent a PR for a few minutes ago.
> > 
> 
> Thanks. Pulled into clk-next. I did notice on new sparse warning
> though for which I've applied this diff on top:
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
> index cfe4538304fb..312664155a54 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -68,7 +68,7 @@ unsigned long ccu_mux_helper_apply_prediv(struct ccu_common *common,
>  	return parent_rate / ccu_mux_get_prediv(common, cm, parent_index);
>  }
>  
> -unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *common,
> +static unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *common,
>  					    struct ccu_mux_internal *cm,
>  					    int parent_index,
>  					    unsigned long parent_rate)

Seems good, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/1891e26f/attachment.sig>
