From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 22:40:19 +0200
Subject: [PATCH 1/4] dt-bindings: Document the STM32 DMA bindings
In-Reply-To: <CAOAejn0x68GaEEfTZbsi5VSJt+Um-bV2Mcmc2pxUwh5QjD=ZYw@mail.gmail.com>
References: <1444317612-818-1-git-send-email-cedric.madianga@gmail.com>
 <15651913.U8kb3JZ9vO@wuerfel>
 <CAOAejn0x68GaEEfTZbsi5VSJt+Um-bV2Mcmc2pxUwh5QjD=ZYw@mail.gmail.com>
Message-ID: <11583587.xphxbMQ7TN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 October 2015 22:25:50 M'boumba Cedric Madianga wrote:
> >
> > How do you know which channels are available for memory-to-memory
> > transfers?
> For memory-to-memory transfer we don't need any channel/request combination.
> We look for any available channel in the channel list to execute our transfer.
> So, as often as possible, we expect that a peripheral release his
> channel after transfering data.
> In that way, we always should have at least one channel available for
> that kind of transfer.
> 

Ah, got it. So the use of virtual channels in this driver makes MEM2MEM
transfers work, but is otherwise not required.

Thanks for the clarification.

	Arnd
