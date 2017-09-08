From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 8 Sep 2017 15:57:03 +0100
Subject: [PATCH 3/3] dmaengine: sun6i: Add support for Allwinner A64
In-Reply-To: <20170908143913.6ga64ssakvk2mjis@flea.lan>
References: <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
 <20170901003135.10058-1-andre.przywara@arm.com>
 <20170901060445.vboici7qxfkztp3s@flea>
 <743ae23a-372a-762b-c345-b914f09fd718@arm.com>
 <20170904070415.e6nclz5n23bo7f4v@flea>
 <d3d32839-12a8-71fa-cfec-03055d64388d@arm.com>
 <20170908143913.6ga64ssakvk2mjis@flea.lan>
Message-ID: <4c4ea0f7-3df3-7ab4-100d-c8545211d582@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 08/09/17 15:39, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Sep 04, 2017 at 09:14:52AM +0100, Andr? Przywara wrote:
>>> And obviously, while maintaining the stability of the binding of those
>>> hundreds properties.
>>>
>>> Or, you can base all this on the compatible, and be done with it once
>>> and for all.
>>
>> What I am after is to cover SoCs which *don't* have differences in their
>> register layout, for instance A83T, H3, A64, R40.
>> In an ideal world we could have reused the H3 compatible string,
>> adjusting the number of channels for each SoC in the DT.
>>
>> So I see that having a generic compatible name will not fly, as we now
>> have differences which should not be modelled by DT properties.
>> But I still think we should try to cover those non-register differences
>> (number of channels) with a DT property, to allow reusing the existing
>> driver code whenever possible. As is stands with this series, the R40
>> support should just be a matter of:
>> 	compatible = "allwinner,sun8i-r40-dma",
>> 		     "allwinner,sun50i-a64-dma";
> 
> I just suggested the exact same thing, and then saw your mail, so I
> guess we have an agreement :)

Yes, I was thinking so as well.
Since my DeLorean is in the garage ;-) we have no other choice than
doing so.
My original suggestion for a generic name was based on my naive reading
of the existing code, which *looked like* it would be all compatible.
But as we know better now, this is the way to go.

Merci,
Andr?
