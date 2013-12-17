From: keescook@chromium.org (Kees Cook)
Date: Mon, 16 Dec 2013 16:57:08 -0800
Subject: [PATCH v2] use -fstack-protector-strong
In-Reply-To: <CAGXu5j+6_M65pDoJjx1NEUw8SkfpGjH=yhswt-RW=_W97=kkzQ@mail.gmail.com>
References: <20131126203727.GA352@www.outflux.net>
 <20131127112731.GA10435@gmail.com>
 <CAGXu5jLY+AzaB4f92OLA6Orm=Mr9C+G+-mgOmSf-yju+YCmaUg@mail.gmail.com>
 <20131127175442.GA28088@gmail.com> <52963223.9080701@zytor.com>
 <CAGXu5j+6_M65pDoJjx1NEUw8SkfpGjH=yhswt-RW=_W97=kkzQ@mail.gmail.com>
Message-ID: <CAGXu5j+0gjN118RijCinw31g51BZez_oGKFYJwq2T3=yojG_ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 10:11 AM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Nov 27, 2013 at 9:55 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 11/27/2013 09:54 AM, Ingo Molnar wrote:
>>>>
>>>> Looks to be 2% for defconfig. That's way better. Shall I send a v3?
>>>
>>> Well, it's better than 9%, but still almost an order of magnitude
>>> higher than the cost is today, and a lot of distros have
>>> CONFIG_CC_STACKPROTECTOR=y.
>>>
>>> So it would be nice to measure how much the instruction count goes up
>>> in some realistic system-bound test. How much does something like
>>> kernel/built-in.o increase, as per 'size' output?
>
>    text    data     bss     dec     hex filename
>  929611   90851  594496 1614958  18a46e built-in.o-gcc-4.9
>  954648   90851  594496 1639995  19063b built-in.o-gcc-4.9+strong
>
> Looks like 3% for defconfg + CONFIG_CC_STACKPROTECTOR
>
>>
>> Do we need CONFIG_CC_STACKPROTECTOR_STRONG?
>
> I'm hoping to avoid this since nearly anyone using CC_STACKPROTECTOR
> would want strong added, but as a fallback, I'm happy to implement it
> as a separate config item.

Any verdict on this? Should I go with adding ..._STRONG like we used
to have for ..._ALL, or is defaulting to -strong best?

-Kees

-- 
Kees Cook
Chrome OS Security
