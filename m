From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Jun 2013 09:54:57 -0700
Subject: [PATCH 12/12] ARM: msm: Migrate to common clock framework
In-Reply-To: <20130611222832.8816.77120@quantum>
References: <1370373938-32417-1-git-send-email-sboyd@codeaurora.org>
 <1370373938-32417-13-git-send-email-sboyd@codeaurora.org>
 <20130611222832.8816.77120@quantum>
Message-ID: <51B8A7E1.1020708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/13 15:28, Mike Turquette wrote:
> Quoting Stephen Boyd (2013-06-04 12:25:38)
>> Move the existing clock code in mach-msm to the common clock
>> framework. We lose our capability to set the rate of and enable a
>> clock through debugfs. This is ok though because the debugfs
>> features are mainly used for testing and development of new clock
>> code.
>>
>> To maintain compatibility with the original MSM clock code we
>> make a wrapper for clk_reset() that calls the struct msm_clk
>> specific reset function. This is necessary for the usb and sdcc
>> devices on MSM until a better suited API is made available.
>>
>> Cc: Saravana Kannan <skannan@codeaurora.org>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> I just went through this quickly and nothing popped out at me.  Nice
> diffstat btw!  Do you have any plans to move this to drivers/clk/msm ?
>
> Acked-by: Mike Turquette <mturquette@linaro.org>

Thanks Mike.

I plan to add mmio support under drivers/clk/msm. Moving this proc_comm
based code to drivers/clk/msm is possible but it would need to depend on
the 3 architectures that use it so that it isn't available or compiled
on our DT based platforms. We can do that later I suppose.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
