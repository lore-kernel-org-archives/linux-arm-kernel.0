From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 8 Jan 2011 12:30:34 +0000
Subject: [PATCH] [ARM] orion5x: accelerate NAND on the TS-78xx
References: <20110104235158.GQ12386@chipmunk>
	<20110105003316.GJ24935@n2100.arm.linux.org.uk>
	<o7qev7-2en.ln1@chipmunk.wormnet.eu>
Message-ID: <a02mv7-r0e.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Clouter <alex@digriz.org.uk> wrote:
>>
>> On Tue, Jan 04, 2011 at 11:51:59PM +0000, Alexander Clouter wrote:
>>> The NAND supports 32bit reads and writes so lets stop shunting 8bit
>>> chunks across the bus.
>>> 
>>> Doing a dumb 'dd' benchmark, this increases performance roughly like so:
>>>  * read: 1.3MB/s to 3.4MB/s
>>>  * write: 614kB/s to 882kB/s
>> 
>> Try something like the below.  It's slightly more typing, but the
>> underlying string IO functions should improve your transfer speed.
>> Note that they won't do endian conversions.
>>
> I get roughly the same speeds with your approach...I am happy to swing 
> either your way or my original implementation; well actually it was 
> stolen from Nico's orion_nand implementation :)
> 
> What should I submit?  These functions will at somestage get DMA support 
> added.
> 
I decided I prefer your version and it 'hides' the while loops and is 
easier to read.  

Cheers

-- 
Alexander Clouter
.sigmonster says: What!?  Me worry?
                  		-- Alfred E. Newman
