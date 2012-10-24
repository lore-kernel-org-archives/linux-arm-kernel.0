From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 24 Oct 2012 10:48:35 -0600
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210241238570.1282-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210241238570.1282-100000@iolanthe.rowland.org>
Message-ID: <50881BE3.9020702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 10:44 AM, Alan Stern wrote:
> On Wed, 24 Oct 2012, Stephen Warren wrote:
> 
>> We should absolutely avoid Linux-specific properties where possible.
>>
>> That said, what Linux-specific properties are you talking about? The
>> properties discussed here (has-synopsys-hc-bug, no-io-watchdog, has-tt)
>> are all purely a description of HW, aren't they.
> 
> "has-tt" is definitely a description of the HW.

OK.

> "has-synopsys-hc-bug" is too, although determining whether or not it 
> should apply to a particular controller might be difficult.  I'm 
> inclined not to include it among the properties.
> 
> "no-io-watchdog" is not the greatest name.  It describes to controllers 
> that always do generate IRQs for I/O events when they are supposed to 
> (and hence the driver doesn't need to set up a watchdog timer to detect 
> I/O completions that didn't generate an IRQ).  So while the concept is 
> HW-specific, the name refers to a driver implementation issue.  A 
> better name might be something like "reliable-IRQs".  Again, it's not 
> such an easy thing to test for.  Almost all the existing drivers leave 
> it unset.

OK, I'd be inclined to drive those last two by quirks then, since they
aren't architectural features of EHCI but rather implementation issues.
And indeed have the quirk table have a "reliable IRQs" field instead of
"no IO watchdog", to minimize the table size.
