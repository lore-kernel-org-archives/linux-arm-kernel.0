From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 25 May 2013 09:16:44 +0200
Subject: clock framework: Don't disable a clock already enabled by boot
 loader?
In-Reply-To: <20130525065434.GA7782@S2101-09.ap.freescale.net>
References: <519F60CA.6090302@de.bosch.com>
 <20130524230021.GF31135@pengutronix.de> <51A05351.7000501@gmail.com>
 <20130525065434.GA7782@S2101-09.ap.freescale.net>
Message-ID: <51A0655C.4020309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.05.2013 08:54, schrieb Shawn Guo:
> On Sat, May 25, 2013 at 07:59:45AM +0200, Dirk Behme wrote:
>> Hmm, but what's the best way to set a flag in
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-imx/clk-imx6q.c
>>
>> ?
>>
>> In mx6q_clocks_init() there doesn't seem to be an explicit interface
>> to set the flags?
>>
>> I'm not sure if
>>
>> clk[xxx]->flags |= CLK_IGNORE_UNUSED;
>>
>> is the way to go?
>>
> Commit 1e43525 (clk: add clk_ignore_unused option to keep boot clocks
> on) introduced an option "clk_ignore_unused" for bypassing
> clk_disable_unused() call.

Yes, I know ;) But this is slightly different: In the end it disables 
the complete clk_disable_unused() call, i.e. for all unused clocks.

I'd like to set the flag CLK_IGNORE_UNUSED for just one clock. I.e. I 
want to set a flag for an i.MX6 clock, and I want to set it only for 
one clock.

What's the preferred way to do this?

Best regards

Dirk
