From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 15 Jun 2011 08:16:37 -0700
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <20110615073935.GA28989@n2100.arm.linux.org.uk>
References: <20110614190850.GA13526@linux-mips.org>
	<987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
	<4DF8359F.10809@zytor.com>
	<20110615073935.GA28989@n2100.arm.linux.org.uk>
Message-ID: <4DF8CCD5.3080005@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2011 12:39 AM, Russell King - ARM Linux wrote:
> On Tue, Jun 14, 2011 at 09:31:27PM -0700, H. Peter Anvin wrote:
>> On 06/14/2011 03:08 PM, Luck, Tony wrote:
>>> I took a look at the back of all my ia64 systems - none of them
>>> have a parallel port.  It seems unlikely that new systems will
>>> start adding parallel ports :-)
>>>
>>> So even if I had a printer (or other device) that used a parallel
>>> port, I have no way to test it.
>>
>> If it has PCI slots, it can have a parallel port.
> 
> Is that a clue about where a select statement should be?

Not really, because it's a sufficient condition, not a required one.

All a platform needs to expose a PC-style parallel port interface is a
minimum of 3 contiguous I/O locations, and although in the PC they are
I/O mapped, they don't need to be.

The basic (SPP) parallel port interface is really just a glorified set
of GPIOs and could at least in theory be implemented as-is on any
platform with contiguous GPIO ports.  The faster modes (EPP and ECP) do
contain logic, and ECP depends on the ISA DMA API (thanks to Russell for
pointing out that actual ISA DMA is not required, any slave DMA solution
will do.)


	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
