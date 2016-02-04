From: dvyukov@google.com (Dmitry Vyukov)
Date: Thu, 4 Feb 2016 16:07:16 +0100
Subject: [PATCH v6] kernel: add kcov code coverage
In-Reply-To: <CAPAsAGz6vVGfAPSimwqkneUmzMmrwX_WxdCoQ1xg3UyNn4+-eQ@mail.gmail.com>
References: <1453726850-49137-1-git-send-email-dvyukov@google.com>
 <CAPAsAGz6vVGfAPSimwqkneUmzMmrwX_WxdCoQ1xg3UyNn4+-eQ@mail.gmail.com>
Message-ID: <CACT4Y+YygZitF6508qNX9885+nWu7iY9YVqdtE0bCA2+soTp_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 5:02 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
> 2016-01-25 16:00 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index ecb9e75..cde6bd1 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -678,6 +678,26 @@ config DEBUG_STACKOVERFLOW
>>
>>           If in doubt, say "N".
>>
>> +config ARCH_HAS_KCOV
>> +       bool
>> +       help
>> +         KCOV does not have any arch-specific code, but currently it is enabled
>> +         only for x86_64. KCOV requires testing on other archs, and most likely
>> +         disabling of instrumentation for some early boot code.
>> +
>> +config KCOV
>> +       bool "Code coverage for fuzzing"
>> +       depends on ARCH_HAS_KCOV
>
> I think we should select DEBUG_FS here, since this useless without it.

Done in v7

> Also you placed this into 'Memory Debugging' submenu which seems wrong.

Any better suggestions?

>> +       help
>> +         KCOV exposes kernel code coverage information in a form suitable
>> +         for coverage-guided fuzzing (randomized testing).
>> +
>> +         If RANDOMIZE_BASE is enabled, PC values will not be stable across
>> +         different machines and across reboots. If you need stable PC values,
>> +         disable RANDOMIZE_BASE.
>> +
>> +         For more details, see Documentation/kcov.txt.
>> +
>>  source "lib/Kconfig.kmemcheck"
>>
