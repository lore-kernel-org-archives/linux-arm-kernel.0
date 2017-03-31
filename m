From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 31 Mar 2017 09:08:44 +0200
Subject: [PATCH V2 2/2] thermal: broadcom: add Northstar thermal driver
In-Reply-To: <20170331031554.GA3161@localhost.localdomain>
References: <20170318155632.18099-1-zajec5@gmail.com>
 <20170323223045.15786-1-zajec5@gmail.com>
 <20170323223045.15786-2-zajec5@gmail.com>
 <20170331031554.GA3161@localhost.localdomain>
Message-ID: <e5958192-1ea9-3269-0576-e114231c21a0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review!

On 03/31/2017 05:15 AM, Eduardo Valentin wrote:
> On Thu, Mar 23, 2017 at 11:30:45PM +0100, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> Northstar is a SoC family commonly used in home routers. This commit
>> adds a driver for checking CPU temperature. As Northstar Plus seems to
>> also have this IP block this new symbol gets ARCH_BCM_IPROC dependency.
>>
>
> Can you please educate me on how different this driver is from
> https://patchwork.kernel.org/patch/9619579/
>
> ?

This is a different hardware block. Northstar and BCM283x are totally different
SoCs. Northstar is mostly used in home routers, BCM283x mostly in Rasperry Pi.


>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 776b34396144..008e173ec825 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -392,6 +392,11 @@ config MTK_THERMAL
>>  	  Enable this option if you want to have support for thermal management
>>  	  controller present in Mediatek SoCs
>>
>> +menu "Broadcom thermal drivers"
>> +depends on ARCH_BCM || COMPILE_TEST
>
> Does the above dependency also work for other BCM chips?

I believe so. If there ever appears a driver in drivers/thermal/broadcom/ that
can't be freely compiled with COMPILE_TEST, it can just have a proper
dependency.
