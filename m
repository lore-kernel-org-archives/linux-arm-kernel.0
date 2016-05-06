From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 6 May 2016 15:32:48 +0100
Subject: [PATCH] coresight: Handle build path error
In-Reply-To: <CANLsYkwEG-4U+hvdVNHQxoH_WuZvD_pYwDC6NSBOok9o5swNoA@mail.gmail.com>
References: <1462358484-9342-1-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkwEG-4U+hvdVNHQxoH_WuZvD_pYwDC6NSBOok9o5swNoA@mail.gmail.com>
Message-ID: <572CAB10.7060103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/16 15:26, Mathieu Poirier wrote:
> On 4 May 2016 at 04:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> Enabling a component via sysfs (echo 1 > enable_source), would
>> trigger building a path from the enabled sources to the sink.
>> If there is an error in the process (e.g, sink not enabled or
>> the device (CPU corresponding to ETM) is not online), we never report
>> failure, except for leaving a message in the dmesg.
>>
>> Do proper error checking for the build path and return the error.
>>
>> Before:
>>   $ echo 0 > /sys/devices/system/cpu/cpu2/online
>>   $ echo 1 > /sys/devices/cs_etm/cpu2/enable_source
>>   $ echo $?
>>   0
>>
>> After:
>>   $ echo 0 > /sys/devices/system/cpu/cpu2/online
>>   $ echo 1 > /sys/devices/cs_etm/cpu2/enable_source
>>   -bash: echo: write error: No such device or address
>>
>> Cc: Mathie Porier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> This patch looks good - thanks for the fix.  Due to how late we are in
> the cycle I'd ask Greg to pick it up right away but there is a
> (couple) of typos in my name on the CC line.  Either resend another
> patch with the correct spelling or remove the CC line altogether.

Sorry about that. will resend it fixed.
