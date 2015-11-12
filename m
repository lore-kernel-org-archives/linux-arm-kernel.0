From: yang.shi@linaro.org (Shi, Yang)
Date: Thu, 12 Nov 2015 11:33:15 -0800
Subject: [PATCH 1/2] arm64: bpf: add 'store immediate' instruction
In-Reply-To: <20151111123955.GK9562@arm.com>
References: <1447195301-16757-1-git-send-email-yang.shi@linaro.org>
 <1447195301-16757-2-git-send-email-yang.shi@linaro.org>
 <CABg9mct-_AF9+kvZ0OG_JTMHkfj+OEsR2vonrxF=yD-yA6ihQw@mail.gmail.com>
 <20151111121256.GI9562@arm.com> <20151111123955.GK9562@arm.com>
Message-ID: <5644E97B.6050203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2015 4:39 AM, Will Deacon wrote:
> On Wed, Nov 11, 2015 at 12:12:56PM +0000, Will Deacon wrote:
>> On Tue, Nov 10, 2015 at 06:45:39PM -0800, Z Lim wrote:
>>> On Tue, Nov 10, 2015 at 2:41 PM, Yang Shi <yang.shi@linaro.org> wrote:
>>>> aarch64 doesn't have native store immediate instruction, such operation
>>>
>>> Actually, aarch64 does have "STR (immediate)". For arm64 JIT, we can
>>> consider using it as an optimization.
>>
>> Yes, I'd definitely like to see that in preference to moving via a
>> temporary register.
>
> Wait a second, we're both talking rubbish here :) The STR (immediate)
> form is referring to the addressing mode, whereas this patch wants to
> store an immediate value to memory, which does need moving to a register
> first.

Yes, the immediate means immediate offset for addressing index. Doesn't 
mean to store immediate to memory.

I don't think any load-store architecture has store immediate instruction.

Thanks,
Yang

>
> So the original patch is fine.
>
> Will
>
