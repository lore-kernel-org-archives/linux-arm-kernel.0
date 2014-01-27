From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 27 Jan 2014 09:59:39 -0800
Subject: [PATCHv2] arm64: Add CONFIG_CC_STACKPROTECTOR
In-Reply-To: <20140127095958.GA6547@mudshark.cambridge.arm.com>
References: <1390604955-6309-1-git-send-email-lauraa@codeaurora.org>
 <20140127095958.GA6547@mudshark.cambridge.arm.com>
Message-ID: <52E69E8B.4060200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/27/2014 1:59 AM, Will Deacon wrote:
> Hi Laura,
>
> On Fri, Jan 24, 2014 at 11:09:15PM +0000, Laura Abbott wrote:
>> arm64 currently lacks support for -fstack-protector. Add
>> similar functionality to arm to detect stack corruption.
>
> [...]
>
>> +/*
>> + * Initialize the stackprotector canary value.
>> + *
>> + * NOTE: this must only be called from functions that never return,
>> + * and it must always be inlined.
>> + */
>> +static __always_inline void boot_init_stack_canary(void)
>> +{
>> +	unsigned long canary;
>> +
>> +	/* Try to get a semi random initial value. */
>> +	get_random_bytes(&canary, sizeof(canary));
>> +	canary ^= LINUX_VERSION_CODE;
>> +
>> +	current->stack_canary = canary;
>
> Do we actually need this line now?
>

Probably not but it seems strange to not have anything there for the 
stack canary. Not sure if 'nothing' is better or worse than a possibly 
incorrect stack canary that gets automatically created in fork.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
