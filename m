From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Sun, 9 Apr 2017 16:06:28 -0500
Subject: [PATCH v5 21/23] drivers/fsi: Add SCOM FSI client device driver
In-Reply-To: <bddbb80e-10b6-fbb9-152a-6e192dfe0745@infradead.org>
References: <20170405020607.79939-1-cbostic@linux.vnet.ibm.com>
 <20170405020607.79939-22-cbostic@linux.vnet.ibm.com>
 <bddbb80e-10b6-fbb9-152a-6e192dfe0745@infradead.org>
Message-ID: <90dac991-03db-614e-09f6-ab55b8db79be@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/5/17 11:35 AM, Randy Dunlap wrote:
> On 04/04/17 19:06, Christopher Bostic wrote:
>> From: Chris Bostic <cbostic@linux.vnet.ibm.com>
>>
>> Create a simple SCOM engine device driver that reads and writes
>> its control registers via an FSI bus.
>>
>> Includes changes from Edward A. James <eajames@us.ibm.com>.
>>
>> Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Edward A. James <eajames@us.ibm.com>
>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>> ---
>>   drivers/fsi/Kconfig    |   6 ++
>>   drivers/fsi/Makefile   |   1 +
>>   drivers/fsi/fsi-scom.c | 263 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 270 insertions(+)
>>   create mode 100644 drivers/fsi/fsi-scom.c
>>
>> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
>> index 9cf8345..0fa265c 100644
>> --- a/drivers/fsi/Kconfig
>> +++ b/drivers/fsi/Kconfig
>> @@ -18,6 +18,12 @@ config FSI_MASTER_GPIO
>>   	---help---
>>   	This option enables a FSI master driver using GPIO lines.
>>   
>> +config FSI_SCOM
>> +	tristate "SCOM FSI client device driver"
>> +	depends on FSI
> depends on FSI is redundant.

Will correct.

Thanks,
Chris
>
>> +	---help---
>> +	This option enables an FSI based SCOM device driver.
>> +
>>   endif
>>   
>
