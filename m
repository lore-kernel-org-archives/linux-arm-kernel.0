From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 28 May 2012 16:50:50 +0800
Subject: [PATCH v9 1/3] MTD: at91: extract hw ecc initialization to one
 function and use relaxed read/write
In-Reply-To: <1338122668.19389.4.camel@koala>
References: <1338038677-6752-1-git-send-email-josh.wu@atmel.com>
 <1338038677-6752-2-git-send-email-josh.wu@atmel.com>
 <1338122668.19389.4.camel@koala>
Message-ID: <4FC33C6A.4070104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/27/2012 8:44 PM, Artem Bityutskiy wrote:
> On Sat, 2012-05-26 at 21:24 +0800, Josh Wu wrote:
>> use _relaxed read/write in most place. And use writel in operations of Control Register since it needs memory barrier.
>>
>> Signed-off-by: Hong Xu<hong.xu@atmel.com>
>> Signed-off-by: Josh Wu<josh.wu@atmel.com>
> This should be split on 2 or even 3 parts:
>
> 1. You move definitions and things around.
> 2. You separate out the init stuff into a function
> 3. You start using _relaxed helpers.
>
> And you should provide better commit messages. You should explain why
> you do things - just cleanup? improvement? fix? preparation for
> something?

My goal here is to prepare for the PMECC support.
    Point 1 is consistent for the later PMECC patch.
    Point 2 is prepare for PMECC support.

So I think I will not add the _relaxed helpers for HW ECC operation in 
this patch series. Since that is out of the goal of this patch series.

>
> I think this patch is too big, commit message is poor, patch does more
> things than documented in the commit message.
>

Indeed the commit message is poor. I will fix it.

Best Regards,
Josh Wu
