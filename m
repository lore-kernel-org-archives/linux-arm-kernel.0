From: ccross@android.com (Colin Cross)
Date: Fri, 4 Mar 2011 12:11:32 -0800
Subject: [PATCH] ARM: twd: Adjust localtimer frequency with cpufreq
	notifiers
In-Reply-To: <4D70BE9D.4000507@stericsson.com>
References: <1290060899-9786-1-git-send-email-ccross@android.com>
	<AANLkTimCuV5N0jr8c949uONEvieQ5MDZ9KHDXtneG5AT@mail.gmail.com>
	<4D70BE9D.4000507@stericsson.com>
Message-ID: <AANLkTin7ZXYALOy_jk1uR3SbZA51nSnU-ncSjG+n_RPn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 4, 2011 at 2:27 AM, martin persson
<martin.persson@stericsson.com> wrote:
> We've seen no problems using this patch and have been grateful for it's
> existence. So I'm happy to put:
>
> Tested-by: martin.persson at stericsson.com
>
> /Martin
>
> On 03/04/2011 11:17 AM, Linus Walleij wrote:
>>
>> 2010/11/18 Colin Cross<ccross@android.com>:
>>
>>> The clock to the ARM TWD local timer scales with the cpu
>>> frequency. To allow the cpu frequency to change while
>>> maintaining a constant TWD frequency, pick a lower target
>>> frequency for the TWD and use the prescaler to divide down
>>> to the closest lower frequency.
>>
>> We are using this with some custom hooks for the U8500.
>>
>> Tested-by: Linus Walleij<linus.walleij@linaro.org>
>>
>> Martin Persson can probably provide an additional Tested-by
>> from ST-Ericsson if it helps.
>>
>> Colin are you merging this patch for 2.6.39 through
>> Russells tracker or pull request? It's an important patch
>> for us.
>>
>> Yours,
>> Linus Walleij
>

I never got any responses, and it conflicts with Rob Herring's patch
6434/1, although that has not been applied.  Russell, do you want this
in the patch tracker?
