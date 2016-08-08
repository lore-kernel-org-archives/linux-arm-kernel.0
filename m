From: nleeder@codeaurora.org (Neil Leeder)
Date: Mon, 8 Aug 2016 15:57:30 -0400
Subject: [PATCH v2 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <CAP=VYLo5pBHd1=K78jMvg7XkT6Bn4NP9m+1K34dGyJ0ZRugwkw@mail.gmail.com>
References: <1470345071-9455-1-git-send-email-nleeder@codeaurora.org>
 <1470345071-9455-3-git-send-email-nleeder@codeaurora.org>
 <CAP=VYLo5pBHd1=K78jMvg7XkT6Bn4NP9m+1K34dGyJ0ZRugwkw@mail.gmail.com>
Message-ID: <be10b1fc-fc2c-ccf6-5b0a-7cafc477ad07@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/5/2016 07:15 PM, Paul Gortmaker wrote:
> On Thu, Aug 4, 2016 at 5:11 PM, Neil Leeder <nleeder@codeaurora.org> wrote:
>> Adds perf events support for L2 cache PMU.
>>
>> The L2 cache PMU driver is named 'l2cache_0' and can be used
>> with perf events to profile L2 events such as cache hits
>> and misses.
>>
>> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
>> ---
>>  drivers/soc/qcom/Kconfig               |  10 +
>>  drivers/soc/qcom/Makefile              |   1 +
>>  drivers/soc/qcom/perf_event_l2.c       | 839 +++++++++++++++++++++++++++++++++
>>  include/linux/soc/qcom/perf_event_l2.h |  81 ++++
>>  4 files changed, 931 insertions(+)
>>  create mode 100644 drivers/soc/qcom/perf_event_l2.c
>>  create mode 100644 include/linux/soc/qcom/perf_event_l2.h
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 21ec616..0b5ddb9 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -19,6 +19,16 @@ config QCOM_L2_ACCESSORS
>>           Provides support for accessing registers in the L2 cache
>>           for Qualcomm Technologies chips.
>>
>> +config QCOM_PERF_EVENTS_L2
>> +       bool "Qualcomm Technologies L2-cache perf events"
> 
> Since this is a bool, you shouldn't need module.h in your driver or
> any MODULE_<xyz> tags (if there are any).
> 
> Thanks,
> Paul.
> --

You're right - I'll clean up the include list and sort it alphabetically
while I'm at it.

Thanks,
Neil

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
