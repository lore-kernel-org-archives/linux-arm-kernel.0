From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 19 Jul 2014 01:25:40 +0200
Subject: [PATCH 13/19] ARM: s5pv210: move debug-macro.S into the common
 space
In-Reply-To: <53C9779E.7060400@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-14-git-send-email-t.figa@samsung.com>
 <53C5BF24.9030302@samsung.com> <046101cfa090$51757260$f4605720$@samsung.com>
 <53C5CDCB.2050307@gmail.com> <53C9779E.7060400@samsung.com>
Message-ID: <53C9ACF4.7050002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 18.07.2014 21:38, Kukjin Kim wrote:
> On 07/16/14 09:56, Tomasz Figa wrote:
>> On 16.07.2014 02:53, Kukjin Kim wrote:
>>> Kukjin Kim wrote:
>>>>
>>>> On 07/05/14 02:48, Tomasz Figa wrote:
>>>>> Move debug-macro.S from mach/include to include/debug where
>>>>> all other common debug macros are.
>>>>>
>>>>> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
>>>>> ---
>>>>>    arch/arm/Kconfig.debug                           | 12 +++++--
>>>>>    arch/arm/include/debug/s5pv210.S                 | 34
>>>>> ++++++++++++++++++++
>>>>>    arch/arm/mach-s5pv210/include/mach/debug-macro.S | 41
>>>>> ------------------------
>>>>>    3 files changed, 44 insertions(+), 43 deletions(-)
>>>>>    create mode 100644 arch/arm/include/debug/s5pv210.S
>>>>>    delete mode 100644 arch/arm/mach-s5pv210/include/mach/debug-macro.S
>>>
>>> [...]
>>>
>>>> Tomasz,
>>>>
>>>> I couldn't apply this one from this your series because of conflict
>>>> with
>>>> others. Can you please respin this one?
>>>>
>>> One more note, since I didn't apply this, there is a build breakage for
>>> s5pv210_defconfig now...
>>>
>>> arch/arm/kernel/debug.S:24:33: fatal error: mach/debug-macro.S: No
>>> such file or directory
>>> compilation terminated.
>>> make[2]: *** [arch/arm/kernel/debug.o] Error 1
>>> make[1]: *** [arch/arm/kernel] Error 2
>>> make[1]: *** Waiting for unfinished jobs....
>>
>> Hmm? Are you sure previous patches applied correctly? I have tested this
>> series patch by patch on all affected configs and it built fine back
>> then. Maybe some conflict, I'll see tomorrow.
>>
> Tomasz, I've applied this whole series including this again. Can you
> please check my branch before sending pull-request to arm-soc for 3.17?

Thanks for applying this.

A quick look through the patches didn't reveal any issues.
s5pv210_defconfig builds fine too. I don't have any s5pv210-based board
at home, though, so I can't do anything else than compile testing until
Tuesday.

Best regards,
Tomasz
