From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri, 8 Sep 2017 23:16:44 +0300
Subject: [RFC v3 2/3] interconnect: Add basic event tracing
In-Reply-To: <20170908141321.02f51e92@gandalf.local.home>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
 <20170908171830.13813-3-georgi.djakov@linaro.org>
 <20170908141321.02f51e92@gandalf.local.home>
Message-ID: <e45d096f-1e7a-89cd-f334-266d4b3466bc@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8.09.17 ?. 21:13, Steven Rostedt wrote:
> On Fri,  8 Sep 2017 20:18:29 +0300
> Georgi Djakov <georgi.djakov@linaro.org> wrote:
> 
>> diff --git a/include/trace/events/interconnect.h b/include/trace/events/interconnect.h
>> new file mode 100644
>> index 000000000000..c4a72163873c
>> --- /dev/null
>> +++ b/include/trace/events/interconnect.h
>> @@ -0,0 +1,45 @@
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM interconnect
>> +
>> +#if !defined(_TRACE_INTERCONNECT_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_INTERCONNECT_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +struct interconnect_path;
>> +
>> +DECLARE_EVENT_CLASS(interconnect_path,
>> +
>> +	TP_PROTO(struct interconnect_path *path),
>> +
>> +	TP_ARGS(path),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(struct interconnect_path *, path)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->path = path;
>> +	),
>> +
>> +	TP_printk("INTERCONNECT: %p", __entry->path)
> 
> You're passing in an interconnect_path and only recording the pointer
> to it? Wouldn't it be useful to record other aspects? Like the number
> of nodes, the avg and peak bw of each node?
> 

My goal was to get just the path with some timestamps, but your suggestion
sounds good. Will do it. Thanks!
