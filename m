From: jonas@southpole.se (Jonas Bonn)
Date: Wed, 21 Aug 2013 07:10:33 +0200
Subject: [RFC PATCH 2/4] openrisc: remove undefined of_get_cpu_node
 declaration
In-Reply-To: <520DF3BD.2070904@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <520DF3BD.2070904@arm.com>
Message-ID: <52144BC9.9030007@southpole.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/13 11:41, Sudeep KarkadaNagesha wrote:
> On 15/08/13 18:09, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> This patch removes the declaration of the function 'of_get_cpu_node'
>> which is not defined for openrisc. This is in preparation to move
>> it's definition from PPC to DT common code.
>>
>> Again it could be there as it was originally copied from powerpc.
>>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> Cc: Jonas Bonn <jonas@southpole.se>
> Hi Jonas,
>
> Since both microblaze and openrisc have moderated lists which I am not
> member of, these patches were blocked. Michal Simek agreed to remove
> this for microblaze. Do you see any concern with this patch for openrisc
> ? Can I have you ACK if it looks fine ?

Hi Sudeep,
Yes, thanks, the patch looks good.

Acked-by: Jonas Bonn <jonas@southpole.se>

/Jonas

>
> Regards,
> Sudeep
>> ---
>>   arch/openrisc/include/asm/prom.h | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/openrisc/include/asm/prom.h b/arch/openrisc/include/asm/prom.h
>> index bbb34e5..eb59bfe 100644
>> --- a/arch/openrisc/include/asm/prom.h
>> +++ b/arch/openrisc/include/asm/prom.h
>> @@ -44,9 +44,6 @@ void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
>>   
>>   extern void kdump_move_device_tree(void);
>>   
>> -/* CPU OF node matching */
>> -struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
>> -
>>   /* Get the MAC address */
>>   extern const void *of_get_mac_address(struct device_node *np);
>>   
>>
>
