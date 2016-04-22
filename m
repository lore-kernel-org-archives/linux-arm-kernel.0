From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 22 Apr 2016 09:44:48 -0700
Subject: [PATCH v2] arm-ccn: Fix building as a module
In-Reply-To: <571A5041.5010908@arm.com> (Suzuki K. Poulose's message of "Fri,
 22 Apr 2016 17:24:33 +0100")
References: <1461318211-25151-1-git-send-email-suzuki.poulose@arm.com>
 <1461324729.2721.93.camel@arm.com> <7hd1ph4pnt.fsf@baylibre.com>
 <571A5041.5010908@arm.com>
Message-ID: <7h7ffp4mpr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suzuki K Poulose <Suzuki.Poulose@arm.com> writes:

> On 22/04/16 16:41, Kevin Hilman wrote:
>> Pawel Moll <pawel.moll@arm.com> writes:
>>
>>> On Fri, 2016-04-22 at 10:43 +0100, Suzuki K Poulose wrote:
>>>> arm-ccn driver uses irq_set_affinity, which is not exported and
>>>> hence cannot be built as a module, eventhough we have all the
>>>> bits ready. This patch makes use of the exported helper
>>>> irq_set_affinity_hint() instead. Also, the __free_irq expects
>>>> the affinity_hint to be NULL when we free the irq. So set the
>>>> affinity_hint to NULL at clean up.
>>>>
>>>> Now that we can build it as a module, update the Kconfig to
>>>> reflect the change.
>>>>
>>>> Applies on 4.6-rc4.
>>>
>>> Acked-by: Pawel Moll <pawel.moll@arm.com>
>>>
>>
>> Applied to arm-soc/fixes with Pawel's ack.
>
> Kevin,
>
> Please note that there is a change to Kconfig for ARM_CCN. So if you
> think changes to Kconfig shouldn't be pushed as a fix, by all means you
> can push this to 4.7.
>
> The title of the patch doesn't convey that. Sorry about that.

Thanks, I was just noticing that and thinking that at this stage of the
-rc, that would better wait for v4.7.

Please resumit later for v4.7

Thanks,

Kevin
