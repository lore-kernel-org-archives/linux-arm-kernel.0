From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 4 Sep 2017 17:46:18 +0200
Subject: [PATCH v2] clk: mb86s7x: Drop non-building driver
In-Reply-To: <20170901203201.GB21656@codeaurora.org>
References: <20170824225237.21485-1-afaerber@suse.de>
 <20170901203201.GB21656@codeaurora.org>
Message-ID: <8601a2ec-33dc-0024-55ce-963f05faca75@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Am 01.09.2017 um 22:32 schrieb Stephen Boyd:
> On 08/25, Andreas F?rber wrote:
>> It fails to build once we introduce the ARCH_MB86S7X Kconfig symbol:
>>
>>   drivers/clk/clk-mb86s7x.c:27:10: fatal error: soc/mb86s7x/scb_mhu.h: No such file or directory
>>    #include <soc/mb86s7x/scb_mhu.h>
>>             ^~~~~~~~~~~~~~~~~~~~~~~
>>   compilation terminated.
>>
>> And when commenting out that line, we get:
>>
>>   drivers/clk/clk-mb86s7x.c: In function 'crg_gate_control':
>>   drivers/clk/clk-mb86s7x.c:72:8: error: implicit declaration of function 'mb86s7x_send_packet' [-Werror=implicit-function-declaration]
>>     ret = mb86s7x_send_packet(CMD_PERI_CLOCK_GATE_SET_REQ,
>>           ^~~~~~~~~~~~~~~~~~~
>>   drivers/clk/clk-mb86s7x.c:72:28: error: 'CMD_PERI_CLOCK_GATE_SET_REQ' undeclared (first use in this function)
>>     ret = mb86s7x_send_packet(CMD_PERI_CLOCK_GATE_SET_REQ,
>>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   drivers/clk/clk-mb86s7x.c:72:28: note: each undeclared identifier is reported only once for each function it appears in
>>   drivers/clk/clk-mb86s7x.c: In function 'crg_rate_control':
>>   drivers/clk/clk-mb86s7x.c:116:10: error: 'CMD_PERI_CLOCK_RATE_SET_REQ' undeclared (first use in this function)
>>      code = CMD_PERI_CLOCK_RATE_SET_REQ;
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   drivers/clk/clk-mb86s7x.c:121:10: error: 'CMD_PERI_CLOCK_RATE_GET_REQ' undeclared (first use in this function); did you mean 'CMD_PERI_CLOCK_RATE_SET_REQ'?
>>      code = CMD_PERI_CLOCK_RATE_GET_REQ;
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>             CMD_PERI_CLOCK_RATE_SET_REQ
>>   drivers/clk/clk-mb86s7x.c: In function 'mhu_cluster_rate':
>>   drivers/clk/clk-mb86s7x.c:276:10: error: 'CMD_CPU_CLOCK_RATE_GET_REQ' undeclared (first use in this function)
>>      code = CMD_CPU_CLOCK_RATE_GET_REQ;
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>   drivers/clk/clk-mb86s7x.c:278:10: error: 'CMD_CPU_CLOCK_RATE_SET_REQ' undeclared (first use in this function); did you mean 'CMD_CPU_CLOCK_RATE_GET_REQ'?
>>      code = CMD_CPU_CLOCK_RATE_SET_REQ;
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>             CMD_CPU_CLOCK_RATE_GET_REQ
>>   cc1: some warnings being treated as errors
>>   scripts/Makefile.build:302: recipe for target
>>   'drivers/clk/clk-mb86s7x.o' failed
>>   make[2]: *** [drivers/clk/clk-mb86s7x.o] Error 1
>>
>> Remove the driver for now.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
> 
> Applied to clk-next

Thanks. Is this 4.14 or 4.15 material at this point? In particular I
wonder which release I can proceed to introduce ARCH_MB86S7X in - I'm
assuming we need to wait for this one to get merged, so 4.15 or 4.16
respectively?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
