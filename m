From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Sat, 17 Jul 2010 19:24:08 +0100
Subject: [PATCH] regulator: MAX8998: set_voltage bugfix. ramp_up delay
	and min/max voltage
In-Reply-To: <1279267760-6971-1-git-send-email-myungjoo.ham@samsung.com>
References: <1279267760-6971-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279391048.3070.11.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-16 at 17:09 +0900, MyungJoo Ham wrote:
> Two issues are addressed for max8998_set_voltage function.
> 
> 1. Min/Max Voltage.
> 
> 	max8998_set_voltage had been using the voltage value of
> 
> 	min ( voltage[i] >= max_vol , i )
> 
> 	This is corrected to use:
> 
> 	min ( voltage[i] >= min_vol , i )
> 
> 2. Ramp Up Delay.
> 
> 	max8998_set_voltage should provide delay for BUCK1/2
> if ENRAMP is on. It reads RAMP value from ONOFF4 register to determine
> RAMP delay length. However, when max8998_set_voltage's new voltage is
> lower than the previous, we don't care because it does not deteriorate
> the stability.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> --
> I've omitted some CC in the previous email, adding them here. Sorry for the duplicated submission.

This doesn't apply. Can you re-create against my regulator for-next
branch.

git://git.kernel.org/pub/scm/linux/kernel/git/lrg/voltage-2.6.git for-next

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
