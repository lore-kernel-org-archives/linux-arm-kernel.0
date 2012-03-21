From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 20 Mar 2012 20:26:34 -0700
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <alpine.LFD.2.02.1203202233340.24151@xanadu.home>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <CAP245DXV5oE+-y+PQCcSM016h-J+UgTi1efmdrcyeQge4k1Cfw@mail.gmail.com>
 <201203161218.05125.arnd.bergmann@linaro.org>
 <201203162057.58706.arnd@arndb.de>
 <alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
 <20120316234706.GJ3852@pengutronix.de>
 <alpine.DEB.2.00.1203201611330.22974@utopia.booyaka.com>
 <alpine.LFD.2.02.1203202233340.24151@xanadu.home>
Message-ID: <4F694A6A.4050706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2012 08:15 PM, Nicolas Pitre wrote:
> On Tue, 20 Mar 2012, Paul Walmsley wrote:
>
>> We need to indicate in some way that the existing code and API is very
>> likely to change in ways that could involve quite a bit of work for
>> adopters.
>
> [...]
>
>> Anyway.  It is okay if we want to have some starter common clock framework
>> in mainline; this is why deferring the merge hasn't been proposed.  But
>> the point is that anyone who bases their code or platform on the common
>> clock framework needs to be aware that, to satisfy one of its major
>> use-cases, the behavior and/or API of the common clock code may need to
>> change significantly.
>
> Paul,
>
> While I understand your concern, please don't forget that the perfect is
> the enemy of the good.
>
> This common clk API has been under development for over *two* years
> already, with several attempts to merge it.  And each previous merge
> attempt aborted because someone came along at the last minute to do
> exactly what you are doing i.e. underline all the flaws and call for a
> redesign.  This is becoming a bad joke.
>
> We finally have something that the majority of reviewers are happy with
> and which should cover the majority of existing cases out there.  Let's
> give it a chance, shall we? Otherwise one might ask where were you
> during those development years if you claim that the behavior and/or API
> of the common clock code still need to change significantly?
>
>> Explicitly stating this is not only simple courtesy to its users, many of
>> whom won't have been privy to its development.  It also is intended to
>> make the code easier to change once it reaches mainline.
>
> The code will be easier to change once it is in mainline, simply due to
> the fact that you can also change all its users at once.  And it is well
> possible that most users won't have to deal with the same magnitude of
> complexity as yours, again reducing the scope for resistance to changes.
>
> Let's see how things go with the current code and improve it
> incrementally.  Otherwise no one will get involved with this API which
> is almost just as bad as not having the code merged at all.
>
>> So, until the API is well-defined and does all that it needs to do for its
>> major users, [...]
>
> No, the API simply can't ever be well defined if people don't actually
> start using it to eventually refine it further.  Major users were
> converted to it, and in most cases The API does all that it needs to do
> already.  Otherwise you'll be stuck in a catch22 situation forever.
>
> And APIs in the Linux kernel do change all the time.  There is no stable
> API in the kernel.  Extensions will come about eventually, and existing
> users (simple ones by definition if the current API already meets their
> needs) should be converted over easily.

+1 to the general idea in Nicolas's email.

To add a few more thoughts, while I agree with Paul that there is room 
for improvement in the APIs, I think the difference in opinion comes 
when we ask the question:

"When we eventually refine the APIs in the future to be more expressive, 
do we think that the current APIs can or cannot be made as wrappers 
around the new more expressive APIs?"

Absolutes are almost never right, so I can't give an absolute answer. 
But I'm strongly leaning towards "we can" as the answer to the question. 
That combined with the reasons Nicholas mentioned is why I think the 
APIs should not be marked as experimental in anyway.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
