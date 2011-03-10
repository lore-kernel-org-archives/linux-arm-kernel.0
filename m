From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 09 Mar 2011 19:36:16 -0800
Subject: [Qualcomm PM8921 MFD v2 4/6] mfd: pm8xxx-mpp: Add pm8xxx MPP
	driver
In-Reply-To: <20110308233045.GB2717@opensource.wolfsonmicro.com>
References: <1299564590-30116-1-git-send-email-adharmap@codeaurora.org>
	<1299564590-30116-5-git-send-email-adharmap@codeaurora.org>
	<20110308233045.GB2717@opensource.wolfsonmicro.com>
Message-ID: <4D784730.4010307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Mon, Mar 07, 2011 at 10:09:48PM -0800, adharmap at codeaurora.org wrote:
> 
>> +	mpp_chip->gpio_chip.label = PM8XXX_MPP_DEV_NAME;
>> +	mpp_chip->gpio_chip.direction_input = pm8xxx_mpp_dir_input;
>> +	mpp_chip->gpio_chip.direction_output = pm8xxx_mpp_dir_output;
>> +	mpp_chip->gpio_chip.to_irq = pm8xxx_mpp_to_irq;
>> +	mpp_chip->gpio_chip.get = pm8xxx_mpp_get;
>> +	mpp_chip->gpio_chip.set = pm8xxx_mpp_set;
>> +	mpp_chip->gpio_chip.dbg_show = pm8xxx_mpp_dbg_show;
>> +	mpp_chip->gpio_chip.ngpio = pdata->core_data.nmpps;
>> +	mpp_chip->gpio_chip.can_sleep = 1;
>> +	mpp_chip->gpio_chip.dev = &pdev->dev;
>> +	mpp_chip->gpio_chip.base = pdata->mpp_base;
> 
> It's seems really odd that you're adding gpiolib stuff here when you've
> also got a separate gpiolib driver.  Possibly this all shouldn't
> actually be split up as much as it is - there's also the issue with the
> gpiolib driver needing to peer into the interrupt controller.  It might
> simplify the code if things were merged more.

I dont think merging code will help here. gpio lines and mpp lines are 
very different piece of hardware,they have a different register map and 
different config attributes. They do fall under the generic 'gpiolib' 
umbrella, but it seems clean to keep them separate.

I agree with you that gpio code needs to call on interrupt controller ( 
a complicated hardware design) but I think I have a clean software 
implementation to manage it.

-- 
--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
