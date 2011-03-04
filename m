From: robherring2@gmail.com (Rob Herring)
Date: Fri, 04 Mar 2011 14:31:19 -0600
Subject: [PATCH] ARM: twd: Adjust localtimer frequency with cpufreq
	notifiers
In-Reply-To: <AANLkTin7ZXYALOy_jk1uR3SbZA51nSnU-ncSjG+n_RPn@mail.gmail.com>
References: <1290060899-9786-1-git-send-email-ccross@android.com>	<AANLkTimCuV5N0jr8c949uONEvieQ5MDZ9KHDXtneG5AT@mail.gmail.com>	<4D70BE9D.4000507@stericsson.com>
	<AANLkTin7ZXYALOy_jk1uR3SbZA51nSnU-ncSjG+n_RPn@mail.gmail.com>
Message-ID: <4D714C17.7080102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2011 02:11 PM, Colin Cross wrote:
> On Fri, Mar 4, 2011 at 2:27 AM, martin persson
> <martin.persson@stericsson.com>  wrote:
>> We've seen no problems using this patch and have been grateful for it's
>> existence. So I'm happy to put:
>>
>> Tested-by: martin.persson at stericsson.com
>>
>> /Martin
>>
>> On 03/04/2011 11:17 AM, Linus Walleij wrote:
>>>
>>> 2010/11/18 Colin Cross<ccross@android.com>:
>>>
>>>> The clock to the ARM TWD local timer scales with the cpu
>>>> frequency. To allow the cpu frequency to change while
>>>> maintaining a constant TWD frequency, pick a lower target
>>>> frequency for the TWD and use the prescaler to divide down
>>>> to the closest lower frequency.
>>>
>>> We are using this with some custom hooks for the U8500.
>>>
>>> Tested-by: Linus Walleij<linus.walleij@linaro.org>
>>>
>>> Martin Persson can probably provide an additional Tested-by
>>> from ST-Ericsson if it helps.
>>>
>>> Colin are you merging this patch for 2.6.39 through
>>> Russells tracker or pull request? It's an important patch
>>> for us.
>>>
>>> Yours,
>>> Linus Walleij
>>
>
> I never got any responses, and it conflicts with Rob Herring's patch
> 6434/1, although that has not been applied.  Russell, do you want this
> in the patch tracker?

Russell wanted to move over completely to using the clock api rather 
than making clock api usage optional and this was dependent on his 
init_early changes for Realview/Versatile. So I need to update the 
patches based on that.

I think a cleaner solution for this is platforms should define a clock 
for the local timer and the notifier can just get the clock rate again. 
But these clocks have to be implemented first on all platforms using 
local timer to make it unconditional, and I don't have the clock tree 
knowledge of all those platforms.

Rob
