From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 06 Jun 2013 02:01:14 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
Message-ID: <1733666.lHUBcfUXq9@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 of June 2013 00:54:02 luke.leighton wrote:
> On Thu, Jun 6, 2013 at 12:40 AM, Henrik Nordstr?m
> 
> <henrik@henriknordstrom.net> wrote:
> > tor 2013-06-06 klockan 00:26 +0100 skrev luke.leighton:
> >>  no john - they've only added it to the multiplexed sections of the
> >> 
> >> drivers which they themselves have written.  such as
> >> drivers/usb/sun{N}i_usb/*.[ch], drivers/block/nand/sun{N}_i,
> >> arch/arm/mach-sun{N}i and so on.
> > 
> > And a number of SPI device drivers, USB device drivers, vendor
> > provided
> > device drivers, ......
> > 
> >> the script.fex system deals with the pinmux issue in a very neat way 
that:
> >>   a) has very little impact on the rest of the kernel tree [citation
> >> 
> >> needed!  i'm saying that: could someone please confirm if it's true]
> > 
> > Not really the case. Actually the opposite. DT have this as well, and
> > integrated in device probing. Allwinner need to hack every driver used
> > to add their gpio requests to have pinmuxing triggered.
> 
>  augh.  ok.  solutions.  what are the solutions here?

I don't see any other solution here than moving all the Allwinner code to 
DT (as it has been suggested in this thread several times already), as 
this is the only hardware description method supported by ARM Linux.

Best regards,
Tomasz
