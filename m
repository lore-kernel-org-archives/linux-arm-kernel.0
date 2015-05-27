From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 27 May 2015 10:36:25 +0200
Subject: [PATCH] ARM: berlin: add SPI nodes for BG2Q
In-Reply-To: <20150525090100.GC29660@kwain>
References: <1432126385-27402-1-git-send-email-antoine.tenart@free-electrons.com>
 <555D1706.7040309@gmail.com> <20150525090100.GC29660@kwain>
Message-ID: <55658209.4000904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.05.2015 11:01, Antoine Tenart wrote:
> On Thu, May 21, 2015 at 01:21:42AM +0200, Sebastian Hesselbarth wrote:
>> On 20.05.2015 14:53, Antoine Tenart wrote:
>>> +
>>> +				spi0_pmux: spi0-pmux {
>>> +					groups = "G8", "G9", "G10", "G11";
>>> +					function = "spi1";
>>> +				};
>>
>> ... can you check which of G8-G11 are actually clock/data and which
>> are CSn lines?
>>
>> CSn lines should all be optional and per-board pinmux - same for the
>> other spi pinmux.
>
> G8 and GSM3 are for clock/data, the other groups (G9-11 and GSM0-2)
> control the CSn lines. I'll update.

Re-reading this mail after you published v2, I thought it would
be a good idea to add this information to the pinmux driver. We
already have some /* comments */ about the actual function, why
not add the above, too?

Also, I guess G8/GSM3 are for clk/data _and_ cs0n while
G9-G11/GSM0-GSM2 add cs{1,2,3}n ?

Sebastian
