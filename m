From: ben@smart-cactus.org (Ben Gamari)
Date: Thu, 03 Dec 2015 11:26:31 +0100
Subject: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420,
 and 5422
In-Reply-To: <20151203060527.GH4302@ubuntu>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <20151203060527.GH4302@ubuntu>
Message-ID: <877fkv4ylk.fsf@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> Hi Ben,

Hi Viresh,

> On 02-12-15, 22:19, Ben Gamari wrote:
>> 
>> This patch series adds cpufreq support for the Exynos 5800, 5420, and 5422
>> SOCs. In particular, it adds support for operating-points-v2 bindings to the
>> arm-big-little cpufreq driver and updates the above-mentioned SOCs' devicetrees
>> to take advantage of this support. There are also a couple of patches improving
>> the clarify of the arm-big-little implementation. It is built on a set posted
>> by Bartlomiej Zolnierkiewicz in April 2015.
>> 
>> The most signficant change from the original series is porting to the
>> operating-points-v2 devicetree bindings. The series has been tested by me on
>> and Odroid XU4 and by Javier Martinez Canillas on a Peach Pit.
>
> Thanks for working with opp-v2 bindings, really appreciate it.

My pleasure.

> But, before I start reviewing this series, I have few comments.
> - We weren't able to use cpufreq-dt driver for big LITTLE platforms
>   earlier, as it never had multi cluster support and we wanted
>   clock-sharing information via DT.

Fair enough.

> - That is all fixed now.

I did not see any mention of this in the cpufreq-dt driver binding
documentation, otherwise I would have tried going this route.

Do you have any references? I'd be happy to examine what would be
necessary to go this route although, being an independent contributor,
it may take time.

> - I want Samsung's big LITTLE platforms to use cpufreq-dt and drop
>   arm_big_little driver completely.

That sounds like a great direction going forward. However, I would still
kindly request that you consider this series.

The existence of future plans of course does not change the fact that
users have real hardware today; hardware that they have spent money on
and would like to use. Cpufreq support has already been deferred once
for similar reasons of interface churn which essentially forestalled
working functionality from entering the kernel by eight months; I'd
really like to avoid having this happen again.

> - The only case for which it (arm_big_little) driver might be useful
>   is the IKS solution. Which I don't believe you are going to use in
>   future :)

Indeed.

> My plan for the arm-big-little driver:
> - Migrate all platforms to use cpufreq-dt instead for non-IKS
>   solution
> - Make arm-big-little driver arm-big-little-iks only driver.

Sounds reasonable to me. However, I'd just like to reiterate that this
line of work can be pursued independently from the upstreaming of this
series.

Thanks for your time,

- Ben
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/43ae442c/attachment.sig>
