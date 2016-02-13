From: david.brown@linaro.org (David Brown)
Date: Fri, 12 Feb 2016 17:31:47 -0700
Subject: [kernel-hardening] [PATCH] arm64: vdso: Mark vDSO code as
 read-only
In-Reply-To: <CAKv+Gu8ArOYqxDGKb=Tv3NsiB2qWWCdD_zMx55m6+hEwLJR4CA@mail.gmail.com>
References: <1455141142-6838-1-git-send-email-david.brown@linaro.org>
 <CAKv+Gu8ArOYqxDGKb=Tv3NsiB2qWWCdD_zMx55m6+hEwLJR4CA@mail.gmail.com>
Message-ID: <20160213003147.GA12074@davidb.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 03:19:20PM +0100, Ard Biesheuvel wrote:

>> diff --git a/arch/arm64/kernel/vdso/vdso.S b/arch/arm64/kernel/vdso/vdso.S
>> index 60c1db5..db7c0f2 100644
>> --- a/arch/arm64/kernel/vdso/vdso.S
>> +++ b/arch/arm64/kernel/vdso/vdso.S
>> @@ -24,6 +24,7 @@
>>         __PAGE_ALIGNED_DATA
>
>^^ You can get rid of this now as well

Can we?  The page is getting mapped to userspace, and if we didn't
page align it, we could leak kernel read-only data to every userspace
process.

David
