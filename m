From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 02 Sep 2014 15:01:15 -0700
Subject: [PATCH] clk: qcom: Fix sdc 144kHz frequency entry
In-Reply-To: <20140902214402.5251.75274@quantum>
References: <1409341766-24366-1-git-send-email-sboyd@codeaurora.org>
 <20140902214402.5251.75274@quantum>
Message-ID: <54063E2B.6090403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/14 14:44, Mike Turquette wrote:
> Quoting Stephen Boyd (2014-08-29 12:49:26)
>> The pre-divider for the sdc clocks only has 2 bits in it, so we
>> can't possibly divide by anything larger than 4 here.
>> Furthermore, we program the value of ~(n - m) and the n value is
>> larger than 8 bits (max of 256). Replace this entry with 200kHz
>> which is close enough to 144kHz to be usable.
>>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Cc: Andy Gross <agross@codeaurora.org>
>> Fixes: 24d8fba44af3 "clk: qcom: Add support for IPQ8064's global clock controller (GCC)"
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Do you need this pulled into a 3.17-rc?
>

Yes that would be helpful since this fixes a driver introduced into 3.17.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
