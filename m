From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 10 Jan 2014 11:04:57 +0100
Subject: [PATCH] clk: Correct handling of NULL clk in __clk_{get, put}
In-Reply-To: <CAK9yfHx+=X+DiLe_WsiDkYonKCssPTOGqR76=+7N6eyAHXyQGQ@mail.gmail.com>
References: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
 <CAK9yfHx+=X+DiLe_WsiDkYonKCssPTOGqR76=+7N6eyAHXyQGQ@mail.gmail.com>
Message-ID: <52CFC5C9.4000006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/14 05:44, Sachin Kamat wrote:
> Hi Sylwester,
> 
> On 7 January 2014 17:33, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>> Ensure clk->kref is dereferenced only when clk is not NULL.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>> Hi Sachin,
>>
>> please try if this patch fixes the exyno5420 boot crash.
> 
> Confirmed that this patch works fine on 5420 as well as already
> working 4210 and 5250 boards.
> Thanks for the quick fix.
> 
> Tested-by: Sachin Kamat <sachin.kamat@linaro.org>

Thanks Sachin. Mike, it seems we need this patch on top of
my clk-unregister branch. Sorry for overlooking this issue.
Could you add the $subject patch to your clk-next tree ?

Regards,
Sylwester
