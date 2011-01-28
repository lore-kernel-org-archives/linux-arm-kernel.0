From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 27 Jan 2011 19:29:39 -0800
Subject: Locking in the clk API
In-Reply-To: <20110127210729.79eef2c1@lxorguk.ukuu.org.uk>
References: <201101111744.59712.jeremy.kerr@canonical.com>	<20110111103929.GN24920@pengutronix.de>	<AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>	<4D386ABF.9060908@fluff.org>	<20110120190822.GK6335@n2100.arm.linux.org.uk>	<4D3932B4.8010904@codeaurora.org>	<20110121094042.GD13235@n2100.arm.linux.org.uk>	<4D40F5CC.6080809@codeaurora.org>	<20110127085438.GA25239@n2100.arm.linux.org.uk>	<4D41D5EC.6030405@codeaurora.org>	<20110127204354.GB1597@n2100.arm.linux.org.uk>
	<20110127210729.79eef2c1@lxorguk.ukuu.org.uk>
Message-ID: <4D423823.4070009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2011 01:07 PM, Alan Cox wrote:
>>> For internal tree purposes, does .set_termios need to be atomic? Can it
>>> grab mutexes instead of spinlock?
>>
>> I think I already answered that question above where I said "protect
>> against the interrupt handler accessing the port->* stuff".
>
> I'm not sure you answered it correctly however as the locking nowdays is
> a bit different.
>
> Architecturally the termios handling doesn't need a spin lock nor is it
> called under one. In fact it's vital this is the case because of USB.

Thanks for the clarification Alan. This is what I was looking for.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
