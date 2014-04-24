From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 24 Apr 2014 09:31:54 +0900
Subject: [PATCH 35/38] mmc: dw_mmc: call mmc_of_parse to fill in common
 options
In-Reply-To: <E1Wd2Xd-0003we-7P@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2Xd-0003we-7P@rmk-PC.arm.linux.org.uk>
Message-ID: <53585B7A.3@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear, Russell.

I didn't know which version you have checked.
But I have known that mmc_of_parse() have already included at mmc-next repository.

commit 6ca5c60605dde3420ce7fee6f93ec4a7c7924848
Author: Jaehoon Chung <jh80.chung@gmail.com>
Date:   Mon Mar 3 11:36:41 2014 +0900

    mmc: dw_mmc: use the mmc_of_parse() instead of local parser

    mmc_of_parse() have been already parsed the general capability.
    Didn't need to use the local parser.

    Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
    Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    Signed-off-by: Chris Ball <chris@printf.net>

Could you check it, plz?

Best Regards,
Jaehoon Chung

On 04/24/2014 04:09 AM, Russell King wrote:
> From: Olof Johansson <olof@lixom.net>
> 
> The shared of parse function fills in common options for capabilities,
> etc, but it needs to be called from each driver that wants to make use
> of it. dw_mmc was missing the call.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index cced599d5aeb..a2c12ebb376e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2140,6 +2140,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	if (!mmc)
>  		return -ENOMEM;
>  
> +	mmc_of_parse(mmc);
> +
>  	slot = mmc_priv(mmc);
>  	slot->id = id;
>  	slot->mmc = mmc;
> 
