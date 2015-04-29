From: lho@apm.com (Loc Ho)
Date: Wed, 29 Apr 2015 14:39:27 -0700
Subject: [PATCH v7 1/5] arm64: Enable EDAC on ARM64
In-Reply-To: <20150429144031.GB18867@e104818-lin.cambridge.arm.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <20150429144031.GB18867@e104818-lin.cambridge.arm.com>
Message-ID: <CAPw-ZTn0m1h=RW5E+CECYn6Ujp-O1E4ckynCyGSGG238rqYiAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> +/*
>> + * ECC atomic, DMA, SMP and interrupt safe scrub function.
>> + * Implements the per arch atomic_scrub() that EDAC use for software
>> + * ECC scrubbing.  It reads memory and then writes back the original
>> + * value, allowing the hardware to detect and correct memory errors.
>> + */
>
> The comment here is misleading since the function doesn't do anything.

Okay.. I will leave only this line:

ECC atomic, DMA, SMP and interrupt safe scrub function.

>> +static inline void atomic_scrub(void *va, u32 size)
>> +{
>> +     /* Stub function for now until an ARM64 HW has a way to test it. */
>> +}
>
> Can we have a WARN_ONCE() here?
>
> We had some discussions last year, restarted this year and the
> conclusion was to leave this function as a no-op since it is not safe in
> the presence of KVM or non-coherent DMA:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/326986.html

I will leave WARN_ONCE.

-Loc
