From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 10 Aug 2011 14:12:06 -0600
Subject: How to handle named resources with DT?
In-Reply-To: <20110810195753.GA29134@huya.qualcomm.com>
References: <4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com>
	<20110809205723.GE11568@ponder.secretlab.ca> <4E41A1B9.1060400@ti.com>
	<20110809211747.GJ11568@ponder.secretlab.ca> <4E41AA43.1000506@ti.com>
	<20110809214905.GK11568@ponder.secretlab.ca> <4E41AC5C.20301@ti.com>
	<20110810015214.GD23511@yookeroo.fritz.box>
	<CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
	<20110810195753.GA29134@huya.qualcomm.com>
Message-ID: <CACxGe6sX9n5YBXsWyK=prCCssw169Tga3D+9hwc+qa1zFr3CMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 1:57 PM, David Brown <davidb@codeaurora.org> wrote:
> On Wed, Aug 10, 2011 at 01:22:16PM -0600, Grant Likely wrote:
>
>> Please, stick with the established convention and explicitly order
>> 'reg' and 'interrupts' properties. ?If there is a specific use case
>> where this doesn't work, then bring it up, but I haven't seen any yet.
>> ?The current users of _byname that I've looked seem to only use it for
>> convenience, not because a register range may be optional. ?ie. they
>> all fail out if a reg resource isn't present.
>
> The msm_serial driver uses the presence of one of it's _byname reg
> regions to distinguish between two different types of the controller.
> Fortunately, it is the last register range that has this.
>
> It's probably best to make the DT code depend on compatible (or some
> attribute) to determine if this functionality is available, or in this
> case, even make it a separate memory region. ?I'm not sure what the
> cleanest way is to implement this, and still have the driver work with
> non-DT systems.

You can use the .data field in the match table to add in
compatible-specific configuration data.

g.
