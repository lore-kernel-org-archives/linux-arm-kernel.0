From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Nov 2013 09:26:45 -0800
Subject: [PATCH] seccomp: not compatible with ARM OABI
In-Reply-To: <527B72AF.50002@imgtec.com>
References: <20131106233117.GA24545@www.outflux.net>
 <527B72AF.50002@imgtec.com>
Message-ID: <CAGXu5jJn3jJs+mB76ZxOu_ibXuo9Q3mVeKjruZsJRRKpuUJd3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 7, 2013 at 2:59 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi,
>
> On 06/11/13 23:31, Kees Cook wrote:
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index af2cc6eabcc7..6eaca7d92399 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -331,12 +331,15 @@ config HAVE_ARCH_SECCOMP_FILTER
>>
>>  config SECCOMP_FILTER
>>       def_bool y
>> -     depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
>> +     depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET && !OABI_COMPAT
>
> Isn't this the whole point of HAVE_ARCH_SECCOMP_FILTER?
>
> Just change the select in arch/arm/Kconfig to this:
>
>         select HAVE_ARCH_SECCOMP_FILTER if !OABI_COMPAT

Oh! Yeah, that's a much cleaner way to handle it. I totally forgot
that "select" could be conditional. I will respin it that way.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
