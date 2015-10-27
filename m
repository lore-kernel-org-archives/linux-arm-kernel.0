From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 27 Oct 2015 19:08:46 -0300
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <CALszF6Aodf0nXwsrE+Rtrg6UQw-1OMGY+BdadtK-dtHYv-Bqnw@mail.gmail.com>
References: <20151026012710.GA17365@laptop>
 <20151026080537.GW4931@pengutronix.de>
 <CAAEAJfB0yywtQ2MrYf2ih5+a3fZJXAy0hFSXWA038wQMQswa7g@mail.gmail.com>
 <CAAEAJfD29_PSTw+srx7d2YrF+Akx-_94Wv9ifKzT+8HTfH5tGA@mail.gmail.com>
 <562FA053.6010208@st.com>
 <CALszF6C4B-S-o3E1OHK3+bKpDQ8a64Ly-ABNQwfSfj95y7qFyA@mail.gmail.com>
 <85aea33b93066d0959d98b56f8787ba3@agner.ch>
 <CALszF6Di3LWLu_W67Zdn2LyKKRF_5U241eKFKMmJ-0s+0boFag@mail.gmail.com>
 <CAAEAJfCL8veLOi9zi8kARL2kBcYQfxwKS13-mkGbQ_U6Ojg9LA@mail.gmail.com>
 <CALszF6Aodf0nXwsrE+Rtrg6UQw-1OMGY+BdadtK-dtHYv-Bqnw@mail.gmail.com>
Message-ID: <CAAEAJfCfYo+J32PuW8k2p1S5eFxeCL6qTPeTLCGrNQrA0yC1kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 October 2015 at 18:52, Maxime Coquelin <mcoquelin.stm32@gmail.com> wrote:
> 2015-10-27 22:46 GMT+01:00 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>:
>> On 27 October 2015 at 18:33, Maxime Coquelin <mcoquelin.stm32@gmail.com> wrote:
>>> 2015-10-27 21:33 GMT+01:00 Stefan Agner <stefan@agner.ch>:
> ...
>>>> Anyway, I guess Ezequiel's fix is the right thing to do...
>>> Or, maybe we should put the stack in RAM as Uwe suggest?
>>>
>>
>> It seems the current fix would be used as-is (no need to
>> set a temporary stack before the SVC call).
>>
>> And on top of that, we need a to set a proper stack as soon
>> as the kernel takes control.
>>
>> Am I right?
> IMHO, yes, that's how I understand it.
>

After some deeper code parsing, it seems the stack
is set in __mmap_switched.

Although it seems that happens after __v7m_setup,
ARM noMMU has worked like this since ages now, is v7-M
really different to need a special treatment?

-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
