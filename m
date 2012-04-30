From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Apr 2012 09:25:46 +0100
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <20120425185747.GC24211@n2100.arm.linux.org.uk>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org> <20120425185747.GC24211@n2100.arm.linux.org.uk>
Message-ID: <4F9E4C8A.8010807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/12 19:57, Russell King - ARM Linux wrote:
> On Mon, Apr 16, 2012 at 10:26:08AM +0100, Lee Jones wrote:
>> +	/* Must have platform data or Device Tree. */
>> +	if (!plat&&  !np) {
>> +		dev_err(&dev->dev, "No plat data or DT found\n");
>> +		return -EINVAL;
>>   	}
>>
>> +	if (np)
>> +		mmci_dt_populate_generic_pdata(np, plat);
>
> Please tell me what happens if plat is NULL, but we're running on a DT
> enabled platform.  Something tells me that you might just want to fix
> that case _before_ I apply your patch.


Sorry for the response delay, I've been incredibly busy with other DT 
enablement.

You're right, I need to allocate memory for platform_data in 
mmci_dt_populate_generic_pdata. This must have worked by chance when I 
tested it. I will draft up another patch and send it to you as soon as I 
can free up some time.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
