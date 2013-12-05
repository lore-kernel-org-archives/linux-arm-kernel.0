From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Dec 2013 09:28:03 -0800
Subject: [PATCH] ARM: Clean up setup printks a bit
In-Reply-To: <52A04407.4000306@elopez.com.ar>
References: <1386199826-8183-1-git-send-email-olof@lixom.net>
 <52A04407.4000306@elopez.com.ar>
Message-ID: <CAOesGMj6=MWjEGVj8upQzQ8nEa3KDsHBOcfMNNEZjazU=Ku+sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 1:14 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> Hi Olof,
>
> El 04/12/13 20:30, Olof Johansson escribi?:
>
>> Clean up the setup ARM printks a bit. Add printk level to a few
>> that were missing (CPU: <...> ones, in particular), and switch from
>> printk(KERN_* ..) to pr_*().
>>
>> Finally, un-wrap some long lines since it makes it harder to grep the
>> sources from where an error came from and tweak some cases of indentation.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>   arch/arm/kernel/setup.c |   39 +++++++++++++++++++--------------------
>>   1 file changed, 19 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>> index 6a1b8a8..7c472f4 100644
>> --- a/arch/arm/kernel/setup.c
>> +++ b/arch/arm/kernel/setup.c
>
>
> ...
>
>
>>
>>         if (meminfo.nr_banks >= NR_BANKS) {
>> -               printk(KERN_CRIT "NR_BANKS too low, "
>> -                       "ignoring memory at 0x%08llx\n", (long
>> long)start);
>> +               pr_crit("NR_BANKS too low, "ignoring memory at
>> 0x%08llx\n",
>
>
> There's a stray " there

That's certainly embarrassing, and I can't explain how I got that to
past my build. Revised patch sent to the tracker.


-Olof
