From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 20 Jun 2016 17:39:19 +0100
Subject: [PATCH] arm64: defconfig: enable Generic on-chip SRAM driver
In-Reply-To: <1466440489.2833.41.camel@linaro.org>
References: <1466437295-30553-1-git-send-email-sudeep.holla@arm.com>
 <1466440489.2833.41.camel@linaro.org>
Message-ID: <57681C37.9050109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/06/16 17:34, Jon Medhurst (Tixy) wrote:
> On Mon, 2016-06-20 at 16:41 +0100, Sudeep Holla wrote:
>> Most of the ARM SoCs have small SRAM memory used for various purposes
>> that require faster access to data compared to normal DDR.
>>
>> This patch enables the Generic on-chip SRAM driver on ARM64.
>
> Would this cause things in the kernel to automatically start using SRAM
> found in device-tree, or would each use need to be added explicitly?
> I'm just wondering if we might start seeing new bugs caused by firmware
> using SRAM for special purposes but that memory not being properly
> reserved or hidden from the kernel.
>

No only the unreserved part of SRAM will be used by generic allocator
and the users/drivers needing this have to explicitly request for the
same(my understanding based on some usage I have seen on ARM32
platforms). The reserved part is not touched by the generic allocator.

-- 
Regards,
Sudeep
