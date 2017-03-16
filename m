From: slash.tmp@free.fr (Mason)
Date: Thu, 16 Mar 2017 20:13:15 +0100
Subject: Legacy PCI interrupt support in PCIe host driver
In-Reply-To: <alpine.DEB.2.20.1703161843420.3586@nanos>
References: <5612adb6-af5c-9fbf-e725-813ee7fe1b4b@free.fr>
 <8443b350-6aa6-75f8-af48-892c722fc2d9@free.fr>
 <alpine.DEB.2.20.1703161843420.3586@nanos>
Message-ID: <4e54c5f9-7cc1-cfab-592d-a87795147020@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/2017 18:47, Thomas Gleixner wrote:
> On Thu, 16 Mar 2017, Mason wrote:
>> I guess if two interrupts fire at the same time, we'll just take two
>> separate exceptions?
> 
> Wrong guess. That might work with level interrupts, but with other types
> nothing will raise another exception. Sharing interrupts on edge types is a
> stupid idea, but hardware folks insist on implementing stupid ideas.

When you say "That might work with level interrupts",
what is "that" ?

In my case,

	interrupt-map = <0 0 0 1 &irq0 54 IRQ_TYPE_LEVEL_HIGH>;
	interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;

Both ISRs expect LEVEL_HIGH. In fact, doesn't request_irq
return an error if the triggers are different?

Regards.
