From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 10 Aug 2011 13:22:16 -0600
Subject: How to handle named resources with DT?
In-Reply-To: <20110810015214.GD23511@yookeroo.fritz.box>
References: <4E4166F0.9050401@ti.com>
	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
	<4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com>
	<20110809205723.GE11568@ponder.secretlab.ca> <4E41A1B9.1060400@ti.com>
	<20110809211747.GJ11568@ponder.secretlab.ca> <4E41AA43.1000506@ti.com>
	<20110809214905.GK11568@ponder.secretlab.ca> <4E41AC5C.20301@ti.com>
	<20110810015214.GD23511@yookeroo.fritz.box>
Message-ID: <CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 7:52 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Tue, Aug 09, 2011 at 11:53:32PM +0200, Cousson, Benoit wrote:
>> On 8/9/2011 11:49 PM, Grant Likely wrote:
>> >That won't work either because that also breaks the existing 'reg'
>> >binding. ?Anything you do will need to supplement the existing
>> >binding without changing it in an incompatible way.
>>
>> OK, but can we add a new attribute then? reg2, reg_ng, reg_plusplus,
>> reg_named...?
>
> He already suggested reg-names to be interpreted in parallel with the
> existing reg property. ?The (serious) problem with replacing the reg
> property is that it will break all existing OSes (including old Linux
> versions) that don't understand the new property.
>
> Of course, the problem with reg-names is that it will be ignored by
> older OSes, and so 'reg' must still be in the correct order. ?In which
> case you could argue it's more sensible to just have a static place to
> name mapping in the Linux driver.
>
> In short, yes, named reg elements in the DT would be nice in theory,
> but I'm not convinced it's worth a DT flag day to accomplish it.

I'm inclined the same way, though I agree with the replies that point
out it wouldn't result in a 'flag day' because existing bindings
cannot become incompatible.  The problem I have is that adding
reg-names or similar implies that ordering of the reg property is no
longer defined which I absolutely do not think is a good idea.

Please, stick with the established convention and explicitly order
'reg' and 'interrupts' properties.  If there is a specific use case
where this doesn't work, then bring it up, but I haven't seen any yet.
 The current users of _byname that I've looked seem to only use it for
convenience, not because a register range may be optional.  ie. they
all fail out if a reg resource isn't present.

So, the original answer stands, don't use _byname for DT bindings.

g.
