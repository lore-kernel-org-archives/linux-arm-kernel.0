From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 11 Jan 2018 08:35:44 +0800
Subject: [PATCH] usb: mtu3: fix ssusb_wakeup_set dummy
In-Reply-To: <20180110164530.1399750-1-arnd@arndb.de>
References: <20180110164530.1399750-1-arnd@arndb.de>
Message-ID: <1515630944.19513.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-01-10 at 17:45 +0100, Arnd Bergmann wrote:
> Changing from ssusb_wakeup_enable/disable to ssusb_wakeup_set was done
> in only one of two places in the kernel, the other one now causes a
> build failure:
> 
> drivers/usb/mtu3/mtu3_plat.c: In function 'mtu3_suspend':
> drivers/usb/mtu3/mtu3_plat.c:462:2: error: implicit declaration of function 'ssusb_wakeup_set'; did you mean 'ssusb_wakeup_disable'? [-Werror=implicit-function-declaration]
> 
> This adapts the dummy helpers the same way that the extern declarations
> were.
> 
> Fixes: f0ede2c6282b ("usb: mtu3: supports remote wakeup for mt2712 with two SSUSB IPs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/mtu3/mtu3_dr.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_dr.h b/drivers/usb/mtu3/mtu3_dr.h
> index ae1598d76e02..50702fdcde28 100644
> --- a/drivers/usb/mtu3/mtu3_dr.h
> +++ b/drivers/usb/mtu3/mtu3_dr.h
> @@ -48,12 +48,7 @@ static inline int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
>  	return 0;
>  }
>  
> -static inline int ssusb_wakeup_enable(struct ssusb_mtk *ssusb)
> -{
> -	return 0;
> -}
> -
> -static inline void ssusb_wakeup_disable(struct ssusb_mtk *ssusb)
> +static inline void ssusb_wakeup_set(struct ssusb_mtk *ssusb, bool enable)
>  {}
>  
>  #endif
Forgot to make it change,

Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot
