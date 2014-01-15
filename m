From: dave.long@linaro.org (David Long)
Date: Wed, 15 Jan 2014 11:44:12 -0500
Subject: [PATCH v4 07/16] ARM: Remove use of struct kprobe from generic
 probes code
In-Reply-To: <1387547729.3404.50.camel@linaro1.home>
References: <1387166930-13182-1-git-send-email-dave.long@linaro.org>
 <1387166930-13182-8-git-send-email-dave.long@linaro.org>
 <1387547729.3404.50.camel@linaro1.home>
Message-ID: <52D6BADC.2040607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/13 08:55, Jon Medhurst (Tixy) wrote:
> On Sun, 2013-12-15 at 23:08 -0500, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Change the generic ARM probes code to pass in the opcode and architecture-specific
>> structure separately instead of using struct kprobe, so we do not pollute
>> code being used only for uprobes or other non-kprobes instruction
>> interpretation.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm/include/asm/probes.h    |   9 +-
>>   arch/arm/kernel/kprobes-arm.c    |  77 ++++++-------
>>   arch/arm/kernel/kprobes-common.c |  42 ++++---
>>   arch/arm/kernel/kprobes-thumb.c  | 239 +++++++++++++++++++--------------------
>>   arch/arm/kernel/kprobes.c        |   2 +-
>>   arch/arm/kernel/kprobes.h        |   2 +-
>>   arch/arm/kernel/probes-arm.c     |  33 +++---
>>   arch/arm/kernel/probes-arm.h     |  29 ++---
>>   arch/arm/kernel/probes-thumb.c   |  18 ++-
>>   arch/arm/kernel/probes-thumb.h   |  51 ---------
>>   arch/arm/kernel/probes.c         |  14 ++-
>>   arch/arm/kernel/probes.h         |   8 +-
>>   12 files changed, 246 insertions(+), 278 deletions(-)
>
> Looks OK to me, though it looks like this patch includes some header
> file cleanups that should have been part of the previous patch? I.e. all
> the changes to probes-thumb.h and probes-arm.h. And also the
> re-application of 'static' to functions in kprobes-thumb.c and
> kprobes-arm.c.
>
> I'm not sure it's worth the hassle of trying to unpick those changes
> though, it doesn't impact the end result or bisect-bility.
>

I moved the changes around as suggested.

-dl
