From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 22 Apr 2018 21:41:11 +0530
Subject: [PATCH 0/6] tree-wide: simplify getting .drvdata
In-Reply-To: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180422161111.GY6014@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2018 at 11:14:08AM +0200, Wolfram Sang wrote:
> I got tired of fixing this in Renesas drivers manually, so I took the big
> hammer. Remove this cumbersome code pattern which got copy-pasted too much
> already:
> 
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
> +	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);
> 
> I send this out as one patch per directory per subsystem. I think they should
> be applied individually. If you prefer a broken out series per subsystem, I can
> provide this as well. Just mail me.

Applied all, thanks

-- 
~Vinod
