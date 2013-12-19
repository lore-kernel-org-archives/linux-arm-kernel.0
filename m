From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Thu, 19 Dec 2013 07:08:16 +0000
Subject: [PATCH 2/3] thermal: imx: add necessary clk operation
In-Reply-To: <20131219065915.GB6691@S2101-09.ap.freescale.net>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
 <20131219065915.GB6691@S2101-09.ap.freescale.net>
Message-ID: <d067cdecda2046f5998302deed320c2a@DM2PR03MB317.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards.
Anson huang ???
?
Freescale Semiconductor Shanghai
?????????192?A?2?
201203
Tel:021-28937058


>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Thursday, December 19, 2013 2:59 PM
>To: Huang Yongcai-B20788
>Cc: kernel at pengutronix.de; rui.zhang at intel.com; eduardo.valentin at ti.com;
>devicetree at vger.kernel.org; linux-doc at vger.kernel.org; linux-arm-
>kernel at lists.infradead.org; linux-pm at vger.kernel.org
>Subject: Re: [PATCH 2/3] thermal: imx: add necessary clk operation
>
>On Thu, Dec 19, 2013 at 01:17:24PM -0500, Anson Huang wrote:
>> @@ -427,6 +429,13 @@ static int imx_thermal_probe(struct platform_device
>*pdev)
>>  		return ret;
>>  	}
>>
>> +	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(data->thermal_clk)) {
>> +		ret = IS_ERR(data->thermal_clk);
>> +		dev_err(&pdev->dev, "failed to get thermal clk!\n");
>> +		return ret;
>> +	}
>> +
>
>So when the new kernel runs on a board with an old DTB installed, thermal
>driver will be broken.
>
Yes, I thought about this case, but the previous implement is incorrect, if
the PLL3 is not enabled by other drivers, thermal driver will not work, so
this patch is a bug fix, not enhancement. So we still need to consider old
dts case? 

Anson

>Shawn
