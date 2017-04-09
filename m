From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Sun, 9 Apr 2017 16:04:59 -0500
Subject: [PATCH v5 19/23] drivers/fsi: Add GPIO based FSI master
In-Reply-To: <5d173f9c-e01c-6093-16ab-d114857009b2@infradead.org>
References: <20170405020607.79939-1-cbostic@linux.vnet.ibm.com>
 <20170405020607.79939-20-cbostic@linux.vnet.ibm.com>
 <5d173f9c-e01c-6093-16ab-d114857009b2@infradead.org>
Message-ID: <518e0abc-f1da-2ca0-fa44-6802e2b74c71@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/5/17 11:35 AM, Randy Dunlap wrote:
> On 04/04/17 19:06, Christopher Bostic wrote:
>> From: Chris Bostic <cbostic@linux.vnet.ibm.com>
>>
>> Implement a FSI master using GPIO.  Will generate FSI protocol for
>> read and write commands to particular addresses.  Sends master command
>> and waits for and decodes a slave response.
>>
>> Includes changes from Edward A. James <eajames@us.ibm.com> and Jeremy
>> Kerr <jk@ozlabs.org>.
>>
>> Signed-off-by: Edward A. James <eajames@us.ibm.com>
>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>> Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   drivers/fsi/Kconfig           |  11 +
>>   drivers/fsi/Makefile          |   1 +
>>   drivers/fsi/fsi-master-gpio.c | 610 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 622 insertions(+)
>>   create mode 100644 drivers/fsi/fsi-master-gpio.c
>>
>> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
>> index 04c1a0e..9cf8345 100644
>> --- a/drivers/fsi/Kconfig
>> +++ b/drivers/fsi/Kconfig
>> @@ -9,4 +9,15 @@ config FSI
>>   	---help---
>>   	  FSI - the FRU Support Interface - is a simple bus for low-level
>>   	  access to POWER-based hardware.
>> +
>> +if FSI
>> +
>> +config FSI_MASTER_GPIO
>> +	tristate "GPIO-based FSI master"
>> +	depends on FSI && GPIOLIB
> depends on FSI is redundant since "if FSI" does the same thing.

Hi Randy,
Thanks for the feedback, will correct.

-Chris
>> +	---help---
>> +	This option enables a FSI master driver using GPIO lines.
>> +
>> +endif
>> +
>
