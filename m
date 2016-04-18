From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 18 Apr 2016 11:25:16 +0530
Subject: [PATCH 1/3] ARM: DTS: da850: add node for spi0
In-Reply-To: <57111433.6080402@lechnology.com>
References: <1460586628-25152-1-git-send-email-david@lechnology.com>
 <1460586628-25152-2-git-send-email-david@lechnology.com>
 <5710C176.3040304@ti.com> <57111433.6080402@lechnology.com>
Message-ID: <571476C4.6050201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 09:47 PM, David Lechner wrote:
> On 04/15/2016 05:24 AM, Sekhar Nori wrote:
> 
>>
>> This made me notice that num-cs is populated wrongly for spi1. It
>> actually has 8 chip selects. This is fine though.
> 
> I might as well fix it since I have to make changes anyway. Don't
> remember how I came up with 6.

In section 3.7.7 of datasheet, there are 6 possible chip selects listed
for SPI0 and 8 possible chipselects for SPI1.

If you are fixing SPI1, please make that a separate patch.

>> Also, it will be nice to add pinctrl entries for spi0 like it is done
>> for spi1. You will need those anyway for using the interface.
> 
> I omitted this on purpose. For my use case, I am using the SPI as
> write-only, so not using the SOMI pin, which is actually muxed as a GPIO
> for something else. So having a pinctl like spi1 is of no use to me. I
> figured if someone needs it, they can add it, otherwise it just is
> wasted space to me.

Alright, makes sense.

Regards,
Sekhar
