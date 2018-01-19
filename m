From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 19 Jan 2018 09:21:13 +0100
Subject: [PATCH v2 02/16] ARM: dts: r8a7790: add soc node
In-Reply-To: <20180118002433.GB11924@bigcity.dyn.berto.se>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
 <20180117161717.14589-3-horms+renesas@verge.net.au>
 <20180118002433.GB11924@bigcity.dyn.berto.se>
Message-ID: <CAMuHMdUSfwiB7EUHxtt6VBvX1_KF82LPz9ihr0S_--eQs-v+sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Thu, Jan 18, 2018 at 1:24 AM, Niklas S?derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2018-01-17 17:17:03 +0100, Simon Horman wrote:
>> Add soc node to represent the bus and move all nodes with a base address
>> into this node. This is consistent with handling of R-Car Gen3, RZ/G1, and
>> R-Car V2H (R8A77920) SoCs upstream. It is intended to migrate other R-Car
>> Gen2 SoCs to this scheme.
>>
>> The ordering is derived from simply moving each node with an address up to
>> before any nodes without a base address that occur before the soc node.  To
>> improve maintainability follow-up patches will sort subnodes of both the
>> new soc node and the root node.
>>
>> This patch should not introduce any functional change.
>>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> The 'ranges' property in the soc node is new. I checked the
> documentation and as far as I can make out this is how it should be. But
> I'm not certain why :-)

Please see section 2.3.8 in the Device Tree Specification, either from ePAPR,
or at https://www.devicetree.org/.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
