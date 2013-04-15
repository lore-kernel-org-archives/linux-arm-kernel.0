From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 15 Apr 2013 07:02:40 -0700
Subject: [PATCH 1/3] cputime_nsecs: use math64.h for nsec resolution
 conversion helpers
In-Reply-To: <20130411171047.GB17129@somewhere.redhat.com> (Frederic
 Weisbecker's message of "Thu, 11 Apr 2013 19:10:50 +0200")
References: <1363822467-6275-1-git-send-email-khilman@linaro.org>
 <1363822467-6275-2-git-send-email-khilman@linaro.org>
 <20130411171047.GB17129@somewhere.redhat.com>
Message-ID: <87r4ibdh8f.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frederic Weisbecker <fweisbec@gmail.com> writes:

> On Wed, Mar 20, 2013 at 04:34:25PM -0700, Kevin Hilman wrote:
>> For the nsec resolution conversions to be useable on non 64-bit
>> architectures, the helpers in <linux/math64.h> need to be used so the
>> right arch-specific 64-bit math helpers can be used (e.g. do_div())
>> 
>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>
> Ok the patch is nice!
>
> I'm queuing it.

Thanks, did you queue PATCH 3/3 also to remove the 64-bit limitation
from VIRT_CPU_ACCOUNTING_GEN:  https://lkml.org/lkml/2013/3/20/656

Kevin
