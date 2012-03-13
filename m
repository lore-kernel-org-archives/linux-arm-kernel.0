From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 13 Mar 2012 22:10:09 +0530
Subject: [PATCH] ARM: OMAP4: Workaround the OCP synchronisation issue with
 32K synctimer.
In-Reply-To: <87vcm8tqbx.fsf@ti.com>
References: <1331566388-2397-1-git-send-email-santosh.shilimkar@ti.com>
 <87399d225f.fsf@ti.com> <4F5F098E.4040006@ti.com> <87vcm8tqbx.fsf@ti.com>
Message-ID: <CAMQu2gxwH5oK4C6OBMZqBfijwfC8=eQYJv3jqh55qpZEqOhx0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 10:01 PM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> On Monday 12 March 2012 10:21 PM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> On OMAP4, recently a synchronisation bug is discovered by hardware
>>>> team, which leads to incorrect timer value read from 32K sync timer
>>>> IP when the IP is comming out of idle.
>>>>
>>>> The issue is due to the synchronization methodology used in the SYNCTIMER IP.
>>>> The value of the counter register in 32kHz domain is synchronized to the OCP
>>>> domain register only at count up event, and if the OCP clock is switched off,
>>>> the OCP register gets out of synch until the first count up event after the
>>>> clock is switched back -at the next falling edge of the 32kHz clock.
>>>>
>>>> Further investigation revealed that it applies to gptimer1 and watchdog timer2
>>>> as well which may run on 32KHz. This patch fixes the issue for all the
>>>> applicable modules.
>>>
>>> The changelog describes the problem ver well, but doesn't actually
>>> describe the fix (enable static dep.) ?Can you update the changelog do
>>> describe the fix, and why it fixes the problem.
>>>
>> Sure. Updated patch below. The idea is to ensure that synctimer is
>> syncronised before software does any reads on the counter. The BUG
>> will get fixed in future OMAP designs
>
> Thanks for the updated changelog.
>
> Since this doesn't qualify as a regression, queuing for v3.4 (branch: for_3.4/fixes/pm)
>
Thanks Kevin.

Regards
Santosh
