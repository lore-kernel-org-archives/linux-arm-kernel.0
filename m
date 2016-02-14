From: dirk.behme@gmail.com (Dirk Behme)
Date: Sun, 14 Feb 2016 09:30:06 +0100
Subject: [PATCH] ARM: imx: Do L2 errata only if the L2 cache isn't enabled
In-Reply-To: <20160214081857.GQ6756@tiger>
References: <1455261093-11849-1-git-send-email-dirk.behme@de.bosch.com>
 <20160212141654.GA10826@n2100.arm.linux.org.uk> <56BDFF64.9090701@gmail.com>
 <20160214081857.GQ6756@tiger>
Message-ID: <56C03B0E.9000809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.02.2016 09:18, Shawn Guo wrote:
> On Fri, Feb 12, 2016 at 04:51:00PM +0100, Dirk Behme wrote:
>> On 12.02.2016 15:16, Russell King - ARM Linux wrote:
>>> On Fri, Feb 12, 2016 at 08:11:33AM +0100, Dirk Behme wrote:
>>>> All the generic L2 cache handling code is encapsulated by a
>>>> check if the L2 cache is enabled. If it's enabled already, the code
>>>> is skipped.
>>>>
>>>> For the i.MX6 specific L2 cache handling we missed this check.
>>>> Add it.
>>>
>>> What's the reasoning behind this?  The prefetch register is writable
>>> while the L2 cache is enabled, unlike the auxiliary control register.
>>
>>  From an internal log I have the following info:
>>
>> The write to the L2-Cache controller from non-secure world causes an
>> imprecise
>> external abort. If Linux runs from normal world the cache controller
>> is already
>> enabled and thus no configuration is needed by Linux.
>
> Dirk,
>
> Do you have a real use case of this, i.e. running Linux on i.MX6 in
> non-secure world?


Yes, in a scenario where one of the cores runs a RTOS.


Best regards

Dirk
