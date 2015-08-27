From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Aug 2015 11:53:10 -0700
Subject: [PATCH] clk: at91: add audio pll clock driver
In-Reply-To: <20150827113035.072cccb5@bbrezillon>
References: <1438337864-27949-1-git-send-email-nicolas.ferre@atmel.com>
 <20150827113035.072cccb5@bbrezillon>
Message-ID: <20150827185310.GV19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27, Boris Brezillon wrote:
> Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > +
> > +static long clk_audio_pll_pad_round_rate(struct clk_hw *hw, unsigned long rate,
> > +					 unsigned long *parent_rate)
> 
> I thought we were trying to get rid of the ->round_rate() function in
> favor of the ->determine_rate() one (which is more flexible), but maybe
> I'm wrong. Stephen, Mike, what's your opinion?

I'm not opposed to people using ->round_rate() if they want to
use it and it serves their purpose. Moving everyone to
->determine_rate() will be a long journey that has little to no
benefit for most drivers, so it's not like we need to force
everyone to use the determine rate op for new submissions so that
we can delete the round rate op one day.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
