From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Mon, 24 Mar 2014 21:30:35 +0100
Subject: [PATCH 2/3] IXP4xx: Fix DMA masks.
In-Reply-To: <20140324145000.4098c8c7@marrow.netinsight.se> ("Simon
 =?utf-8?B?S8OlZ3N0csO2bSIncw==?= message of "Mon, 24 Mar 2014 14:50:00
 +0100")
References: <m3siq9iyt2.fsf@intrepid.localdomain>
 <m37g7liwdb.fsf@intrepid.localdomain>
 <20140324145000.4098c8c7@marrow.netinsight.se>
Message-ID: <m3vbv37310.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:

> I would simply remove the #ifdef CONFIG_PCI statements: dev_is_pci(dev)
> should return false at compile time if CONFIG_PCI is not set, and then
> I'd trust the compiler to simply remove all dead code.

This will be the same with these #ifdefs. I can imagine someone using
other compiler or e.g. -O0, and without the #ifdefs the link would fail
due to unavailability of DMA bouncer.
-- 
Krzysztof Halasa
