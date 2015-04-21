From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 21 Apr 2015 15:01:17 -0700
Subject: [PATCH v3 3/8] selftests/breakpoints: emit skip and omit
 installation when tests are not compiled
In-Reply-To: <55361B3B.3060505@arm.com>
References: <1429571661-26337-1-git-send-email-tyler.baker@linaro.org>
 <55361B3B.3060505@arm.com>
Message-ID: <CANMBJr78R7-6fbmKcpeqB0Mg+=ko5vjU7WoU0O0kgKf1pVtRZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2015 at 02:41, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
> On 21/04/15 00:14, Tyler Baker wrote:
>>
>> The breakpoints test should only should be executed on x86 targets, so
>> lets
>> emit a skip and omit the installation when ARCH != x86.
>>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
>> ---
>>   tools/testing/selftests/breakpoints/Makefile | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/breakpoints/Makefile
>> b/tools/testing/selftests/breakpoints/Makefile
>> index 1822356..430b76d 100644
>> --- a/tools/testing/selftests/breakpoints/Makefile
>> +++ b/tools/testing/selftests/breakpoints/Makefile
>> @@ -8,7 +8,6 @@ ifeq ($(ARCH),x86_64)
>>         ARCH := x86
>>   endif
>>
>> -
>>   all:
>>   ifeq ($(ARCH),x86)
>>         gcc breakpoint_test.c -o breakpoint_test
>> @@ -20,5 +19,11 @@ TEST_PROGS := breakpoint_test
>>
>>   include ../lib.mk
>>
>> +install:
>> +ifneq ($(ARCH),x86)
>> +echo "Not an x86 target, can't install breakpoints selftests"
>
> It would make more sense to send this to stderr than stdout, people may look
> for errors there.

I'm ok with that. However, I'm going to remove this workaround in the
next revision of this series. I am planning to send another series out
to address the shortcomings of lib.mk. At which point I'll make sure
to log these errors/warnings to stderr as you suggested.

>
> Cheers
> Suzuki
>

Thanks for the comment,

Tyler
