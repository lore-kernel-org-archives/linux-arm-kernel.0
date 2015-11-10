From: yang.shi@linaro.org (Shi, Yang)
Date: Tue, 10 Nov 2015 08:51:06 -0800
Subject: [V3 PATCH] arm64: remove redundant FRAME_POINTER kconfig option
 and force to select it
In-Reply-To: <20151110103752.GH21606@e104818-lin.cambridge.arm.com>
References: <1447092595-12644-1-git-send-email-yang.shi@linaro.org>
 <20151110103752.GH21606@e104818-lin.cambridge.arm.com>
Message-ID: <5642207A.9070406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2015 2:37 AM, Catalin Marinas wrote:
> On Mon, Nov 09, 2015 at 10:09:55AM -0800, Yang Shi wrote:
>> FRAME_POINTER is defined in lib/Kconfig.debug, it is unnecessary to redefine
>> it in arch/arm64/Kconfig.debug. Actually, the one defined in arm64 directory
>> is never used.
>
> That's not true since the arm64 definition seems to take precedence.
>
>> This adds a dependency on DEBUG_KERNEL for building with frame pointers.
>
> It doesn't because arm64 selects ARCH_WANT_FRAME_POINTERS.

Thanks for pointing it out. I misread the order of precedence, still 
think of C syntax at the first place.

Yang

>
>> ARM64 depends on frame pointer to get correct stack backtrace and need
>> FRAME_POINTER kconfig option enabled all the time.
>> However, currect implementation makes it could be disabled, so force it
>> to be selected by ARM64.
>>
>> Signed-off-by: Yang Shi <yang.shi@linaro.org>
>
> Patch applied but I changed the commit log slightly. Thanks.
>
