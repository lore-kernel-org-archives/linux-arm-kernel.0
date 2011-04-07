From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Apr 2011 18:39:12 +0100
Subject: [PATCH 0/2] ARM: Unify setup for Marvell SheevaPlugs and
	Seagate DockStars
In-Reply-To: <4D9D8762.3080207@ahsoftware.de>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<4D9CEE24.1080501@erfurth.eu> <4D9D81ED.7090809@ahsoftware.de>
	<4D9D85E4.2040606@erfurth.eu> <4D9D8762.3080207@ahsoftware.de>
Message-ID: <20110407173912.GA17049@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2011 at 11:44:02AM +0200, Alexander Holler wrote:
> Am 07.04.2011 11:37, schrieb Nico Erfurth:
>> Alexander Holler wrote:
>>
>>> I wonder how many people believe that either there will be another
>>> DockStar with the same HW and GPIOs for the LEDs but more memory (and
>>> still without sata) or that there will be another SheevaPlug with just
>>> 128MB RAM or that someone could have a reason to change the memory
>>> layout using a mem= parameter.
>>>
>>> For me all that is pretty unlikely.
>>
>> As Nicolas stated it's not just about "Oh, thats totally unlikely to
>> happen!". It is about maintainable code, if somebody looks at it in 3
>> years they should not think "WTF?!?!". Using machine ids and the
>> generated macros helps to keep the code clean and readable.
>
> Sorry, I can't agree. For me some unique hardware identifier is more  
> reasonable, than some machine id which comes from outerspace.

I agree 100% with Nicolas - using memory size is far from obvious and
is not clean and understandable.  Using memory size as a way of detecting
the machine type is far worse than just mere "silly".

We have an established API and convention in the kernel which you claim
is "from outerspace".  It's not "from outerspace" but a designed API to
allow platforms to live together in the same kernel image.  So I find
your arguments totally unreasonable.

I fully support Nicolas in rejecting your patches outright on this point
alone.
