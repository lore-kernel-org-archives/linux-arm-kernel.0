From: rjui@broadcom.com (Ray Jui)
Date: Fri, 16 Jan 2015 14:52:37 -0800
Subject: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150115120704.GB2549@katana>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de> <20150115120704.GB2549@katana>
Message-ID: <54B99635.3090905@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/15/2015 4:07 AM, Wolfram Sang wrote:
>>> +static int bcm_iproc_i2c_remove(struct platform_device *pdev)
>>> +{
>>> +	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
>>> +
>>> +	i2c_del_adapter(&iproc_i2c->adapter);
>> You need to free the irq before i2c_del_adapter.
> 
> One could also keep using devm_request_irq and disable all interrupts
> sources here?
> 
Okay this makes sense. Will use devm_request_irq and disable interrupt
in the remove function. Thanks.

> Thanks for the reviews, Uwe!
> 
>    Wolfram
> 
