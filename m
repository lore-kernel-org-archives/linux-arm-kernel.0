From: andy@warmcat.com (Andy Green)
Date: Fri, 12 Mar 2010 11:13:39 +0000
Subject: bit errors on spitz
In-Reply-To: <1268390588.4963.66.camel@utx.utx.cz>
References: <20100305212708.GC21773@elf.ucw.cz>	
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>	
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>	
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>	
	<4B98EF5D.5000609@warmcat.com>
	<1268322155.3990.114.camel@hammer.suse.cz>	
	<4B995EE1.1050609@warmcat.com>
	<1268384824.4963.35.camel@utx.utx.cz>	
	<4B9A0A71.7010206@warmcat.com>
	<1268390588.4963.66.camel@utx.utx.cz>
Message-ID: <4B9A21E3.4020607@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/10 10:43, Somebody in the thread at some point said:
> Andy Green wrote:
>
>> In that case is the PXA CF driver PIO?  Then it can be the same load on
>> Vcore issue in disguise.
>
> There is a proprietary ASIC chip (Sharp Scoop) that handles CF and HDD
> access (and also several additional GPIOs):
> http://www.penguin.cz/~utx/zaurus/datasheets/ASIC_S1L50752B26B200/412752.PDF

Right but not thinking about its power arrangements, rather the load on 
the CPU itself when it's transferring data to / from CF interface (via 
this ASIC).

If the ASIC has bus master DMA and that's used by the driver then fair 
enough, otherwise if it is done by PIO in the driver "while using CF" 
(as mentioned in most symptoms) becomes the same as saying "during 100% 
load on CPU" which is what leads to dents in Vcore and potential 
instability by that same Vcore path.

-Andy
