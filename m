From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 11 Jan 2018 15:14:37 -0800
Subject: [linux, dev-4.10, 6/6] drivers/hwmon: Add a driver for a generic
 PECI hwmon
In-Reply-To: <20180111221845.GA9278@lunn.ch>
References: <20180109223126.13093-7-jae.hyun.yoo@linux.intel.com>
 <20180110214747.GA25248@roeck-us.net>
 <261ac28e-813c-a058-c81f-ad4e718d0233@linux.intel.com>
 <20180111214035.GA14748@roeck-us.net> <20180111221845.GA9278@lunn.ch>
Message-ID: <463412a8-ad34-264d-0f44-bd383f100b44@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/11/2018 2:18 PM, Andrew Lunn wrote:
>>>>> +static const struct of_device_id peci_of_table[] = {
>>>>> +	{ .compatible = "peci-hwmon", },
>>>>
>>>> This does not look like a reference to some piece of hardware.
>>>>
>>>
>>> This driver provides generic PECI hwmon function to which controller has
>>> PECI HW such as Aspeed or Nuvoton BMC chip so it's not dependant on a
>>> specific hardware. Should I remove this or any suggestion?
> 
> PECI seems to be an Intel thing. So at least it should be
> 
>   { .compatible = "intel,peci-hwmon", }
> 
> assuming it is actually compatible with the Intel specification.
> 
> 	 Andrew
> 

Yes, PECI is an Intel thing but this driver is running on an ARM kernel 
on Aspeed or Nuvoton chipsets for now. This driver will be monitoring a 
host server's Intel CPU and DIMM which is running on a separated OS.

Thanks,
Jae
