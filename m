From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 29 Jul 2010 01:14:38 +0200
Subject: [PATCH] Watchdog: Adding support for ARM Primecell SP805 Watchdog
In-Reply-To: <4C4FABCE.70907@st.com>
References: <1274344428-28329-1-git-send-email-viresh.kumar@st.com>
	<AANLkTik1vSgASNLXSpYD2MVgmQGgvCx-5mFY_3YFsuHL@mail.gmail.com>
	<4C43DD7E.5050800@st.com> <4C4E65A4.7030005@st.com>
	<AANLkTiktDfvRUjA-Scu643=GniuNzqKjNFBZY2foh_fa@mail.gmail.com>
	<4C4FABCE.70907@st.com>
Message-ID: <AANLkTiknxRruCFx9xyvgKJVkqpkPLtJYX3tXGc_qtBJo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/28 Viresh KUMAR <viresh.kumar@st.com>:
> On 7/28/2010 3:55 AM, Linus Walleij wrote:
>> 2010/7/27 Viresh KUMAR <viresh.kumar@st.com>:
>>
>>>>>>>> + ? ? ? /* roundup timeout to closest positive integer value */
>>>>>>>> + ? ? ? wdt->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
>>>>>>
>>>>>> Look in linux/kernel.h, use the
>>>>>> DIV_ROUND_CLOSEST() macro instead of this.
>>>
>>> Now i remember why i didn't choose DIV_ROUND_CLOSEST in V1 of this patch.
>>> As it is a u64 division, i get following compilation error if i use
>>> DIV_ROUND_CLOSEST. I wasn't sure if inclusion of some header file can remove
>>> this error, and so i used div_u64.
>>
>> Aha, I have no solution to that, but I'd recommend adding the comment
>> /* Cannot use DIV_ROUND_CLOSEST() due to the 64bit size */
>>
>
> I thought that also, but i didn't like that. There is nothing wrong or
> special in code. It is fine to do divisions the way it is done. So i didn't
> give any comment here. You still want me to give a comment there?

The comment would not be stating that there is something wrong
with the division, merely that the standard macro isn't used for this
reason, but it's not important, feel free to drop it if you think it's nitpicky.

Yours,
Linus Walleij
