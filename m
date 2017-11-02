From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 2 Nov 2017 10:04:45 +0000
Subject: [PATCH v3 18/22] clk: add support for clocks provided by SCMI
In-Reply-To: <20171102072350.GO30645@codeaurora.org>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-19-git-send-email-sudeep.holla@arm.com>
 <20171102072350.GO30645@codeaurora.org>
Message-ID: <c0b80daf-6361-87eb-fde6-a9d6a71e3e82@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/11/17 07:23, Stephen Boyd wrote:
> On 09/28, Sudeep Holla wrote:
>> On some ARM based systems, a separate Cortex-M based System Control
>> Processor(SCP) provides the overall power, clock, reset and system
>> control. System Control and Management Interface(SCMI) Message Protocol
>> is defined for the communication between the Application Cores(AP)
>> and the SCP.
>>
>> This patch adds support for the clocks provided by SCP using SCMI
>> protocol.
>>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: linux-clk at vger.kernel.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 

Thanks

>>  MAINTAINERS            |   2 +-
>>  drivers/clk/Kconfig    |  10 +++
>>  drivers/clk/Makefile   |   1 +
>>  drivers/clk/clk-scmi.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 222 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/clk/clk-scmi.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23ec3471f542..32c184391aee 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12941,7 +12941,7 @@ M:	Sudeep Holla <sudeep.holla@arm.com>
>>  L:	linux-arm-kernel at lists.infradead.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/arm/arm,sc[mp]i.txt
>> -F:	drivers/clk/clk-scpi.c
>> +F:	drivers/clk/clk-sc[mp]i.c
> 
> Is there a lot of copy/paste going on from clk-scpi.c? Maybe it
> could be consolidated?
> 

Not much apart from the usual driver skeleton. Also SCPI specification
will not be enhanced any further while SCMI will be. So they will
deviated in the feature set going further. Even I was thinking of
merging then together initially but based on some WIP changes to the
specification, I thought it may not be good idea. But if we think it can
be merged in future , I will do that for sure(for easy maintenance)

-- 
Regards,
Sudeep
