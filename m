From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 22 Jul 2015 11:20:05 +0100
Subject: [PATCH] arm64: sys_reg() : Fix encoding of system registers
In-Reply-To: <20150722100739.GB2078@e104818-lin.cambridge.arm.com>
References: <20150721113705.GD7250@e104818-lin.cambridge.arm.com>
 <1437558857-18433-1-git-send-email-suzuki.poulose@arm.com>
 <20150722100739.GB2078@e104818-lin.cambridge.arm.com>
Message-ID: <55AF6E55.1010205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/15 11:07, Catalin Marinas wrote:
> On Wed, Jul 22, 2015 at 10:54:17AM +0100, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> sys_reg() macro encodes Op0 as (Op0 - 2) and pushes it to Bit 19,
>> leaving Bit 20 uninitialised.
>
> A value of 0 doesn't mean uninitialised and as you noticed, it's set by
> the value or'ed onto the sys_reg() returned value in the mrs_s etc.
> macros.
>
> So I would rather change the subject to "Generalise encoding of system
> registers" and drop the uninitialised paragraph above, maybe replace it
> with a statement that current sys_reg() was only meant for MSR/MRS
> (register) encodings.

OK. Will send the updated versoin.

>
> Otherwise, the patch itself is fine.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks
Suzuki
