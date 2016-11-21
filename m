From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 21 Nov 2016 10:24:44 +0800
Subject: [PATCH V8 3/3] stm: Mark the functions of writing buffer with
 notrace
In-Reply-To: <871sy8g83q.fsf@ashishki-desk.ger.corp.intel.com>
References: <1479438454-28650-1-git-send-email-zhang.chunyan@linaro.org>
 <1479438454-28650-4-git-send-email-zhang.chunyan@linaro.org>
 <871sy8g83q.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CAG2=9p_X4GD7w4FdTK3M_3OZ1-KDSP__qOKoM5FGaxk07ERqbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 November 2016 at 22:45, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Chunyan Zhang <zhang.chunyan@linaro.org> writes:
>
>> If CONFIG_STM_SOURCE_FTRACE is selected, Function trace data can be writen
>> to sink via STM, all functions that related to writing data packets to
>> STM should be marked 'notrace' to avoid being traced by Ftrace, otherwise
>> the program would stall into an endless loop.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>> ---
>>  drivers/hwtracing/coresight/coresight-stm.c |  2 +-
>>  drivers/hwtracing/intel_th/sth.c            | 11 +++++++----
>>  drivers/hwtracing/stm/core.c                |  7 ++++---
>>  drivers/hwtracing/stm/dummy_stm.c           |  2 +-
>>  include/linux/stm.h                         |  4 ++--
>>  5 files changed, 15 insertions(+), 11 deletions(-)
>
> Quick nit: can you please split this one in 4: one for Coresight, one
> for Intel TH, one for stm/dummy and one for stm/core?

Sure, will do.

>
> I'd like to keep the bisectability. Otherwise, this is fine by me:
>
> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks,
Chunyan

>
> Regards,
> --
> Alex
