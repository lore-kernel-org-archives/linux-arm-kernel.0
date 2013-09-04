From: thomas.langer@lantiq.com (thomas.langer at lantiq.com)
Date: Wed, 4 Sep 2013 13:45:40 +0000
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130905014350.GA2261@gmail.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <522697E9.1050208@freescale.com> <20130904095523.GT3084@sirena.org.uk>
 <52270B8E.5080402@freescale.com> <20130904113322.GA5859@sirena.org.uk>
 <20130905014350.GA2261@gmail.com>
Message-ID: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Huang,

Huang Shijie wrote on?2013-09-05:
> On Wed, Sep 04, 2013 at 12:33:22PM +0100, Mark Brown wrote:
>> On Wed, Sep 04, 2013 at 06:29:34PM +0800, Huang Shijie wrote:
>>> ? 2013?09?04? 17:55, Mark Brown ??:
>>>> On Wed, Sep 04, 2013 at 10:16:09AM +0800, Huang Shijie wrote:
>> 
>>>>> Since this quadspi driver depends on the mtd code, could this driver
>>>>> goes to the kernel by
>>>>> the l2-mtd tree?
>> 
>>>> Why would a SPI driver depend on MTD?
>> 
>>> The patch 1-4 are for m25p80.c, and this quadspi controller drivers
>>> depends on the
>>> patch 1-4.
>> 
>> In what way does the controller driver depend on those changes?
> This driver needs the spi nor command to fill the LUT register, such as
> OPCODE_WREN(0x06), so the patch 1 moves the spi nor command to a seprate
> header spi-nor.h, and this driver includes this new header.
> 
Then some questions come up: 
- Why does the spi controller need to know this?
- What is this LUT register at all?
- What happens if something different that a flash is connected and 
   the data starts with one of these opcodes?

Best Regards,
Thomas
