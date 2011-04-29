From: thellstrom@vmware.com (Thomas Hellstrom)
Date: Fri, 29 Apr 2011 14:06:12 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104291326.25634.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>	<20110428093039.GU17290@n2100.arm.linux.org.uk>	<1304024836.2513.198.camel@pasglop>
	<201104291326.25634.arnd@arndb.de>
Message-ID: <4DBAA9B4.3070306@vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2011 01:26 PM, Arnd Bergmann wrote:
> On Thursday 28 April 2011, Benjamin Herrenschmidt wrote:
>    
>>>> For PCI you can have the flag propagate from the PHB down, for busses
>>>> without a bus type (platform) then whoever instanciate them (the
>>>> platform code) can set that appropriately.
>>>>          
>>> How can you do that when it changes mid-bus heirarchy?  I'm thinking
>>> of the situation where the DRM stuff is on a child bus below the
>>> root bus, and the root bus has DMA coherent devices on it but the DRM
>>> stuff doesn't.
>>>        
>> But that's not PCI right ? IE. with PCI, coherency is a property of the
>> PHB...
>>      
> That is my understanding at least, but I'd like to have a confirmation
> from the DRM folks.
>
> I believe that the PC graphics cards that have noncoherent DMA mappings
> are all of the unified memory (integrated into the northbridge) kind,
> so they are not on the same host bridge as all regular PCI devices,
> even if they appear as a PCI device.
>    

I think Jerome has mentioned at one point that the Radeon graphics cards 
support
non-coherent mappings.

Fwiw, the PowerVR SGX MMU also supports this mode of operation, although 
it being functional I guess depends on the system implementation.

/Thomas



> 	Arnd
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig
>    
