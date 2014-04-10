From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 19:52:18 +0200
Subject: [PATCH 1/2] GPIO: Add driver for Zynq GPIO controller
In-Reply-To: <533BA67B.6070905@monstr.eu>
References: <1395933906-2268-1-git-send-email-harinik@xilinx.com>
 <CACRpkdbU35xG1QtagB+9e9vxvehf1UQFaF4PikJhsPNAMw=D1Q@mail.gmail.com>
 <CAFcVECJsEp_s2V5=oK_UJahGRUpWYWMCxTMxqdpX+O0qebP41A@mail.gmail.com>
 <CACRpkdZEFsJubRVwCp6nTie7s7+DZOym6SWsA2ZynN_devi-2Q@mail.gmail.com>
 <533BA67B.6070905@monstr.eu>
Message-ID: <CACRpkdbk0Ru=txcF3DGBDD=CitqHYFR8w-1fUDR9wSinQBQyvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 7:56 AM, Michal Simek <monstr@monstr.eu> wrote:
> On 03/31/2014 10:22 AM, Linus Walleij wrote:
>> On Sat, Mar 29, 2014 at 5:44 AM, Harini Katakam
>> <harinikatakamlinux@gmail.com> wrote:
>>> On Sat, Mar 29, 2014 at 3:20 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>> On Thu, Mar 27, 2014 at 4:25 PM, Harini Katakam <harinik@xilinx.com> wrote:
>>
>>>>> +/* Read/Write access to the GPIO PS registers */
>>>>> +static inline u32 zynq_gpio_readreg(void __iomem *offset)
>>>>> +{
>>>>> +       return readl_relaxed(offset);
>>>>> +}
>>>>> +
>>>>> +static inline void zynq_gpio_writereg(void __iomem *offset, u32 val)
>>>>> +{
>>>>> +       writel_relaxed(val, offset);
>>>>> +}
>>>>
>>>> I think this is unnecessary and confusing indirection.
>>>> Just use the readl_relaxed/writel_relaxed functions directly in
>>>> the code.
>>>>
>>>
>>> This is just to be flexible.
>>
>> Define exactly what you mean with "flexible" in this context. I
>> only see unnecessary overhead and hard-to-read code.
>
> We have just passed this discussion for watchdog driver
> here: https://lkml.org/lkml/2014/4/1/843
>
> Are you ok with doing it in this way?

No :-)

Subsystem maintainers do not necessarily agree on such issues.

Yours,
Linus Walleij
