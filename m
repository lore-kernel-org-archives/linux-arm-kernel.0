From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 16 Nov 2010 14:38:08 -0500
Subject: [PATCH v5 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <4CE1B651.1060006@bluewatersys.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-9-git-send-email-cyril@ti.com>
	<4CE1B651.1060006@bluewatersys.com>
Message-ID: <4CE2DDA0.1030404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2010 05:38 PM, Ryan Mallon wrote:
> On 11/16/2010 08:12 AM, Cyril Chemparathy wrote:
>> TI's SSP controller pins can be directly read and written to behave like a
>> GPIO.  This patch adds a GPIO driver that exposes such functionality.
>>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> ---
[...]
>> +	spin_lock_init(&gpio->lock);
>> +	platform_set_drvdata(pdev, gpio);
>> +
>> +	gpio->chip.base  = pdata->start;
>> +	gpio->chip.ngpio = 4;
> 
> Is this always four or can the SSP peripheral be configured to have
> varying numbers of gpios. Maybe the number of gpios should be passed via
> platform data?
> 

This can only be 4 (hw defined per-port limit).

I have changed as per your other comments, and will post an update.

Thanks
Cyril.
