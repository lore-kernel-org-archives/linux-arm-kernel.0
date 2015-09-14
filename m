From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Sep 2015 14:21:44 +0100
Subject: [PATCH v2 2/3] drivers: firmware: psci: define more generic
 PSCI_FN_NATIVE macro
In-Reply-To: <20150914131745.GA25469@red-moon>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-3-git-send-email-sudeep.holla@arm.com>
 <20150914131745.GA25469@red-moon>
Message-ID: <55F6C9E8.9060209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/09/15 14:17, Lorenzo Pieralisi wrote:
> On Thu, Jun 18, 2015 at 03:41:33PM +0100, Sudeep Holla wrote:
>> This patch replaces the definition and usage of PSCI_0_2_FN_NATIVE with
>> the new and more generic macro PSCI_FN_NATIVE that can be used with any
>> version. This will be useful for the new features introduced in PSCIv1.0
>> and for any future revisions.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/firmware/psci.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index 68d0c2f6d004..752ca7c9eb97 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -29,13 +29,13 @@
>>   /*
>>    * While a 64-bit OS can make calls with SMC32 calling conventions, for some
>>    * calls it is necessary to use SMC64 to pass or return 64-bit values. For such
>> - * calls PSCI_0_2_FN_NATIVE(x) will choose the appropriate (native-width)
>> + * calls PSCI_FN_NATIVE(x) will choose the appropriate (native-width)
>
> Nit: Comment should be PSCI_FN_NATIVE(version, name), fixed it up in my
> branch.
>

Ah, sorry for missing that.

> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>

Thanks.

Regards,
Sudeep
