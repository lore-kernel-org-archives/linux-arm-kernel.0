From: slash.tmp@free.fr (Mason)
Date: Tue, 22 Sep 2015 18:08:36 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <20150921161341.GP21084@n2100.arm.linux.org.uk>
References: <56001B78.2090001@free.fr>
 <20150921161341.GP21084@n2100.arm.linux.org.uk>
Message-ID: <56017D04.5010909@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/2015 18:13, Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2015 at 05:00:08PM +0200, Mason wrote:
>> 1) Linux kernel runs in non-secure world. The port used to tweak
>> L2 cache configuration via custom SMC calls to the OS running in
>> secure world. I've removed that for now.
>> Is there a standard solution these days?
> 
> While some configuration can be done by the boot loader (and it's
> preferable for that to happen) not all of it can be.  In particular,
> the kernel _must_ have the ability to enable and disable the L2
> cache, and the kernel must not be called with the L2 cache left
> enabled by the boot loader.
> 
> That requires that the L2 control register is writable in some way
> from the non-secure world.

There is no agreed-upon method to do that?

<grepping around for l2x0_init, outer_cache>

What about Samsung's arch/arm/include/asm/firmware.h ?

Is there an easy way to determine how many arch/arm platforms are running
Linux in non-secure mode? (And thus need to interact with "firmware" or
trustzone OS for things like L2 cache handling, and secondary core boot-up.)

Regards.
