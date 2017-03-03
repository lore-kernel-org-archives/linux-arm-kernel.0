From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Fri, 3 Mar 2017 15:43:46 -0700
Subject: [PATCH V11 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <86258A5CC0A3704780874CF6004BA8A62DCAD116@lhreml502-mbs>
References: <1487712121-16688-1-git-send-email-tbaicar@codeaurora.org>
 <1487712121-16688-11-git-send-email-tbaicar@codeaurora.org>
 <86258A5CC0A3704780874CF6004BA8A62DCAD116@lhreml502-mbs>
Message-ID: <e1578c9f-7595-9705-9a5a-5811cf6c8513@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shiju,


On 3/3/2017 8:34 AM, Shiju Jose wrote:
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c index
>> b2d57fc..403277b 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -602,6 +602,24 @@ static const char *fault_name(unsigned int esr)  }
>>
>>   /*
>> + * Handle Synchronous External Aborts that occur in a guest kernel.
>> + */
>> +int handle_guest_sea(unsigned long addr, unsigned int esr) {
>> +	/*
>> +	 * synchronize_rcu() will wait for nmi_exit(), so no need to
>> +	 * rcu_read_lock().
>> +	 */
>> +	if(IS_ENABLED(HAVE_ACPI_APEI_SEA)) {
> IS_ENABLED(HAVE_ACPI_APEI_SEA) to be changed to IS_ENABLED(ACPI_APEI_SEA) same
> as in the patch "acpi: apei: handle SEA notification type for ARMv8"?
>
Good catch, I guess my FW still triggers the SCI interrupt as well as 
replays the SEA to kernel which is why I still get into the GHES handling :)

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
