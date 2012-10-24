From: robherring2@gmail.com (Rob Herring)
Date: Wed, 24 Oct 2012 12:42:26 -0500
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210241238570.1282-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210241238570.1282-100000@iolanthe.rowland.org>
Message-ID: <50882882.1090806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 11:44 AM, Alan Stern wrote:
> On Wed, 24 Oct 2012, Stephen Warren wrote:
> 
>> We should absolutely avoid Linux-specific properties where possible.
>>
>> That said, what Linux-specific properties are you talking about? The
>> properties discussed here (has-synopsys-hc-bug, no-io-watchdog, has-tt)
>> are all purely a description of HW, aren't they.
> 
> "has-tt" is definitely a description of the HW.

Can you spell out tt.

> "has-synopsys-hc-bug" is too, although determining whether or not it 
> should apply to a particular controller might be difficult.  I'm 
> inclined not to include it among the properties.

What happens when there are 2 synopsys hc bugs? Something more specific
about what the bug is would be better.

> "no-io-watchdog" is not the greatest name.  It describes to controllers 
> that always do generate IRQs for I/O events when they are supposed to 
> (and hence the driver doesn't need to set up a watchdog timer to detect 
> I/O completions that didn't generate an IRQ).  So while the concept is 
> HW-specific, the name refers to a driver implementation issue.  A 
> better name might be something like "reliable-IRQs".  Again, it's not 
> such an easy thing to test for.  Almost all the existing drivers leave 
> it unset.

Shouldn't the default be reliable irqs? What about "unreliable-irqs"?

Rob
