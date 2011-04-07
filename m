From: sjg@chromium.org (Simon Glass)
Date: Thu, 7 Apr 2011 09:49:33 -0700
Subject: [PATCH v3] ARM: Use generic BUG() handler
In-Reply-To: <4D9D4D23.6000805@codeaurora.org>
References: <1302131890-20953-1-git-send-email-sjg@chromium.org>
	<4D9D4D23.6000805@codeaurora.org>
Message-ID: <BANLkTimaii4zNXVuUPqiWGZabRRdYM8JmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2011 at 10:35 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 4/6/2011 4:18 PM, Simon Glass wrote:
>> v3: Remove old BUG() implementation in favor of this one.
>> Remove the Backtrace: message (will submit this separately).
>> Use ARM_EXIT_KEEP() so that some architectures can dump exit text at link time
>> thanks to Stephen Boyd <sboyd@codeaurora.org> (although since we always
>> define GENERIC_BUG this might be academic.)
>
> Its not entirely academic because CONFIG_BUG=n and CONFIG_SMP_ON_UP=n
> would allow us to remove the exit text. This could be huge for people
> who want to cram kernel's onto space constrained devices.

OK I see. On my kernel this is 8KB but every little helps and no point
it having it in there if it isn't needed.

>> Rebase to linux-2.6.git master.
>>
>> Change-Id: I07d77c832e816f5ad2390e25f466ddf750adecf4
>
> Don't forget to remove these before submitting to the patch tracker (and
> sending to the list).

OK thanks.

>> diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
>> index 4d88425..2914724 100644
>> --- a/arch/arm/include/asm/bug.h
>> +++ b/arch/arm/include/asm/bug.h
>> @@ -3,21 +3,58 @@
>>
>>
>> ?#ifdef CONFIG_BUG
>> -#ifdef CONFIG_DEBUG_BUGVERBOSE
>> -extern void __bug(const char *file, int line) __attribute__((noreturn));
>> -
>> -/* give file/line information */
>> -#define BUG() ? ? ? ? ? ? ? ?__bug(__FILE__, __LINE__)
>
> Does anybody reference __bug() anymore? If not you can remove that too.

No one is using it now, I will do this.

Regards,
Simon
