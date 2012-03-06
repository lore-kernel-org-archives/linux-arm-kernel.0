From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 06 Mar 2012 15:40:07 +0900
Subject: [PATCH 2/2] mmc: sdhci-s3c: Enable runtime power management
In-Reply-To: <20120305115209.GA3224@opensource.wolfsonmicro.com>
References: <4F51697C.40408@samsung.com>
 <1330735602-22409-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1330735602-22409-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F549A0A.5020402@samsung.com>
 <20120305115209.GA3224@opensource.wolfsonmicro.com>
Message-ID: <4F55B147.6010304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
 
On 03/05/2012 08:52 PM, Mark Brown wrote:

> On Mon, Mar 05, 2012 at 07:48:42PM +0900, Jaehoon Chung wrote:
>> On 03/03/2012 09:46 AM, Mark Brown wrote:
> 
>>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> 
>> Could you explain why use 50ms? 
> 
> It's essentially a random number, some other devices use the same one.
> We're just trying to avoid suspending between back to back requests.
> 
>>> +	pm_runtime_use_autosuspend(&pdev->dev);
>>> +	pm_suspend_ignore_children(&pdev->dev, 1);
> 
>> Is there reason that ignore_children use to set the true?
> 
> So that we can suspend the host without having to have the MMC card
> suspended (the host suspend is not visible to the card).
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
