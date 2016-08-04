From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 4 Aug 2016 16:58:41 +0100
Subject: [PATCH 2/2] coresight: fix handling of ETM trace register access
 via sysfs
In-Reply-To: <CANLsYkxRS+2xGNtPBNVaddRXAbXZc+vnbj2VK=7ifD9PoV=0SQ@mail.gmail.com>
References: <1470240752-17331-1-git-send-email-sudeep.holla@arm.com>
 <1470240752-17331-2-git-send-email-sudeep.holla@arm.com>
 <CANLsYkxRS+2xGNtPBNVaddRXAbXZc+vnbj2VK=7ifD9PoV=0SQ@mail.gmail.com>
Message-ID: <37cade42-0cc0-e623-59a7-ecdc9e959ba8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/08/16 16:46, Mathieu Poirier wrote:
> On 3 August 2016 at 10:12, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> The ETM registers are classified into 2 categories: trace and management.
>> The core power domain contains most of the trace unit logic including
>> all(except TRCOSLAR and TRCOSLSR) the trace registers. The debug power
>> domain contains the external debugger interface including all management
>> registers.
>>
>> This patch adds coresight unit specific function coresight_simple_func
>> which can be used for ETM trace registers by providing a ETM specific
>> read function which does smp cross call to ensure the trace core is
>> powered up before the register is accessed.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Hey Sudeep,
>
> I'm good with this patch - just a few things to amend below.
>
> Many thanks,
> Mathieu
>
>> ---
>>  drivers/hwtracing/coresight/coresight-etb10.c      |  2 +-
>>  .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  2 +-
>>  .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 58 ++++++++++++++++------
>>  drivers/hwtracing/coresight/coresight-etm4x.h      |  1 +
>>  drivers/hwtracing/coresight/coresight-priv.h       |  9 +++-
>>  drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
>>  drivers/hwtracing/coresight/coresight-tmc.c        |  2 +-
>>  7 files changed, 54 insertions(+), 22 deletions(-)
>>
>> Hi Mathieu,
>>
>> I think the latest release of the firmware(inparticular SCP v1.16.0) for
>
> Is this public?  If so please give me the link so that we test with
> the same environment.
>

Yes I believe so. You should be able to grab latest @[1]

I agree with all the other comments, will repost v2 soon.

-- 
Regards,
Sudeep

[1] 
https://snapshots.linaro.org/member-builds/armlt-platforms-release/28/juno-uefi.zip
