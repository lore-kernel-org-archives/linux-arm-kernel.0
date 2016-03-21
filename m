From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Mon, 21 Mar 2016 11:46:59 -0400
Subject: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <20160321153836.GZ6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
 <20160321153836.GZ6344@twins.programming.kicks-ass.net>
Message-ID: <56F01773.8030905@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2016 11:38 AM, Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 01:02:13PM -0400, Chris Metcalf wrote:
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index 48958d3cec9e..37afd721ec99 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -887,8 +887,8 @@ static void check_section(const char *modname, struct elf_info *elf,
>>   #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
>>   
>>   #define DATA_SECTIONS ".data", ".data.rel"
>> -#define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
>> -		".kprobes.text"
>> +#define TEXT_SECTIONS ".text", ".text.unlikely", \
>> +		".kprobes.text", ".cpuidle.text"
> Where did .sched.text go?

Indeed!  Good catch.  I can't even speculate as to how I managed
to delete the thing on the previous line while adding something
on the following line :-)

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
