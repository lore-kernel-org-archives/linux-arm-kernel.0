From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 15 Feb 2018 10:43:07 +0530
Subject: [PATCH v3 3/3] arm64: dts: sdm845: Add serial console support
In-Reply-To: <20180214191125.GD93895@bjorns-mbp-2.lan>
References: <20180212062832.2791-1-rnayak@codeaurora.org>
 <20180212062832.2791-4-rnayak@codeaurora.org>
 <CAD=FV=UXrmpsK3k+8yZCqVi6S+c_3icPUViDST+shnrQW1A6EA@mail.gmail.com>
 <20180214191125.GD93895@bjorns-mbp-2.lan>
Message-ID: <a7008b8a-1c07-6a49-f586-cea88a6e9a18@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/15/2018 12:41 AM, Bjorn Andersson wrote:
> [..]
>>> +
>>> +               qup_1: geni-se at ac0000 {
>> Color me confused.  So you're saying here that this is "qup_1".
>> ...but above you turn the pinmux for pins "GPIO4" and "GPIO5" to
>> "qup9", right?  So UART2 is on "qup 1" and "qup 9"?
>>
>> ...OK, so I stared at manuals a bunch more, and _maybe_ I get it.
>> Maybe there are 3 "QUP v3 modules" each of which handles up to 8
>> "QUP"s.  So QUP 9 is on "QUP module 1", is that right?  If everyone
>> understands this already and it's just me that's confused then I guess
>> you can just ignore this comment.  However, if you can think of any
>> better alias than "qup_1" that makes this less confusing then that
>> would make me extra happy.  Like maybe "qupv3_id_1" to match the
>> manual?
> This is indeed a source of confusion, in particular since there tend to
> be different numbering depending on what part of the puzzle you look at.
> But you're right that each QUP has a number of engines, each one being a
> UART/I2C/SPI controller.
> 
> I don't see a reason for labeling this particular node though, aliases
> references individual engines, not the wrapper.

makes sense, I'll just drop the label.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
