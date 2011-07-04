From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 04 Jul 2011 11:46:30 +0200
Subject: [PATCH] ASoC: wm8731: set the ACTIVE bit if bias ON entered
In-Reply-To: <20110701161506.GC23784@opensource.wolfsonmicro.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
	<20110701161506.GC23784@opensource.wolfsonmicro.com>
Message-ID: <4E118BF6.6010205@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/07/2011 18:15, Mark Brown :
> On Fri, Jul 01, 2011 at 12:43:54PM +0200, Nicolas Ferre wrote:
>> Resuming from a suspend/resume cycle, the ACTIVE bit was not set even if a
>> stream had actually been processing.
>> Setting this bit at entering SND_SOC_BIAS_ON level will ensure this.
> 
> This will set the bit even for analogue bypass paths which don't need
> it.  I'd suggest making the active bit a supply widget supplying the DAC
> and ADC rather than something open coded, that should do the right thing
> I think.

Ah, ok... but I fear that I do not know the whole system enough for this
addition ;-(
Do you think you can code this modification, I will be happy to test it,
if you want...

Best regards,
-- 
Nicolas Ferre
