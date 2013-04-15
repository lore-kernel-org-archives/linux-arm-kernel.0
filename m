From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Mon, 15 Apr 2013 16:08:24 +0200
Subject: [PATCH 1/3] cputime_nsecs: use math64.h for nsec resolution
 conversion helpers
In-Reply-To: <87r4ibdh8f.fsf@linaro.org>
References: <1363822467-6275-1-git-send-email-khilman@linaro.org>
 <1363822467-6275-2-git-send-email-khilman@linaro.org>
 <20130411171047.GB17129@somewhere.redhat.com>
 <87r4ibdh8f.fsf@linaro.org>
Message-ID: <CAFTL4hwroTC6HN7WvDRpn=6y-JkX4GeFzS1nro0w3L1CGNMrnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/15 Kevin Hilman <khilman@linaro.org>:
> Frederic Weisbecker <fweisbec@gmail.com> writes:
>
>> On Wed, Mar 20, 2013 at 04:34:25PM -0700, Kevin Hilman wrote:
>>> For the nsec resolution conversions to be useable on non 64-bit
>>> architectures, the helpers in <linux/math64.h> need to be used so the
>>> right arch-specific 64-bit math helpers can be used (e.g. do_div())
>>>
>>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>>
>> Ok the patch is nice!
>>
>> I'm queuing it.
>
> Thanks, did you queue PATCH 3/3 also to remove the 64-bit limitation
> from VIRT_CPU_ACCOUNTING_GEN:  https://lkml.org/lkml/2013/3/20/656

Not yet, for this one I need to deeply check we haven't forgotten
anything concerning cputime_t operations in 32 bits archs.
