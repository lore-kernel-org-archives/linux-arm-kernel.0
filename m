From: yang.shi@linaro.org (Shi, Yang)
Date: Thu, 14 Apr 2016 09:33:07 -0700
Subject: [PATCH] arm64: Kconfig: make SCHED_MC and SCHED_SMT depend on SMP
In-Reply-To: <20160414084727.GA23207@arm.com>
References: <1460595252-2330-1-git-send-email-yang.shi@linaro.org>
 <20160414084727.GA23207@arm.com>
Message-ID: <570FC643.3090805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/14/2016 1:47 AM, Will Deacon wrote:
> On Wed, Apr 13, 2016 at 05:54:12PM -0700, Yang Shi wrote:
>> SCHED_MC and SCHED_SMT are pointless when SMP is disabled.
>> Although SMP is rarely disabled for ARM64, it looks more consistent to have
>> such depend in Kconfig.
>
> You can't disable CONFIG_SMP for arm64 -- we select it unconditionally
> in the kconfig.

Thanks Will. I didn't realize ARM64 has SMP selected unconditionally, it 
looks the patch is pointless.

A follow-up question, I know ARM64 has no UP implementation now, it 
sounds make sense to have SMP select unconditionally, however, it might 
be more flexible to have SMP like x86 and other architectures. And, it 
may also help to find more bugs when !SMP.

Thanks,
Yang

>
> Will
>
