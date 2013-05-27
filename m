From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 May 2013 00:12:46 +0200
Subject: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround
 on DT ethernet
In-Reply-To: <1369691406.3557.35.camel@pasglop>
References: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <51A33447.80305@gmail.com> <1369655404.3557.33.camel@pasglop>
 <2255648.0KEmXfjCx5@wuerfel> <1369691406.3557.35.camel@pasglop>
Message-ID: <51A3DA5E.6080501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2013 11:50 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-27 at 14:47 +0200, Arnd Bergmann wrote:
>> On Monday 27 May 2013 21:50:04 Benjamin Herrenschmidt wrote:
>>> However, that wouldn't help much with the allocation/leak problem,
>>> though at least it would be easier to use. It could also *try* to re-use
>>> the current allocation if the new content is of smaller or equal size.
>>
>> I thought that dtc tried to aggressively save space by folding identical
>> strings. If you tried to reuse a property that had its contents shared
>> with another one, you would get interesting results I guess.
>
> It used to be only property names, unless that has changed in recent
> dtc. But that's a good point, we probably want a flag in struct property
> like we have for nodes, indicating whether it comes from the original
> fdt data pool or not.

But isn't that what current sparc implementation of of_set_property does
when it marks the property as dynamic?

Anyway, this definitely exceeds my knowledge of OF API for sure, so what
do I do about the MAC workaround now?

Prepare the patch with global arrays and switch to some of_set_property
as soon as it is available?

Sebastian
