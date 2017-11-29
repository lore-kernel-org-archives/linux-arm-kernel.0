From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Wed, 29 Nov 2017 21:37:46 +0100
Subject: [PATCH] clk: fix compile testing of scpi clk driver
In-Reply-To: <20171129170453.GA7698@codeaurora.org>
References: <24058ecb-9f12-f7e1-503d-bd98eb894c6c@gmail.com>
 <20171129170453.GA7698@codeaurora.org>
Message-ID: <d01ed8fa-9f9e-adf6-3133-800433fef7bb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.11.2017 um 18:04 schrieb Stephen Boyd:
> On 11/28, Heiner Kallweit wrote:
>> We now have a hard dependency on ARM_SCPI_PROTOCOL and may end up with
>> the following error:
>> ERROR: "get_scpi_ops" [drivers/clk/clk-scpi.ko] undefined!
>> Fix this by removing COMPILE_TEST from COMMON_CLK_SCPI dependencies.
>>
>> Fixes: f7fee8be06a6 "firmware: arm_scpi: remove default for get_scpi_ops if not reachable"
> 
> I don't see this commit anywhere. Is this a future issue?
> 
Sorry, yes it is and the patch was primarily addressed to Sudeep. See here:
https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scpi
