From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 01 May 2014 11:41:37 -0600
Subject: [PATCH v12 11/31] documentation: iommu: add binding document
 of Exynos System MMU
In-Reply-To: <7044616.kdaKNu3Qet@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <20140429181601.GE3582@e103592.cambridge.arm.com>
 <CANEJEGs6TXNzE8cWYgEKfFSsD2w5XiYvwSbhQ_+gtfzfs+6udA@mail.gmail.com>
 <7044616.kdaKNu3Qet@wuerfel>
Message-ID: <53628751.9000609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 03:00 PM, Arnd Bergmann wrote:
...
> Yes. It's very complicated unfortunately, because we have to be
> able to deal with arbitrary combinations of a lot of oddball cases
> that can show up in random SoCs:
...
> - a device may have DMA access to a bus that is invisible to the CPU

The issue is slightly more general than that. It's more that the bus
structure "seen" by a device is simply /different/ than that seen by the
CPU. I don't think it's a requirement that there be CPU-invisible buses
for that to be true.

For example, I could conceive of a HW setup like:

primary CPU bus ----------------------> other devices
   |    \_________________      /
   |                      \    |
   v                      v    ^
device registers ----> some secondary bus
                          |
                          v
                       memory

Here, all the buses are visible to the CPU, yet the path that
transactions take between the buses is simply different to the CPU. More
complex situations than the above, while still maintaining that
description, are certainly possible.
