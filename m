From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Mon, 22 Aug 2011 14:25:52 -0400
Subject: [RFC PATCH 05/15] ARM: perf: move active_events into struct
	arm_pmu
In-Reply-To: <4B9A4BAF850C914D8DED94776A2C477E073D90C2@nasanexd01f.na.qualcomm.com>
References: <4B9A4BAF850C914D8DED94776A2C477E073D90C2@nasanexd01f.na.qualcomm.com>
Message-ID: <4E529F30.4070607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

>> From: Mark Rutland 
>> 	case PERF_TYPE_RAW:
>> @@ -556,15 +559,14 @@ static int armpmu_event_init(struct perf_event
>> *event)
>>
>> 	event->destroy = hw_perf_event_destroy;
>>
>> -	if (!atomic_inc_not_zero(&active_events)) {
>> -		mutex_lock(&pmu_reserve_mutex);
>> -		if (atomic_read(&active_events) == 0) {
>> +	if (!atomic_inc_not_zero(active_events)) {
>> +		mutex_lock(&armpmu->reserve_mutex);
>> +		if (atomic_read(active_events) == 0)


Isn't this use of atomic_* still racy ?

http://www.spinics.net/lists/arm-kernel/msg123297.html


Cheers,
Ashwin

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
