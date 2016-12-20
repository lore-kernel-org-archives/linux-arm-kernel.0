From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Tue, 20 Dec 2016 13:57:58 +0530
Subject: [PATCH -next] phy: rockchip-typec: fix non static symbol warnings
In-Reply-To: <1474470325-32139-1-git-send-email-weiyj.lk@gmail.com>
References: <1474470325-32139-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <CAFp+6iF6BmieCDUvxhJ+-s0RNfKfzi1yi8YHnNB1jUEUNFGO4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 8:35 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fixes the following sparse warnings:
>
> drivers/phy/phy-rockchip-typec.c:295:16: warning:
>  symbol 'usb3_pll_cfg' was not declared. Should it be static?
> drivers/phy/phy-rockchip-typec.c:312:16: warning:
>  symbol 'dp_pll_cfg' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/phy/phy-rockchip-typec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
> index 7cfb0f8..555604c 100644
> --- a/drivers/phy/phy-rockchip-typec.c
> +++ b/drivers/phy/phy-rockchip-typec.c
> @@ -292,7 +292,7 @@ struct phy_reg {
>         u32 addr;
>  };
>
> -struct phy_reg usb3_pll_cfg[] = {
> +static struct phy_reg usb3_pll_cfg[] = {

const as well ?

>         { 0xf0,         CMN_PLL0_VCOCAL_INIT },
>         { 0x18,         CMN_PLL0_VCOCAL_ITER },
>         { 0xd0,         CMN_PLL0_INTDIV },
> @@ -309,7 +309,7 @@ struct phy_reg usb3_pll_cfg[] = {
>         { 0x8,          CMN_DIAG_PLL0_LF_PROG },
>  };
>
> -struct phy_reg dp_pll_cfg[] = {
> +static struct phy_reg dp_pll_cfg[] = {

const ?
[..]


Thanks
Vivek

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
