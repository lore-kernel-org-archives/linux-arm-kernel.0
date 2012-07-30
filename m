From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Jul 2012 15:38:48 -0700
Subject: [PATCH] ARM: Sort exception table at compile time
In-Reply-To: <20120730215617.GA10335@n2100.arm.linux.org.uk>
References: <1343683803-15507-1-git-send-email-sboyd@codeaurora.org>
 <20120730215617.GA10335@n2100.arm.linux.org.uk>
Message-ID: <50170CF8.9010307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/12 14:56, Russell King - ARM Linux wrote:
> On Mon, Jul 30, 2012 at 02:30:03PM -0700, Stephen Boyd wrote:
>> Add the ARM machine identifier to sortextable and select the
>> config option so that we can sort the exception table at compile
>> time. sortextable relies on a section named __ex_table existing
>> in the vmlinux, but ARM's linker script places the exception
>> table in the data section. Give the exception table its own
>> section so that sortextable can find it.
>>
>> This allows us to skip the runtime sorting step during boot.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: David Daney <david.daney@cavium.com>
>> ---
>>
>> I can't find any information on why the exception table lives in the data
>> section. If there's a good reason for that, I'll look into changing
>> sortextable to look for the __start___ex_table symbol.
> Be careful about the placement of this, especially with XIP.
>

Thanks for the hint. I'm unfamiliar with how XIP works so I'll take a
closer look there.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
