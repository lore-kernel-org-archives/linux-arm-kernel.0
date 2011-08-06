From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Sun, 7 Aug 2011 00:13:48 +0200
Subject: experience with the new arm-soc workflow (Was: Re:
	[Ksummit-2011-discuss] ARM Maintainers workshop at Kernel Summit) 2011
In-Reply-To: <alpine.LFD.2.00.1108061742490.20358@xanadu.home>
References: <CACxGe6u3jrhnmL=QwCevm5ybgtGqdOzmGZpfve02M12e9v6pNQ@mail.gmail.com>
	<CAOesGMhgd9Grs7JErJ1pTY4fD_taX_YSpeKx_QS21dp2UN=vMQ@mail.gmail.com>
	<20110806212932.GT31521@pengutronix.de>
	<alpine.LFD.2.00.1108061742490.20358@xanadu.home>
Message-ID: <CAHXqBF+BAdNo3NB9gk0o_aTHUxyQRHw_AvM5ok9zn2yk4NsRZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/6 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Sat, 6 Aug 2011, Uwe Kleine-K?nig wrote:
>
>> My thoughts about the fixes-cleanups-newfeatures separation is that it
>> makes contributing harder than before.
>>
>> Consider I want to contribute a series consisting of a cleanup and a new
>> feature (that depends on the cleanup). And I want (or even need) to base
>> this on (say) Sascha's imx tree that already has some other features.
>> Now the cleanup patch should go on Sascha's (eventually empty) cleanup
>> branch. But for the feature patch to go on top of both Sascha's feature
>> branch and his new cleanup branch, he either needs so rebase his feature
>> branch (which is (at least considered) bad) or he has to merge. I'd say
>> merging is the correct approach, but the history tends to be more ugly
>> than without the separation between cleanups and new features.
>> And if Sascha wants to pull from me (opposed to apply the patches
>> himself) he needs two merges.
>> (So it results in one merge more than before for both cases.)
>>
>> I'm not sure how welcomed these additional merges are by Linus.
>>
>> The obvious (to me) ways out are:
>> ?a) Linus can live with these merges; or
>> ?b) drop the separation between cleanup and features; or
>> ?c) Sascha doesn't publish a (fast-forward-only) tree but works with
>> ? ? a patch queue or git-rebase; or
>> ?d) Sascha keeps my series separate from his other stuff and requests
>> ? ? Arnd to pull two (or more) cleanup branches and two (or more)
>> ? ? feature branches; or
>> ?e) Sascha needs something like topgit;
>>
>> As this problem didn't occur yet in real life, there might be
>>
>> ?f) there is no real problem.
>
> Don't forget:
>
> g) There are no hard rules.
>
>> I fear a) and f) don't apply, I don't like c) and d) and I know
>> Sascha won't like e).
>> So there might only be b) left unless there is some g) I don't see.
>
> Good judgment always prevails. ?If you need to merge something in your
> branch, there is no problem with you asking Sascha to merge the result
> of that merge, and in turn Sascha asking the result to be merged by
> Arnd, etc. ?Suffice that you justify why you want that merge, how it
> makes your contribution for the added feature on top easier, etc. ?If
> the upstream maintainer asks otherwise then just try to convince that
> maintainer. ?If you are right then you shouldn't have too many problem
> convincing people.
>
> But at least always considering the fix/cleanup/feature split initially
> is certainly a good practice since that works well in most cases, and
> when that works, this makes your upstream maintainer's life a bit
> easier.

I, as another contributor, share Uwe's point of view. The problem with
cleanups vs features is that either usually depends on the other.
Fixes are a different beasts and they usually go in asynchronously
(and quicker) to development changes. The split fixes/development
works well in networking area (net and net-next trees).

Best Regards,
Micha? Miros?aw
