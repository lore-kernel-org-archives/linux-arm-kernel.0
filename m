From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 29 Mar 2017 10:07:51 +0200
Subject: [PATCH 1/2] dt-bindings: Document the STM32 MDMA bindings
In-Reply-To: <CAL_JsqLMn7W=r+JRX51zOScs9N04PcTtX8EFy2eacwadCxwaRg@mail.gmail.com>
References: <1489417599-31308-1-git-send-email-cedric.madianga@gmail.com>
 <1489417599-31308-2-git-send-email-cedric.madianga@gmail.com>
 <20170320215250.wwhq6lzwe45jmwks@rob-hp-laptop>
 <CAOAejn10dPjYTj8vBTDj5bc_RPTmkYC7uuBMPnP-R0BsQiRwhw@mail.gmail.com>
 <CAL_JsqLMn7W=r+JRX51zOScs9N04PcTtX8EFy2eacwadCxwaRg@mail.gmail.com>
Message-ID: <CAOAejn2zkVDBPwxvid32TPt-cParDkxFMd+uqr+tnRxbHMj7LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> stm32 is not a specific SoC. Compatible strings should be specific to
> an SoC (with fallback strings to whatever they are compatible with) so
> you can handle SoC specific differences or errata.

Ok I see. I will add a more specific SoC description in my compatible.
Thanks.


> I still don't understand. Is the difference in DMA addresses vs. CPU
> addresses? If so, you should dma-ranges to translate these.

Not really.
In fact, the MDMA controller provides a master AXI interface for
memories like DDR/SRAM and peripheral registers access (system access
port).
It also provides a master AHB interface only for Cortex-M7 TCM memory
access (TCM access port).
So the goal of this st,ahb-addr-masks property is to list all TCM
addresses avalaible in the SoC, in order to correctly configure the
MDMA as an AHB master in that particular case.
For all other cases (other memories or peripheral registers access),
the MDMA will act as AXI master.

Hope it helps to understand.

BR,
Cedric
