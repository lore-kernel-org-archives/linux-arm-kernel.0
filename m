From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 21 Jan 2011 17:47:28 -0800
Subject: Locking in the clk API
In-Reply-To: <20110121094042.GD13235@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111091607.GI12552@n2100.arm.linux.org.uk>	<201101111744.59712.jeremy.kerr@canonical.com>	<20110111103929.GN24920@pengutronix.de>	<AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>	<4D386ABF.9060908@fluff.org>	<20110120190822.GK6335@n2100.arm.linux.org.uk>	<4D3932B4.8010904@codeaurora.org>
	<20110121094042.GD13235@n2100.arm.linux.org.uk>
Message-ID: <4D3A3730.8070304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2011 01:40 AM, Russell King - ARM Linux wrote:
> On Thu, Jan 20, 2011 at 11:16:04PM -0800, Saravana Kannan wrote:
>> This suggestion looked promising till I realized that clk_set_rate()
>> will still be atomic. clk_set_rate() will need to enable/disable the
>> PLLs depending on which PLLs the rates are derived from. So, the locking
>> in clk_prepare/unprepare() still has to be atomic since the "slow stuff"
>> is shared with clk_set_rate().
>
> Who calls clk_set_rate() from an atomic context?  Do we know whether
> anyone does?

I have had internal teams asking about it. I will try to check if they 
mainlined any of it yet or continue to want to do that in atomic context 
and get back.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
