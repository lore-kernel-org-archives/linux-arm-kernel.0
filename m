From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 9 Jun 2013 06:06:01 +0300
Subject: [PATCH 1/2] i2c-designware: support no DW_IC_COMP_TYPE platform
In-Reply-To: <1370745402-11844-2-git-send-email-zhangfei.gao@linaro.org>
References: <1370745402-11844-1-git-send-email-zhangfei.gao@linaro.org>
 <1370745402-11844-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130609030600.GA4312@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhangfei Gao,

On Sun, Jun 09, 2013 at 10:36:41AM +0800, Zhangfei Gao wrote:
> Check accessor_flags before reading DW_IC_COMP_TYPE
> Give chance to platform no such register
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/i2c/busses/i2c-designware-core.c |   24 +++++++++++++-----------
>  drivers/i2c/busses/i2c-designware-core.h |    1 +
>  2 files changed, 14 insertions(+), 11 deletions(-)

[...]

> diff --git a/drivers/i2c/busses/i2c-designware-core.h 
> b/drivers/i2c/busses/i2c-designware-core.h
> index e761ad1..b38b54e 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -94,6 +94,7 @@ struct dw_i2c_dev {
>  
>  #define ACCESS_SWAP		0x00000001
>  #define ACCESS_16BIT		0x00000002
> +#define ACCESS_32BIT		0x00000004

This belongs to the next patch, not to this one.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
