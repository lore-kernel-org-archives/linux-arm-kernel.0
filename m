From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 17 Nov 2014 22:07:53 +0000
Subject: mvebu: tclk detection for armada-xp and marvell packet
 processor with integrated CPU
In-Reply-To: <20141117215543.GC4080@lunn.ch>
References: <546959A3.9040206@alliedtelesis.co.nz>
 <20141117093437.0ca5a3ef@free-electrons.com>
 <546A5714.2090100@alliedtelesis.co.nz> <20141117215543.GC4080@lunn.ch>
Message-ID: <546A71B8.3060606@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/18/2014 10:55 AM, Andrew Lunn wrote:
>> Yeah I'm still trying to wrestle that information out of Marvell. What I
>> do know is for the eval board I've got the armada register SAR (offset
>> 0x18230) is all zeros. I'm not sure if this is because everything really
>> strapped low or because this register is unused on the PP.
>
> Do the CPU SAR pins even make it out of the package? It could be when
> the synthesised the CPU they hard coded it all and throw away the SAR.
>

That's a possibility. The other thing that they may have done is 
incorporated the SAR pins for the CPU with the SAR pins for the packet 
processor. That could be a little tricky because then I'd have to start 
opening up windows for the PP registers early in the kernel init.
