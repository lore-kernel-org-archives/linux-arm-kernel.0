From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Apr 2013 16:59:54 +0200
Subject: [PATCHv7 07/17] clk: mvebu: add more PCIe clocks for Armada XP
In-Reply-To: <1364395234-11195-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364395234-11195-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130405165954.03e08f1a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Could we have your opinion on the below patch, and possibly an Acked-by
to carry it through the arm-soc tree?

Thanks,

Thomas

On Wed, 27 Mar 2013 15:40:24 +0100, Thomas Petazzoni wrote:
> The current revision of the datasheet only mentions the gatable clocks
> for the PCIe 0.0, 0.1, 0.2 and 0.3 interfaces, and forgot to mention
> the ones for the PCIe 1.0, 1.1, 1.2, 1.3, 2.0 and 3.0
> interfaces. After confirmation with Marvell engineers, this patch adds
> the missing gatable clocks for those PCIe interfaces.
> 
> It also changes the name of the previously existing PCIe gatable
> clocks, in order to match the naming using the datasheets.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/clk/mvebu/clk-gating-ctrl.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
> index b35785a..2f03723 100644
> --- a/drivers/clk/mvebu/clk-gating-ctrl.c
> +++ b/drivers/clk/mvebu/clk-gating-ctrl.c
> @@ -137,10 +137,14 @@ static const struct mvebu_soc_descr __initconst armada_xp_gating_descr[] = {
>  	{ "ge2", NULL,  2 },
>  	{ "ge1", NULL, 3 },
>  	{ "ge0", NULL, 4 },
> -	{ "pex0", NULL, 5 },
> -	{ "pex1", NULL, 6 },
> -	{ "pex2", NULL, 7 },
> -	{ "pex3", NULL, 8 },
> +	{ "pex00", NULL, 5 },
> +	{ "pex01", NULL, 6 },
> +	{ "pex02", NULL, 7 },
> +	{ "pex03", NULL, 8 },
> +	{ "pex10", NULL, 9 },
> +	{ "pex11", NULL, 10 },
> +	{ "pex12", NULL, 11 },
> +	{ "pex13", NULL, 12 },
>  	{ "bp", NULL, 13 },
>  	{ "sata0lnk", NULL, 14 },
>  	{ "sata0", "sata0lnk", 15 },
> @@ -152,6 +156,8 @@ static const struct mvebu_soc_descr __initconst armada_xp_gating_descr[] = {
>  	{ "xor0", NULL, 22 },
>  	{ "crypto", NULL, 23 },
>  	{ "tdm", NULL, 25 },
> +	{ "pex20", NULL, 26 },
> +	{ "pex30", NULL, 27 },
>  	{ "xor1", NULL, 28 },
>  	{ "sata1lnk", NULL, 29 },
>  	{ "sata1", "sata1lnk", 30 },



-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
