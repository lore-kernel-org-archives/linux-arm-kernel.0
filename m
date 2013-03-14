From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Mar 2013 03:10:20 +0300
Subject: [PATCH 03/10] ARM: shmobile: r8a7779: add USB EHCI clock support
In-Reply-To: <1352446165-19298-4-git-send-email-horms@verge.net.au>
References: <1352446165-19298-1-git-send-email-horms@verge.net.au>
 <1352446165-19298-4-git-send-email-horms@verge.net.au>
Message-ID: <5141156C.4010909@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/09/2012 10:29 AM, Simon Horman wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> ehci-platform driver require these clocks
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>   arch/arm/mach-shmobile/clock-r8a7779.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
> index 24f5a84..4ba4e3c 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
[...]
> @@ -153,6 +156,8 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_CON_ID("peripheral_clk",	&div4_clks[DIV4_P]),
>   
>   	/* MSTP32 clocks */
> +	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
> +	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */

    But how are those used? I don't see clk API support in ehci-platform.c.
Are they used via runtime PM? I'm just not familiar enough with it...

WBR, Sergei
