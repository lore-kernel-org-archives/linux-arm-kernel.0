From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 04 Apr 2014 17:25:27 +0200
Subject: MX28: leds/pwm: Using pwm driven led as heartbeat leads to kernel
 warning
In-Reply-To: <20140404142656.GA16383@dragon>
References: <53345C93.9040005@i2se.com> <533EB9AC.6040708@i2se.com>
 <20140404142656.GA16383@dragon>
Message-ID: <533ECEE7.6090405@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am 04.04.2014 16:26, schrieb Shawn Guo:
> On Fri, Apr 04, 2014 at 03:54:52PM +0200, Stefan Wahren wrote:
>> the problem is still reproducable in Mainline 3.14.0 and gives the same
>> warning message.
>> Also i add linux-leds in CC.
>>
>> Are there any advices to narrow down the problem?
>>
>> Is this problem specific to i.MX28 PWM (i don't have other kind of
>> hardware)?
> I don't think it's specific to i.MX28 PWM.  Since the .config hook of
> pwm_ops will be called from interrupt context in this case, any pwm
> drivers that do sleeping calls in the hook will have this problem, e.g.
> the clk APIs that hold mutex like clk_prepare() and clk_get_rate() etc.
>
> Shawn

that sounds like the problem should be easier to reproduce.

Is there anything i can do to support bugfixing, beside sending the patch?

Stefan
