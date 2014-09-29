From: varkabhadram@gmail.com (Varka Bhadram)
Date: Mon, 29 Sep 2014 15:43:16 +0530
Subject: [PATCH v2] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <20140929101319.GB1559@katana>
References: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com>
 <54292F74.2030209@gmail.com> <20140929101319.GB1559@katana>
Message-ID: <542930BC.4040806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2014 03:43 PM, Wolfram Sang wrote:
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> Error checking on *res*...?
>>
>> We should *return* on platform_get_resource() failure..
>>
>>> +	base = devm_ioremap_resource(&pdev->dev, res);
> Nope. devm_ioremap_resource does that.
>
Yes it will [1]. Thanks for the clarification.

[1]:http://lxr.free-electrons.com/source/lib/devres.c#L117

-- 
Regards,
Varka Bhadram.
