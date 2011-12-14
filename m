From: khilman@ti.com (Kevin Hilman)
Date: Wed, 14 Dec 2011 10:56:21 -0800
Subject: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
In-Reply-To: <CAAL8m4x6ToG5uuKebqSvJaYg6YQjwFK017AiOFVm0-6BtmiCCA@mail.gmail.com>
 (Govindraj's message of "Wed, 14 Dec 2011 21:50:08 +0530")
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
 <CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
 <87fwgow9vz.fsf@ti.com>
 <CAAL8m4wR-3WDYf_c56-h1ZtCg=Ob2T+FvOOaXLSKK1pyo9oh8Q@mail.gmail.com>
 <877h1znpdo.fsf@ti.com>
 <CAAL8m4x6ToG5uuKebqSvJaYg6YQjwFK017AiOFVm0-6BtmiCCA@mail.gmail.com>
Message-ID: <87r507oucq.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Wed, Dec 14, 2011 at 8:59 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Govindraj <govindraj.ti@gmail.com> writes:
>>
>>> On Wed, Dec 14, 2011 at 12:56 AM, Kevin Hilman <khilman@ti.com> wrote:
>>>> Govindraj <govindraj.ti@gmail.com> writes:
>>>>
>>>> [...]
>>>>
>>>>> I have re-based this patch series against LO master
>>>>> commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a
>>>>>
>>>>> Same is available here [1]
>>>>>
>>>>> I have tested this patch series along with:
>>>>>
>>>>> 1.) Tero's V11 irq chaining series
>>>>> ? ? ?http://www.spinics.net/lists/linux-omap/msg61445.html
>>>>> ? ? (This patch series is used for uart wakeup handling using
>>>>> ? ? ? prcm_irq chaining)
>>>>>
>>>>> 2.) Rajendra's hwmod change
>>>>> ? ? ?http://www.spinics.net/lists/arm-kernel/msg148632.html
>>>>> ? ? ?(This patch handles init_no_idle flag setting
>>>>> ? ? ? without this patch there will be boot warning however
>>>>> ? ? ? all pm features will work after boot up.)
>>>>>
>>>>> 3.) Vishwa's io daisy chain changes.
>>>>> ? ? ?http://permalink.gmane.org/gmane.linux.ports.arm.omap/65500
>>>>> ? ? ?(tested with and without this patch series pm features works).
>>>>>
>>>>> Same combination of patches based on above commit id
>>>>> used for testing is available here [2].
>>>>
>>>> Please have a closer look at your branch.
>>>>
>>>> The second commit[1] commits the .rej file from a failed patch apply,
>>>> so obviously doesn't do what was intended.
>>>>
>>>
>>> Sorry my bad I have refreshed the uart runtime branch [1]
>>> & test branch [2].
>>
>> Can you add another patch which fixes these compiler warnings:
>>
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c: In function 'serial_omap_irq':
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:228:29: warning: 'ch' may be used uninitialized in this function [-Wuninitialized]
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:176:16: note: 'ch' was declared here
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:228:29: warning: 'ch' may be used uninitialized in this function [-Wuninitialized]
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:176:16: note: 'ch' was declared here
>>
>
> Here is the patch [1] and pushed to
> git://gitorious.org/runtime_3-0/runtime_3-0.git for_3_3/lo_rc4_uartruntime

Thanks!

Kevin
