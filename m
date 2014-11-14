From: padma.kvr@gmail.com (Padma Venkat)
Date: Fri, 14 Nov 2014 16:46:06 +0530
Subject: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
In-Reply-To: <CAAgF-Bd=S7-PoA7GZoy87W9Dem3OXVhc1tL-eyWEAHvF0LPTKQ@mail.gmail.com>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
 <20141106102636.GT8509@sirena.org.uk>
 <CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i6edOm6U3bc26_Q@mail.gmail.com>
 <20141107101310.GA8509@sirena.org.uk>
 <CAAgF-Bd=S7-PoA7GZoy87W9Dem3OXVhc1tL-eyWEAHvF0LPTKQ@mail.gmail.com>
Message-ID: <CAAgF-BcARoRZv=BPqQWyp6rJQQ=CE0FEUz_2vgQSpeZyLwbkBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/10/14, Padma Venkat <padma.kvr@gmail.com> wrote:
> Hi Mark,
>
> On 11/7/14, Mark Brown <broonie@kernel.org> wrote:
>> On Fri, Nov 07, 2014 at 02:01:57PM +0530, Padma Venkat wrote:
>>
>>> CS can also be controlled automatically by setting AUTO_N_MANUAL to 1
>>> in CS_CFG. When it is auto CS automatically toggles between packet to
>>> packet. NCS_TIME_COUNT in CS_CFG controls the inactive period. The
>>> driver by default uses manual mode. But on exynos7 the manual mode is
>>> removed.
>>
>> OK, but what's a packet here?
>
> Packet is either 1 byte or 4 bytes size depends on width of the SPI
> channel.
>
>>
>>> I tested the driver with wm5110 codec.
>>
>> Did you try firmware downloads or something else that generates multiple
>> transfers in a message?  Normal register writes will use a single
>> transfer so I'd expect them to just work.
>>
>
> OK. I don't have provision to test on this board. I will try to test
> on older boards by disabling manual mode.
>

I tested on exynos5420 peach-pit by enabling auto mode. I used dd
command to read 1MB data from spi flash and I compared the result with
manual mode. Both are same.

> Thanks
> padma
>
