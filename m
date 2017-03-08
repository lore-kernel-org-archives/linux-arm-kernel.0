From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 8 Mar 2017 09:26:01 +0000
Subject: [PATCH] reset: sunxi: fix for 64-bit compilation
In-Reply-To: <CAGb2v64SozB9vUpotkEOyUK33ba8hq9M-QRQUEzEQ565Bhd93g@mail.gmail.com>
References: <1488764156-22197-1-git-send-email-andre.przywara@arm.com>
 <CAGb2v64SozB9vUpotkEOyUK33ba8hq9M-QRQUEzEQ565Bhd93g@mail.gmail.com>
Message-ID: <6a0e362b-8ebf-6254-6387-12967ec8c484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/03/17 04:28, Chen-Yu Tsai wrote:
> On Mon, Mar 6, 2017 at 9:35 AM, Andre Przywara <andre.przywara@arm.com> wrote:
>> The Allwinner reset controller has 32-bit registers, so translating
>> the reset cell number into a register and bit offset should not use
>> any architecture dependent data size. Otherwise this breaks for 64-bit
>> architectures like arm64.
>> Fix this by making it clear that it's the hardware register width which
>> matters here in the calculation.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks a lot!

> Though I don't expect this driver to be used with arm64 chips.

Well, weren't we toying with the idea of using this for the A64 PRCM
support?

Also the driver is actually pretty generic, and I have (renaming)
patches lying around to make this obvious. This is partly driven by a
side project for some (arm64) SoC support, which can happily use that
driver to tackle its device reset support.

So as this is an obvious bug, I'd rather see this fixed now.

Cheers,
Andre.
