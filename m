From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 12 Jan 2016 22:42:49 +0100
Subject: [PATCH net-next 08/10] bus: mvenus-mbus: Fix size test for
 mvebu_mbus_get_dram_win_info
In-Reply-To: <1452625834-22166-9-git-send-email-gregory.clement@free-electrons.com>
References: <1452625834-22166-1-git-send-email-gregory.clement@free-electrons.com>
 <1452625834-22166-9-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKcDNPY=h37ZiVp8nESmeCZYHBuU0q30D0NoymWoTvz+wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,



2016-01-12 20:10 GMT+01:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/bus/mvebu-mbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index 3d1c0c3880ec..214bb964165b 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -964,7 +964,7 @@ int mvebu_mbus_get_dram_win_info(phys_addr_t phyaddr, u8 *target, u8 *attr)
>         for (i = 0; i < dram->num_cs; i++) {
>                 const struct mbus_dram_window *cs = dram->cs + i;
>
> -               if (cs->base <= phyaddr && phyaddr <= (cs->base + cs->size)) {
> +               if (cs->base <= phyaddr && phyaddr <= (cs->base + cs->size - 1)) {
>                         *target = dram->mbus_dram_target_id;
>                         *attr = cs->mbus_attr;
>                         return 0;
> --

Except for a typo in the commit log, the fix is good.
If you wish you can add
Reviewed-by: Marcin Wojtas <mw@semihalf.com>

Best regards,
Marcin
