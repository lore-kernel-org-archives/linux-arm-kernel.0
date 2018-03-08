From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu, 08 Mar 2018 08:28:13 -0500
Subject: [RFC V4] perf, tools: Support wildcards on pmu name in dynamic
 pmu events
In-Reply-To: <20180308130358.GC3701@kernel.org>
References: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
 <20180308130358.GC3701@kernel.org>
Message-ID: <ae102272a8186f0351363511f4ed07f8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-08 08:03, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 07, 2018 at 03:35:47PM -0500, Agustin Vega-Frias escreveu:
>> +++ b/tools/perf/util/parse-events.y
>> @@ -8,6 +8,7 @@
>> 
>>  #define YYDEBUG 1
>> 
>> +#include <fnmatch.h>
>>  #include <linux/compiler.h>
>>  #include <linux/list.h>
>>  #include <linux/types.h>
>> @@ -234,6 +235,10 @@ PE_NAME opt_event_config
>>  	if (parse_events_add_pmu(_parse_state, list, $1, $2)) {
>>  		struct perf_pmu *pmu = NULL;
>>  		int ok = 0;
>> +		char *pattern;
>> +
>> +		if (asprintf(&pattern, "%s*", $1) < 0)
>> +			YYABORT;
> 
> +               if (asprintf(&pattern, "?(uncore_)%s*", $1) < 0)
> 
> I completely overlook that you were using this and thus needed that
> extension, duh, thanks for the patience 8-) and for the new patch.
> 

NP Arnaldo, thanks for the quick turnaround on these patches :o)
Just so I know, since these are my first patches on perf tools,
where are perf tools patches queued once acked?

Thanks!

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
