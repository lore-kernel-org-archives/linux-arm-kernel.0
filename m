From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 22 Apr 2016 08:41:10 -0700
Subject: [PATCH v2] arm-ccn: Fix building as a module
In-Reply-To: <1461324729.2721.93.camel@arm.com> (Pawel Moll's message of "Fri,
 22 Apr 2016 12:32:09 +0100")
References: <1461318211-25151-1-git-send-email-suzuki.poulose@arm.com>
 <1461324729.2721.93.camel@arm.com>
Message-ID: <7hd1ph4pnt.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pawel Moll <pawel.moll@arm.com> writes:

> On Fri, 2016-04-22 at 10:43 +0100, Suzuki K Poulose wrote:
>> arm-ccn driver uses irq_set_affinity, which is not exported and
>> hence cannot be built as a module, eventhough we have all the
>> bits ready. This patch makes use of the exported helper
>> irq_set_affinity_hint() instead. Also, the __free_irq expects
>> the affinity_hint to be NULL when we free the irq. So set the
>> affinity_hint to NULL at clean up.
>>
>> Now that we can build it as a module, update the Kconfig to
>> reflect the change.
>>
>> Applies on 4.6-rc4.
>
> Acked-by: Pawel Moll <pawel.moll@arm.com>
>

Applied to arm-soc/fixes with Pawel's ack.

Kevin
