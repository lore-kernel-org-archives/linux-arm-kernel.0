From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 16:23:16 +0100
Subject: [PATCH V3] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <CAL_Jsq+J3izFDepJ04Lb=caUOKJ4eNja0NrhqowyCOEPBVAPdA@mail.gmail.com>
References: <1414503414-3863-1-git-send-email-suravee.suthikulpanit@amd.com>
 <8642876.4lpJWZTuhf@wuerfel>
 <CAL_Jsq+J3izFDepJ04Lb=caUOKJ4eNja0NrhqowyCOEPBVAPdA@mail.gmail.com>
Message-ID: <4486649.FEg9dS3gj1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 09:16:31 Rob Herring wrote:
> 
> >> +             dma-coherent;
> >> +     };
> >
> > Same here: you list it as coherent, but not 64-bit DMA capable.
> > Is that intentional?
> 
> AHCI controllers are probeable as to whether they support 64-bit DMA or not.
> 

The controller is, but the bus is not, so we also need the dma-ranges
property in the bus.

	Arnd
