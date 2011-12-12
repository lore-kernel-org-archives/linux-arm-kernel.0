From: michael@walle.cc (Michael Walle)
Date: Mon, 12 Dec 2011 22:55:40 +0100
Subject: arm and patch phys offset
In-Reply-To: <20111212213450.GD20178@n2100.arm.linux.org.uk>
References: <201112112255.32534.michael@walle.cc>
 <201112122212.35506.michael@walle.cc>
 <20111212213450.GD20178@n2100.arm.linux.org.uk>
Message-ID: <201112122255.40092.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag 12 Dezember 2011, 22:34:50 schrieb Russell King - ARM Linux:
> Why do you say that, and what you do mean by "expect the addresses" ?
> Presumably you're saying the addresses will be different.  Why do you
> think that?
> Are you saying that you find that the address of these 'unconverted'
> instructions change each time you run your debug function?
i see different output from the debug function everytime i change the source 
code and recompile the kernel. restarting the same binary results in the same 
unconverted instructions.

> > If it would be some memory corruption, shouldn't the table or the p2v/v2p
> > stubs be corrupt? But the non-patched entries always points to correct
> > v2p/p2v calls and in every case there is the unpatched add/sub
> > instruction.
> 
> Have you tried dumping out the entire instruction as well as the
> address of the unconverted instruction?
yes, the addresses make sense as i can see the unpatched instruction at that 
address in the disassembly and the instruction at these addresses are always:

add/sub rX, rY, #81000000

> Are you running a Thumb-2 kernel?  Which kernel are you running?
what do you mean by which kernel?
linus' master from yesterday, ARCH_KIRKWOOD=y
CONFIG_THUMB2_KERNEL is not set


-- 
Michael
