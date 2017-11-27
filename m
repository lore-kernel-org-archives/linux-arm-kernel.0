From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 27 Nov 2017 15:37:54 +0100
Subject: [PATCH 1/2] ARM: BUG if jumping to usermode address in kernel mode
In-Reply-To: <20171127143219.GF31757@n2100.armlinux.org.uk>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
 <CGME20171125113437epcas2p4f1fcbe7dc2375f08410576ba826bc188@epcas2p4.samsung.com>
 <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
 <83b9ac11-a01a-c407-ed46-a62ac5037431@samsung.com>
 <20171127143219.GF31757@n2100.armlinux.org.uk>
Message-ID: <34b1d5b5-8730-e25f-46ad-92fb1612a5d3@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On 2017-11-27 15:32, Russell King - ARM Linux wrote:
> On Mon, Nov 27, 2017 at 03:27:03PM +0100, Marek Szyprowski wrote:
>> Dear All,
>>
>> On 2017-11-25 12:33, Russell King wrote:
>>> Detect if we are returning to usermode via the normal kernel exit paths
>>> but the saved PSR value indicates that we are in kernel mode.  This
>>> could occur due to corrupted stack state, which has been observed with
>>> "ftracetest".
>>>
>>> This ensures that we catch the problem case before we get to user code.
>>>
>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> This patch brakes kernel booting on Exynos 4412-based Odroid U3 board:
> "brakes" are what you have on a car. "breaks" is the verb, which is
> what you mean here.

I'm sorry, I wrote that mail in a hurry before leaving the office.

> It's known as of this morning, and I have a patch going through the
> build testers at the moment.
>
> Just replace the 0xcf in these with PSR_I_BIT | 0x0f.
>
> Also wonder why your platform is running with SCR.FW clear...

Yes, this fixes the issue. Thanks.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
