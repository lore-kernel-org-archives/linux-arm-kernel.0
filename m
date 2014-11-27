From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 27 Nov 2014 20:56:35 +0900
Subject: [PATCH 11/19] clk: samsung: exynos5433: Add clocks for
 CMU_BUS{0|1|2} domains
In-Reply-To: <6217579.xNXtO7YiDs@wuerfel>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <1417073716-22997-12-git-send-email-cw00.choi@samsung.com>
 <6217579.xNXtO7YiDs@wuerfel>
Message-ID: <54771173.6090408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

On 11/27/2014 08:41 PM, Arnd Bergmann wrote:
> On Thursday 27 November 2014 16:35:08 Chanwoo Choi wrote:
>> +  - "samsung,exynos5433-cmu-bus0", "samsung,exynos5433-cmu-bus1"
>> +    and "samsung,exynos5433-cmu-bus2" - clock controller compatible for CMU_BUS
>> +    which generates global data buses clock and global peripheral buses clock.
>>  
>>  - reg: physical base address of the controller and length of memory mapped
>>    region.
>>
> 
> This looks like you are duplicating the bindings and the code, but
> it's really the same hardware multiple times with minor variations
> that you should be able to describe properly here. Why not make
> three nodes with the same compatible string and have them handled
> by the same code?

Each CMU_BUSx domain of Exynos5433 have different base address as following:
- CMU_BUS0's base address and range : 0x1360_0000 ~ 0x1360_0b04
- CMU_BUS1's base address and range : 0x1480_0000 ~ 0x1480_0b04
- CMU_BUS2's base address and range : 0x1340_0000 ~ 0x1340_0b04

So, I implement CMU_BUSx domain which has each compatible string.

Best Regards,
Chanwoo Choi
