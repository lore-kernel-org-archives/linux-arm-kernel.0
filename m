From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 14 Mar 2014 21:49:15 +0400
Subject: [PATCH] arm64: enable generic CPU feature modalias matching for
 this architecture
In-Reply-To: <20140314173940.GL18126@arm.com>
References: <1393895404-14776-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140314173940.GL18126@arm.com>
Message-ID: <CAKv+Gu8WFt_JcGD_VypmNHnbzk-4g0iSV47=C9RA4onfopfXAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 March 2014 21:39, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Mar 04, 2014 at 01:10:04AM +0000, Ard Biesheuvel wrote:
>> +static inline bool cpu_have_feature(unsigned int num)
>> +{
>> +     return !!(elf_hwcap & (1UL << num));
>> +}
>
> Do we still need !! if the return type is bool? (I can remove it myself,
> no need to resend the patch)
>

I guess that is redundant, indeed.
