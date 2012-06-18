From: mkl@blackshift.org (Marc Kleine-Budde)
Date: Mon, 18 Jun 2012 10:28:54 +0200
Subject: Dove clock support (was: Re: RFC: [PATCH] ARM: Kirkwood:
 clk_register_gate_fn: add fn assignment)
In-Reply-To: <20120618080449.GK4799@lunn.ch>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch>
Message-ID: <4FDEE6C6.2060101@blackshift.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sebastian,

On 06/18/2012 10:04 AM, Andrew Lunn wrote:
>> BTW: I'm hacking on the dove clock support, I noticed that dove can make
>> use of the same ethernet and pci phy shutdown functions than kirkwood.
>> What about moving kirkwood_register_gate_fn and subfunctions to plat-orion?
> 
> Please coordinate with Sebastian.hesselbarth
> <Sebastian.hesselbarth@googlemail.com> He has done some work in the
> same area.
> 
> I would probably move the kirkwood_register_gate_fn() stuff to
> drivers/clk. Also, the pcie and sata shutdown functions need
> generalizing if they are the be re-used. The address map on Dove is
> different to Kirkwood, so the registers are in different places.

Sure, the address layout is different, but that can be made generic in a
second step. Maybe we need a private pointer in the gate_fn struct.

BTW: who will enable the clocks that have been disabled via the
sata/pcie shutdown functions?

cheers, Marc
