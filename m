From: b32955@freescale.com (Huang Shijie)
Date: Fri, 24 May 2013 10:42:53 +0800
Subject: [PATCH V2 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <20130523101921.GM18614@n2100.arm.linux.org.uk>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <1369296978-7669-2-git-send-email-b32955@freescale.com>
 <20130523101921.GM18614@n2100.arm.linux.org.uk>
Message-ID: <519ED3AD.6040403@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?23? 18:19, Russell King - ARM Linux ??:
> On Thu, May 23, 2013 at 04:16:13PM +0800, Huang Shijie wrote:
>> +	/* get the clock */
>> +	weim->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(weim->clk))
>> +		goto weim_err;
>> +
>> +	clk_prepare_enable(weim->clk);
> I notice people are getting lazy about this.  clk_prepare_enable() can
> return an error...
>
i will add the error check in next version.

thanks
Huang Shijie
