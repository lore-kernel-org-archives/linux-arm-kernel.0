From: ben@smart-cactus.org (Ben Gamari)
Date: Thu, 03 Dec 2015 12:21:33 +0100
Subject: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420,
 and 5422
In-Reply-To: <20151203103703.GC2097@ubuntu>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <20151203060527.GH4302@ubuntu> <877fkv4ylk.fsf@smart-cactus.org>
 <20151203103703.GC2097@ubuntu>
Message-ID: <87y4db3hhe.fsf@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 03-12-15, 11:26, Ben Gamari wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> > But, before I start reviewing this series, I have few comments.
>> > - We weren't able to use cpufreq-dt driver for big LITTLE platforms
>> >   earlier, as it never had multi cluster support and we wanted
>> >   clock-sharing information via DT.
>> 
>> Fair enough.
>> 
>> > - That is all fixed now.
>> 
>> I did not see any mention of this in the cpufreq-dt driver binding
>> documentation, otherwise I would have tried going this route.
>> 
>> Do you have any references? I'd be happy to examine what would be
>> necessary to go this route although, being an independent contributor,
>> it may take time.
>
> You wouldn't find in cpufreq-dt documentation as its not specific to
> that. I have seen you DT patches now, and you have created the OPP
> tables mostly correctly. Just create the cpufreq-platform device for
> cpufreq-dt instead of arm-big-little one. And it should just work.
>
Do you mean something along these lines? [1]

>> Sounds reasonable to me. However, I'd just like to reiterate that this
>> line of work can be pursued independently from the upstreaming of this
>> series.
>
> I think this is the right time to upstream the right solution. Just
> try it once, if you face lots of difficulties or issues, then we can
> ofcourse see..
>
Sure. I didn't realize things were so close to being functional. Thanks
for the hint. I'll give it a shot next time my XU4 is free.

> NOTE: Check how OPP nodes are required to be created now in
> linux-next. They should be named like opp@<freq-hz>. Something I
> noticed in your DTs.
>
I've fixed this in the branch.

Thanks again.

Cheers,

- Ben


[1] https://github.com/bgamari/linux/commit/285778aaff464d4dcf152f3e9e0df3d8c6909576
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/b1e97e1c/attachment.sig>
