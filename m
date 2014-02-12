From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 12 Feb 2014 15:11:31 -0800
Subject: [PATCH] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
In-Reply-To: <1392026859-4977-1-git-send-email-21cnbao@gmail.com>
References: <1392026859-4977-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20140212231131.GA29769@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

On Mon, Feb 10, 2014 at 06:07:39PM +0800, Barry Song wrote:
>  
>  static int sirfsoc_pwrc_remove(struct platform_device *pdev)
>  {
> +	struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(&pdev->dev);
> +
>  	device_init_wakeup(&pdev->dev, 0);
>  
> +	cancel_delayed_work_sync(&pwrcdrv->work);
> +

This is racy: interrupt is freed later and can schedule work again.

Thanks.

-- 
Dmitry
