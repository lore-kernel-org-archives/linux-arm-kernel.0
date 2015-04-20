From: spang@chromium.org (Michael Spang)
Date: Mon, 20 Apr 2015 17:20:57 -0400
Subject: [PATCH] arm64: Add KEYS_COMPAT to Kconfig & enable
In-Reply-To: <20141020161017.GL20301@arm.com>
References: <1413316871-27404-1-git-send-email-spang@chromium.org>
 <20141020161017.GL20301@arm.com>
Message-ID: <CAC5F_1ktq6jArPYA4e+Ac43pYAPK_D_ZV9NEn3Sc53F=DzUHaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 12:10 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Oct 14, 2014 at 09:01:11PM +0100, Michael Spang wrote:
>> This enables the keyctl compat syscall.
>>
>> Signed-off-by: Michael Spang <spang@chromium.org>
>> ---
>>  arch/arm64/Kconfig | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index ac9afde..35c3103 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -461,6 +461,11 @@ source "arch/arm64/Kconfig.debug"
>>
>>  source "security/Kconfig"
>>
>> +config KEYS_COMPAT
>> +     bool
>> +     depends on COMPAT && KEYS
>> +     default y
>
> I'm curious as to why this requires a Kconfig option, whilst other compat
> system calls do not. The core code is already using COMPAT_SYSCALL_DEFINE,
> so why can't the architecture just plumb the compat syscall table and be
> done with it?
>
> Failing that, the pattern used elsewhere involves __ARCH_WANT_COMPAT_*
> #defines.

I am not actually sure why it is the way it is. All the other archs
just set the option exactly like this.

I've just resent it with only a minor adjustment.

Cheers!
Michael
