From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarh)
Date: Mon, 18 Jun 2012 11:42:01 +0200
Subject: Dove clock support
In-Reply-To: <20120618084300.GL4799@lunn.ch>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch>
Message-ID: <4FDEF7E9.4030504@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 10:43 AM, Andrew Lunn wrote:
>> Sure, the address layout is different, but that can be made generic in a
>> second step. Maybe we need a private pointer in the gate_fn struct.
>
> Yes, something like that.

You need to pass at least the controllers base address. Everything else
is common - IIRC kirkwood has two SATA, dove only one. Moreover the base
addresses for the second are not defined, yet.

Also ge-phy has to be connected with ge-clk, too. But for dove this is
a clk gate while kirkwood can shut it down somewhere else. I guess it
can be handled like sata/pcie on kirkwood.

>> BTW: who will enable the clocks that have been disabled via the
>> sata/pcie shutdown functions?
>
> This is potentially a problem when the SATA driver is built as a
> kernel module. There is no code that i know of to turn the SATA PHYs
> back on again. I think this has been broken like this for a long
> time...

IMHO the driver should take care of enabling clk and PHYs. In my
understanding of the common clock framework both will be disabled
if no driver requests it.

Sebastian
