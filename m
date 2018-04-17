From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Apr 2018 12:51:21 +0200
Subject: [PATCH 3/6] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
In-Reply-To: <71b98ebb-550e-60af-36cb-0196cf738e54@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154122epcas1p1ae714af12f8da08783c47fcd820c40e7@epcas1p1.samsung.com>
 <20180416154021.25626-3-s.nawrocki@samsung.com>
 <167c0f1a1a9de44574523c7f4a9d137d@etezian.org>
 <71b98ebb-550e-60af-36cb-0196cf738e54@samsung.com>
Message-ID: <CAJKOXPexpELGMGPh_=U7LqBTuEyoMByJ3KF+cd9SkOwuA9W_Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 12:02 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Hi Andi,
>
> On 04/16/2018 09:09 PM, andi at etezian.org wrote:
>> On 17.04.2018 00:40, Sylwester Nawrocki wrote:
>>> The spi pointer argument is not used now so remove it. While at it
>>> s3c64xx_ prefix is added to the function name.
>>
>> These for me are two different patches, but in any case it's trivial
>> so that I don't mind it too much.
>
> I am going to drop renaming from this patch. There are 2 more functions
> (wait_for_pio(), wait_for_dma()) without prefix, should we rename them
> too or rather leave all 3 as they are now?

Indeed it is kind of mixed up - some purely local functions (not even
passed through pointer to some ops) have prefix, some do not. If you
ask me, I would prefer to have the prefix on all of them because:
1. If they appear in call trace (where backtrace pointers are not
telling anything) it is easy to understand their location,
2. having generic name like "wait_for_dma" sounds for me like generic,
Linux-wide macro (but it is not).

However I do not insist on that.

Best regards,
Krzysztof
