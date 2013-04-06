From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Apr 2013 15:32:06 +0200
Subject: [PATCH v2 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130405214510.GB16221@obsidianresearch.com>
References: <1365196320-15084-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365196320-15084-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130405214510.GB16221@obsidianresearch.com>
Message-ID: <201304061532.06280.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Jason Gunthorpe wrote:
> I look at this and sort of go 'hmm'. These are basically register
> offsets into the block starting at 0xd0010400. I don't see any
> registers that are shared between targets. It would be simpler to keep
> each target as a seperate node and seperate driver instance.
> 
> Combining that idea with the suggestion for target-id centric mbus DT
> binding:
> 
> bootcs at d0010400 {
>    compatible = "marvell,armada370-devbus";
>    ranges = <0 MAPDEF_BOOTCS 0x1000>
>    reg = <MAPDEF_INTERNAL + 0x10400 0x8>;  // boot cs register set
>    devbus,dev-width = <1>;
>    [..] etc
> 
>    rom at 0 {
>       reg = <0 0x1000>
>    }
> }

+1

Good idea


	Arnd
