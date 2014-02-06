From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 06 Feb 2014 23:47:33 +0000
Subject: [PATCH v5 02/20] clocksource: orion: Use atomic access for shared
 registers
In-Reply-To: <20140205231903.GA30244@localhost>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390836440-12744-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140205191035.GZ8533@titan.lakedaemon.net>
 <20140205231903.GA30244@localhost>
Message-ID: <52F41F15.307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2014 11:19 PM, Ezequiel Garcia wrote:
> On Wed, Feb 05, 2014 at 02:10:35PM -0500, Jason Cooper wrote:
>> On Mon, Jan 27, 2014 at 12:27:02PM -0300, Ezequiel Garcia wrote:
>>> Replace the driver-specific thread-safe shared register API
>>> by the recently introduced atomic_io_clear_set().
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>> ---
>>>   drivers/clocksource/time-orion.c | 28 ++++++++++------------------
>>>   1 file changed, 10 insertions(+), 18 deletions(-)
>>
>> The MMIO patch this depends on:
>>
>>    c5ca95b507c8 ARM: 7930/1: Introduce atomic MMIO modify
>>
>> made it in to v3.14-rc1.  It looks like this change is independent of
>> the rest of the watchdog series, so:
>>
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>
>
> Thanks, Jason.
>
> Daniel: If you can pick this I'll drop it from the next watchdog patchset
> submission.

Yep, ok. I am out of the office for the moment, I will take care of it 
Monday.

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
