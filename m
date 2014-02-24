From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 24 Feb 2014 13:59:33 +0100
Subject: [PATCH] clk: Correct handling of NULL clk in __clk_{get, put}
In-Reply-To: <52F8E9E8.8060408@samsung.com>
References: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
 <CAK9yfHx+=X+DiLe_WsiDkYonKCssPTOGqR76=+7N6eyAHXyQGQ@mail.gmail.com>
 <52CFC5C9.4000006@samsung.com>
 <CAK9yfHxnrM--A_SZSBWzQ2B7zrtU+=n77H61bzq4ddtLrpHMBg@mail.gmail.com>
 <52F8E9E8.8060408@samsung.com>
Message-ID: <530B4235.6070108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

On 10.02.2014 16:02, Sylwester Nawrocki wrote:
> On 30/01/14 05:50, Sachin Kamat wrote:
>> On 10 January 2014 15:34, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>>>> On 08/01/14 05:44, Sachin Kamat wrote:
>>>>>> Hi Sylwester,
>>>>>>
>>>>>> On 7 January 2014 17:33, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>>>>>>>> Ensure clk->kref is dereferenced only when clk is not NULL.
>>>>>>>>
>>>>>>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>>>>>>> ---
>>>>>>>> Hi Sachin,
>>>>>>>>
>>>>>>>> please try if this patch fixes the exyno5420 boot crash.
>>>>>>
>>>>>> Confirmed that this patch works fine on 5420 as well as already
>>>>>> working 4210 and 5250 boards.
>>>>>> Thanks for the quick fix.
>>>>>>
>>>>>> Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
>>>>
>>>> Thanks Sachin. Mike, it seems we need this patch on top of
>>>> my clk-unregister branch. Sorry for overlooking this issue.
>>>> Could you add the $subject patch to your clk-next tree ?
>>
>> Gentle ping Mike. Hope we can have this patch in rc-2.
>
> A gentle reminder, this patch is still not in current -rc and is required
> to fix booting of some exynos platforms.

It's been one and a half of a month since Sylwester posted this patch. 
Sorry for nagging, but for this whole period we've been observing 
complete breakage of several platforms, including Exynos4412-Trats2 
board, due to NULL pointer dereference at boot-up time, so I'd consider 
this patch a _critical_ fix.

Can we expect this patch to be applied to your tree and sent for next rc 
release or I should apply it to my tree and send a pull request to Linus 
directly?

Best regards,
Tomasz
