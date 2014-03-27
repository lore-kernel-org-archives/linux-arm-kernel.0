From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 27 Mar 2014 09:29:53 +0100
Subject: [PATCH resend] clk: axi-clkgen: Add support for v2
In-Reply-To: <20140327023817.5762.48198@quantum>
References: <1392629513-6114-1-git-send-email-lars@metafoo.de>
 <20140227010421.12081.82707@quantum> <530ED945.2050907@metafoo.de>
 <20140327023817.5762.48198@quantum>
Message-ID: <5333E181.60607@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2014 03:38 AM, Mike Turquette wrote:
> Quoting Lars-Peter Clausen (2014-02-26 22:20:53)
>> On 02/27/2014 02:04 AM, Mike Turquette wrote:
>>> Quoting Lars-Peter Clausen (2014-02-17 01:31:53)
>>>> This patch adds support for the new v2 version of the axi-clkgen core.
>>>> Unfortunately the method of accessing the registers is quite different on v2,
>>>> while the content still stays largely the same. So the patch adds a small
>>>> abstraction layer which implements the specific read and write functions for v1
>>>> and v2 in callback functions.
>>>
>>> Hi,
>>>
>>> This patch almost doubles the size of clk-axi-clkgen.c. Should it be a
>>> separate clock driver? I guess that depends on the relationship between
>>> "v1" and "v2". Are both of those versions of the clkgen core going into
>>> production?
>>
>> Hi,
>>
>> The only thing that is different between the two versions is how the PLL
>> registers are accessed. The content that is written to those register is a
>> 100% identical. So splitting it up into two drivers makes no sense, since
>> you'd have to copy&paste all the application logic. Both versions of the
>> core can be found in the wild.
>
> Hi Lars,
>
> I took this into clk-next some time ago but never replied to this thread
> letting you know. Better late than never :-)

Yep, already saw it showing up in clk-next a while ago, thanks.

- Lars
