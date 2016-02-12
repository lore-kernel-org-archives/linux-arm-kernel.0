From: dirk.behme@gmail.com (Dirk Behme)
Date: Fri, 12 Feb 2016 16:51:00 +0100
Subject: [PATCH] ARM: imx: Do L2 errata only if the L2 cache isn't enabled
In-Reply-To: <20160212141654.GA10826@n2100.arm.linux.org.uk>
References: <1455261093-11849-1-git-send-email-dirk.behme@de.bosch.com>
 <20160212141654.GA10826@n2100.arm.linux.org.uk>
Message-ID: <56BDFF64.9090701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.02.2016 15:16, Russell King - ARM Linux wrote:
> On Fri, Feb 12, 2016 at 08:11:33AM +0100, Dirk Behme wrote:
>> All the generic L2 cache handling code is encapsulated by a
>> check if the L2 cache is enabled. If it's enabled already, the code
>> is skipped.
>>
>> For the i.MX6 specific L2 cache handling we missed this check.
>> Add it.
>
> What's the reasoning behind this?  The prefetch register is writable
> while the L2 cache is enabled, unlike the auxiliary control register.

 From an internal log I have the following info:

The write to the L2-Cache controller from non-secure world causes an 
imprecise
external abort. If Linux runs from normal world the cache controller 
is already
enabled and thus no configuration is needed by Linux.

Best regards

Dirk
