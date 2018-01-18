From: hch@lst.de (Christoph Hellwig)
Date: Thu, 18 Jan 2018 16:23:31 +0100
Subject: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound
 traffic
In-Reply-To: <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-5-git-send-email-jim2101024@gmail.com>
 <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
 <20180118073123.GA15766@lst.de>
 <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
Message-ID: <20180118152331.GA24461@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 07:09:23AM -0800, Florian Fainelli wrote:
> >But in this case it actually is the example to follow as told
> >previously.
> >
> >NAK again for these chained dma ops that only create problems.
> 
> Care to explain what should be done instead?

Override phys_to_dma and dma_to_phys as mips and x86 do for similar
situations.

Bonous points of finding some generic way of doing it instead of
hiding it in arch code.
