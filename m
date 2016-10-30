From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 30 Oct 2016 06:45:39 +0200
Subject: [PATCH -next] i2c: digicolor: use clk_disable_unprepare instead
 of clk_unprepare
In-Reply-To: <1477758677-7831-1-git-send-email-weiyj.lk@gmail.com>
References: <1477758677-7831-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20161030044539.whnwlup6aetqbe6p@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei Yongjun,

On Sat, Oct 29, 2016 at 04:31:17PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> since clk_prepare_enable() is used to get i2c->clk, we should
> use clk_disable_unprepare() to release it for the error path.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

>  drivers/i2c/busses/i2c-digicolor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-digicolor.c b/drivers/i2c/busses/i2c-digicolor.c
> index 49f2084..50813a2 100644
> --- a/drivers/i2c/busses/i2c-digicolor.c
> +++ b/drivers/i2c/busses/i2c-digicolor.c
> @@ -347,7 +347,7 @@ static int dc_i2c_probe(struct platform_device *pdev)
>  
>  	ret = i2c_add_adapter(&i2c->adap);
>  	if (ret < 0) {
> -		clk_unprepare(i2c->clk);
> +		clk_disable_unprepare(i2c->clk);
>  		return ret;
>  	}

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
