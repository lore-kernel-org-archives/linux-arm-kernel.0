From: jcm@redhat.com (Jon Masters)
Date: Wed, 29 Apr 2015 10:46:51 -0400
Subject: [PATCH v7 1/5] arm64: Enable EDAC on ARM64
In-Reply-To: <20150429144031.GB18867@e104818-lin.cambridge.arm.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <20150429144031.GB18867@e104818-lin.cambridge.arm.com>
Message-ID: <5540EEDB.9010002@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2015 10:40 AM, Catalin Marinas wrote:
> On Tue, Apr 28, 2015 at 04:10:41PM -0600, Loc Ho wrote:

>> +/*
>> + * ECC atomic, DMA, SMP and interrupt safe scrub function.
>> + * Implements the per arch atomic_scrub() that EDAC use for software
>> + * ECC scrubbing.  It reads memory and then writes back the original
>> + * value, allowing the hardware to detect and correct memory errors.
>> + */
> 
> The comment here is misleading since the function doesn't do anything.

Well, on the other hand, it is "safe" (joke) ;)

Suggest a documented few line summary of the status from earlier this
year/last year be there instead. Essentially atomic scrubbing is only
safe when you're dealing with a fully coherent system. We captured
various examples of things that could go wrong in the thread link.

> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/326986.html

Thanks Loc and team.

Jon.
