From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 17 Dec 2015 09:28:36 +0000
Subject: block layer bug with 4.4-rc3+
In-Reply-To: <1885710.UNGYhDGGcI@wuerfel>
References: <566FF3ED.1000503@arm.com>
 <CACVXFVN3w0Y_8k3TiKoGytbayXiB+mRhgDn-OueV2+e93i=4AQ@mail.gmail.com>
 <56717B6F.2040008@arm.com> <1885710.UNGYhDGGcI@wuerfel>
Message-ID: <56728044.7090906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tach Arnd,

On 16/12/15 15:43, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 14:55:43 Andre Przywara wrote:
>> Using the plain multi_v7_defconfig (which doesn't have LPAE and makes me
>> loose half of the RAM on that box) didn't show the bug so far.
>> One of the effects of turning on LPAE is that dma_addr_t and phys_addr_t
>> turn to 64-bit, with long, int and void* still being 32-bit. Can you
>> think of any issues that could be related to that?
>>
> 
> Another difference between the platforms is highmem. On Midway,
> almost all of RAM is highmem, which needs a lot of special handling
> that we don't need on platform with less RAM.

Good point, but ...

> To rule out both of highmem and LPAE, it might be interesting to
> test again on Midway with CONFIG_HIGHMEM and CONFIG_LPAE disabled.
> This will limit the RAM to 768MB, but if the bug still shows up,
> you know it's something else.

So it was running for almost a day without LPAE now, but with highmem,
and the bug didn't show up. So for the time being I'd avoid another test
run without highmem, as LPAE alone is sufficient to trigger it.
Also it seems that CONFIG_HIGHMEM is selected by MULTI_V7, so I can't
configure it out for this box, but would have to restrict memory to
768M, I guess.

Next I will try some tracing as Ming suggested.

Cheers,
Andre.
