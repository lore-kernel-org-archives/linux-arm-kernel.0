From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Wed, 3 Feb 2010 16:02:40 +0100
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203132824.GA27048@n2100.arm.linux.org.uk>
References: <20100203005038.GA16356@caradoc.them.org>	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
Message-ID: <4B699010.6010203@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux a ?crit :
> On Wed, Feb 03, 2010 at 11:52:22AM +0000, Catalin Marinas wrote:
>> On Wed, 2010-02-03 at 00:50 +0000, Daniel Jacobowitz wrote:
>>> On Tue, Feb 02, 2010 at 10:43:22PM +0000, Russell King - ARM Linux
>>> wrote:
>>>> Umm, today there were patches posted using hardware support for
>>>> breakpoints / watchpoints.  I've not read through those patches
>>>> yet, but in light of hardware support, do we really need this patch
>>>> anymore?
>>> Yes, it's unrelated.  Hardware breakpoints are a constrained resource,
>>> but we can insert unlimited software breakpoints (and often need to
>>> exceed the hardware breakpoint limit).
>> I agree, we still need support for software breakpoints.
>>
>> The main benefit of hardware debugging support is for watchpoints.
> 
> Software breakpoints are a pain in the backside if you have threaded
> programs, because when you insert a breakpoint into one thread, it's
> active in all threads - you can't insert a breakpoint into only one
> thread.
> 
An annoying things about software breakpoints is that gdb doesn't
understand arm kernel helper (for atomic operation/tls). And when it try
to set breakpoint here it fails...

Matthieu
