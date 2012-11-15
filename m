From: rajanikanth.hv@stericsson.com (Rajanikanth HV)
Date: Thu, 15 Nov 2012 17:04:58 +0530
Subject: [PATCH 1/4] mfd: ab8500: add devicetree support for fuelgauge
In-Reply-To: <509E8694.7080609@gmail.com>
References: <1351698033-8980-1-git-send-email-rajanikanth.hv@linaro.org>
 <1351698033-8980-2-git-send-email-rajanikanth.hv@linaro.org>
 <509291FF.6090500@gmail.com> <alpine.DEB.2.02.1211072354150.5888@ubuntu12>
 <509E8694.7080609@gmail.com>
Message-ID: <50A4D362.5060402@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 10 November 2012 10:23 PM, Francesco Lavra wrote:
>>> I don't get the point of declaring the char array and copying the string
>>> in it, when you could simply use just the pointer returned by
>>> of_get_property().
>>
>> I am considering a corner case where in 'battery-type' property is not
>> present and battery is connected.In this case i promote battery to
>> UNKNOWN from null.
> 
> You could achieve the same result without using the char array, with
> this assignment:
> 
> btech = "UNKNOWN";
> 
>> FYI: Further, btemp driver will identify the connected battery based on
>> resistance value and decide to use.
>> Ref: ab8500_btemp_id(...) ab8500_btemp.c
>>
>>> Anyway, if the string property is longer than 8 characters, you are
>>> writing past the size of the destination array.
>>
>> i believe it is safe as power_supply.h comprises defines having battery
>> technology type in 4 characters length which is normally the case and
>> 7 chars length being "UNKNOWN" seldom referred
> 
> You should be able to handle whatever the device tree contains, and if
> it contains unexpected data this is not a good excuse for locking up the
> system.
agreed, if we were to go by what device tree contains then explicit
assignment for battery type as "UNKNOWN" is not required, hence only 2
use case persist as :
a) property name with one of the said value be present
	(as per documentation)
b) property name not present
