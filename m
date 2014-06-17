From: ipaton0@gmail.com (Iain Paton)
Date: Tue, 17 Jun 2014 15:08:28 +0100
Subject: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
In-Reply-To: <20140617090931.GB3705@n2100.arm.linux.org.uk>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
 <20140617090931.GB3705@n2100.arm.linux.org.uk>
Message-ID: <53A04BDC.1060403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/14 10:09, Russell King - ARM Linux wrote:

> Why should kernel developers go to the extent of adding support for DT
> modification at runtime when the platform you want this for doesn't even
> support hotplugging of these capes?

I'm not convinced you should, but Grant Likely seemed to be much more open 
to the idea with the latest attempt https://lkml.org/lkml/2014/5/29/586

> A good way that this could have been done is to put an I2C EEPROM on
> each cape, and have that store the DT fragment.  The boot loader could
> have then read that from each cape, and used that information to build
> up the final DT.  Why this hasn't been thought of, considering that the
> kernel has been moving towards DT for years, is quite unbelievable.

I believe that was Jasons original idea.

>From a users perspective, a fixed DT fragment in EEPROM quickly ends up 
being out of step with OS implementation and simply becomes another 
pain point that needs worked around.

Anyway, there already exist capes in large scale production that don't 
have the EEPROM. As well as ones that use the required I2C bus for other 
purposes, thereby blocking all other capes connected at the same time 
from using that mechanism even when they are capable of doing so.
Not forgetting the number of capes that have shipped already without the
DT fragment in their EEPROMS.

Too late to shut the barn door, question is where to go from here.

Consolidation the dt knowledge in one tree is a good idea, regardless of 
how it's eventually used.
