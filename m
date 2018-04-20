From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 20 Apr 2018 15:46:24 +0800
Subject: [PATCH 55/61] usb: mtu3: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-56-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-56-wsa+renesas@sang-engineering.com>
Message-ID: <1524210384.25162.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Thu, 2018-04-19 at 16:06 +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/usb/mtu3/mtu3_plat.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index 628d5ce356ca..46551f6d16fd 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -447,8 +447,7 @@ static int mtu3_remove(struct platform_device *pdev)
>   */
>  static int __maybe_unused mtu3_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
> +	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
>  
>  	dev_dbg(dev, "%s\n", __func__);
>  
> @@ -466,8 +465,7 @@ static int __maybe_unused mtu3_suspend(struct device *dev)
>  
>  static int __maybe_unused mtu3_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
> +	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
>  	int ret;
>  
>  	dev_dbg(dev, "%s\n", __func__);

Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks
