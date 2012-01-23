From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Jan 2012 19:31:45 -0200
Subject: [PATCH] ARM: mx28: clock-mx28: Use a proper timeout mechanism
In-Reply-To: <20120123211854.GB14133@pengutronix.de>
References: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
 <20120123211854.GB14133@pengutronix.de>
Message-ID: <CAOMZO5BfmEy29YgYYg3_TGLLm_CSzNU_yg3yPi0ZxFKf0g=ZZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Jan 23, 2012 at 7:18 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

> Is there a difference in the two versions you sent?

No,  I sent the same patch twice by mistake.

>> +static int mxs_clkctrl_timeout(unsigned int reg_offset, unsigned int mask)
>> +{
>> + ? ? unsigned long timeout = jiffies + msecs_to_jiffies(CLKCTRL_TIMEOUT);
>> + ? ? while (readl_relaxed(CLKCTRL_BASE_ADDR + reg_offset) & mask) {
>
> Hmm, this is a lot better, yet not perfect. You could be scheduled away here
> for 10ms and then you had only checked at t=0. However, I think it makes more
> sense to introduce a generic timeout-loop somehow and then convert to it
> later. This is my homework, though...

Ok, will address your comments and keep the current
mxs_clkctrl_timeout version for v2.

Thanks for your review.

Regards,

Fabio Estevam
