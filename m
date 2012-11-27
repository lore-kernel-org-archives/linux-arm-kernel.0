From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 26 Nov 2012 17:19:49 -0800
Subject: [PATCH] ARM: use clockevents_config_and_register() where possible
In-Reply-To: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
References: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20121127011949.GA3429@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 09:34:17PM +0800, Shawn Guo wrote:
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-at91/at91rm9200_time.c     |    7 ++-----
>  arch/arm/mach-cns3xxx/core.c             |   13 +++----------

I no longer have an access to cns3xxx, but it looks good:

Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks,
Anton.
