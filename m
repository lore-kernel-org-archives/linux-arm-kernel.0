From: behanw@converseincode.com (Behan Webster)
Date: Fri, 06 Sep 2013 19:02:52 -0400
Subject: [PATCH] arm: LLVMLinux: Calculate pt_regs address from fp
In-Reply-To: <20130906221857.GQ6617@n2100.arm.linux.org.uk>
References: <1378503762-7236-1-git-send-email-behanw@converseincode.com>
 <1378503762-7236-2-git-send-email-behanw@converseincode.com>
 <20130906221857.GQ6617@n2100.arm.linux.org.uk>
Message-ID: <522A5F1C.400@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/13 18:18, Russell King - ARM Linux wrote:
> On Fri, Sep 06, 2013 at 05:42:41PM -0400, behanw at converseincode.com wrote:
>> From: Behan Webster <behanw@converseincode.com>
>>
>> Use the frame pointer to calculate the end of the stack for current_pt_regs()
>> The existing code uses the stack pointer to do this calculation.
>> Using the frame pointer yeilds the same value in a more portable way.
>> This change supports being able to compile the kernel with gcc and clang.
> What happens when frame pointers are disabled on gcc?
Drat. Good point. Didn't think of that.

Could be rewritten to use current_stack_pointer (assuming the patch 
series that implements that would be amenable).

Thanks,

Behan

-- 
Behan Webster
behanw at converseincode.com
