From: frowand.list@gmail.com (Frank Rowand)
Date: Fri, 07 Feb 2014 11:38:42 -0800
Subject: [PATCH v5 00/14] Add support for MSM's mmio clock/reset controller
In-Reply-To: <1391749891.15777.31.camel@joe-AO722>
References: <1389811654-21397-1-git-send-email-sboyd@codeaurora.org>
 <52F45DEE.8020400@gmail.com> <1391749891.15777.31.camel@joe-AO722>
Message-ID: <52F53642.3030606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/6/2014 9:11 PM, Joe Perches wrote:
> On Thu, 2014-02-06 at 20:15 -0800, Frank Rowand wrote:
>> On 1/15/2014 10:47 AM, Stephen Boyd wrote:
>>> The first breaks a reset-controller include ordering requirement. It got
>>> an ack so I think we're ok for it to go through the clock tree.
>>>
>>
>> < snip >
>>
>> checkpatch is whining about patches
>>
>>   4
>>   5
>>   6
>>   7
>>   8
>>
>> (Just for completeness if someone thinks I did not check all the patches,
>> it also whines about patch 11, but I think the whining should be ignored,
>> and it whines about patch 1 but I think that might be a checkpatch bug.)
> 
> Hi Frank.
> 
> For patch 1, what checkpatch bug might that be?

see below

> 
> I think all the checkpatch whinges in patch 11 are correct.

Agreed on patch 11, judgement call on whether to ignore the warnings.

> 
> I didn't check any of 4-8.

Hi Joe,

Thanks for jumping in.  I did not want to bother you until I dug a little
deeper into the warning to see if I was just misunderstanding something.

Sorry, it is patch 2, not patch 1 ("[PATCH v5 02/14] clk: Add set_rate_and_parent() op"):

   WARNING: Multiple spaces after return type
   #188: FILE: include/linux/clk-provider.h:154:
   +       int             (*set_rate_and_parent)(struct clk_hw *hw,

   total: 0 errors, 1 warnings, 152 lines checked

-Frank
