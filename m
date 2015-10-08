From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 21:26:07 +0200
Subject: [PATCH 1/4] dt-bindings: Document the STM32 DMA bindings
In-Reply-To: <CAOAejn0y+6uFbho3iv37xh6=zKevnp_6MxOEw4e9Oc4U2x_csQ@mail.gmail.com>
References: <1444317612-818-1-git-send-email-cedric.madianga@gmail.com>
 <13614799.2Hi64P0fJ2@wuerfel>
 <CAOAejn0y+6uFbho3iv37xh6=zKevnp_6MxOEw4e9Oc4U2x_csQ@mail.gmail.com>
Message-ID: <15651913.U8kb3JZ9vO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 October 2015 18:01:23 M'boumba Cedric Madianga wrote:
> Hi Arnd,
> 
> 2015-10-08 17:43 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 08 October 2015 17:20:09 M'boumba Cedric Madianga wrote:
> >> +Each dmas request consists of 5 cells:
> >> +1. A phandle pointing to the STM32 DMA controller
> >> +2. The channel id
> >> +3. The request line number
> >> +4. A 32bit mask specifying the DMA channel configuration
> >>
> >
> > It's fairly unusual to encode the channel id here, rather than
> > letting the driver pick one. Is that actually required here?
>
> Yes it is required as in STM32 platform the channel/request DMA
> mapping is done by hardware lines.
> So, if one client wants to use DMA, he has to choose the correct
> channel/request values according to the DMA mapping of his STM32
> platform.
 
Interesting. So you have seven channels ans seven request lines,
with a random but fixed mapping between them?

How do you know which channels are available for memory-to-memory
transfers?

	Arnd
