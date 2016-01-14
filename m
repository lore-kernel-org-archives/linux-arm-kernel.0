From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 14 Jan 2016 14:00:21 +0000
Subject: [PATCH net-next 08/10] bus: mvenus-mbus: Fix size test for
 mvebu_mbus_get_dram_win_info
In-Reply-To: <1452625834-22166-9-git-send-email-gregory.clement@free-electrons.com>
References: <1452625834-22166-1-git-send-email-gregory.clement@free-electrons.com>
 <1452625834-22166-9-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CCC5C65@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT
> Sent: 12 January 2016 19:11
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
>  	for (i = 0; i < dram->num_cs; i++) {
>  		const struct mbus_dram_window *cs = dram->cs + i;
> 
> -		if (cs->base <= phyaddr && phyaddr <= (cs->base + cs->size)) {
> +		if (cs->base <= phyaddr && phyaddr <= (cs->base + cs->size - 1)) {

Wouldn't it be better to change the line to:
> +		if (cs->base <= phyaddr && phyaddr < (cs->base + cs->size)) {

	David
