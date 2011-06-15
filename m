From: thellstrom@vmware.com (Thomas Hellstrom)
Date: Wed, 15 Jun 2011 15:12:21 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory Allocator
	added
In-Reply-To: <BANLkTi=XTJuF4np7+rYHzJqWK20OxMrBsw@mail.gmail.com>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>	<201106141803.00876.arnd@arndb.de>	<op.vw2r3xrj3l0zgt@mnazarewicz-glaptop>	<201106142030.07549.arnd@arndb.de>
	<BANLkTi=XTJuF4np7+rYHzJqWK20OxMrBsw@mail.gmail.com>
Message-ID: <4DF8AFB5.10205@vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2011 01:53 PM, Daniel Vetter wrote:
> On Tue, Jun 14, 2011 at 20:30, Arnd Bergmann<arnd@arndb.de>  wrote:
>    
>> On Tuesday 14 June 2011 18:58:35 Michal Nazarewicz wrote:
>>      
>>> Ah yes, I forgot that separate regions for different purposes could
>>> decrease fragmentation.
>>>        
>> That is indeed a good point, but having a good allocator algorithm
>> could also solve this. I don't know too much about these allocation
>> algorithms, but there are probably multiple working approaches to this.
>>      
> imo no allocator algorithm is gonna help if you have comparably large,
> variable-sized contiguous allocations out of a restricted address range.
> It might work well enough if there are only a few sizes and/or there's
> decent headroom. But for really generic workloads this would require
> sync objects and eviction callbacks (i.e. what Thomas Hellstrom pushed
> with ttm).
>    

Indeed, IIRC on the meeting I pointed out that there is no way to 
generically solve the fragmentation problem without movable buffers. 
(I'd do it as a simple CMA backend to TTM). This is exactly the same 
problem as trying to fit buffers in a limited VRAM area.

/Thomas
