From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 01 Jun 2016 09:30:16 -0700
Subject: [RFC PATCH 0/2] scpi: Add SCPI framework to handle vendors
 variants
In-Reply-To: <574EB4A5.9000805@arm.com> (Sudeep Holla's message of "Wed, 1 Jun
 2016 11:10:45 +0100")
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
 <57472450.4000709@arm.com> <574802AF.2080909@baylibre.com>
 <574BFA13.40009@baylibre.com> <574EB4A5.9000805@arm.com>
Message-ID: <7hy46oeusn.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ + Heiko, who may know about the Rockchip implementation ]

Sudeep Holla <sudeep.holla@arm.com> writes:

> On 30/05/16 09:30, Neil Armstrong wrote:
>> On 05/27/2016 10:17 AM, Neil Armstrong wrote:
>
> [..]
>
>>
>> While looking for other ARMv8 based platform, I found that the RK3368
>> platform has the same SCPI implementation as Amlogic.
>>
>> They extended it with DDR, system and thermal commands.
>>
>> Look at :
>> https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/drivers/mailbox/scpi_cmd.h
>>
>>https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/drivers/mailbox/scpi_protocol.c
>>
>
>
>> So the SCPI must have a framework to allow different protocol
>> versions, and must allow command extension. Grouping Rockchip and
>> Amlogic should be done, thus needing a generic name like vendor_scpi
>> or with a version.
>>
>
> Makes sense. I understand the need to reuse and I need a bit of time to
> have a look at the code(both Amlogic one's you have pointed out and the
> Rockchip one) in detail to see what's the best way to proceed. I will
> have a look at this later this week and get back to you.
>
>> Sudeep, could you somehow find out which version of the protocol
>> AmLogic and Rockchip based their SCPI development ?
>>
>
> Yes I tried checking with Rockchip but didn't get a response. But my
> guess is that it was some preliminary unpublished version of SCPI
> unfortunately :(

And if one partner did that, probably everyone else did as well, but
this being the ARM universe, they all did it slightly differently. :(

We know from experience, that this happens all the time in the absence
of a clear standard, so this framework will need to be extended to be
useful.

Thanks,

Kevin
