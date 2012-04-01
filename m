From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 1 Apr 2012 23:20:46 +0800
Subject: [PATCH v5 04/16] pwm: Add table-based lookup for static mappings
In-Reply-To: <20120331143021.GA18382@avionic-0098.mockup.avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-5-git-send-email-thierry.reding@avionic-design.de>
 <20120329220342.GK4153@opensource.wolfsonmicro.com>
 <20120330050641.GA21823@avionic-0098.mockup.avionic-design.de>
 <20120330101800.GD21950@opensource.wolfsonmicro.com>
 <20120330103840.GB961@avionic-0098.mockup.avionic-design.de>
 <20120331143021.GA18382@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120401152042.GE2395@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 04:30:21PM +0200, Thierry Reding wrote:
...
> The best solution that I could come up with is to not pass the index into the
> of_pwm_request() function but rather forward the consumer name as passed into
> pwm_get(). The of_pwm_request() could use the "pwm-names" property to do a
> reverse lookup of the index and request that. One good thing about that would
> be that I no longer need to export the of_pwm_request() function.

I never understand why of_pwm_request() needs to be exported anyway.
pwm_get() should be the only interface to pwm new/DT users, IMO.

> The "bad"
> thing is that it'll make the "pwm-names" property mandatory if more than a
> single PWM is requested.
> 
You do not have to make it mandatory, but anyone requesting any pwm
other than the first on in "pwms" list should fail.

> Does that sound reasonable?
> 
The above is exactly what clock DT does, so it sounds reasonable to me.

And I would expect the next version can just turn the second parameter
of pwm_get() into the one that will be used to identify the pwm device
rather than adding one more parameter.  Then we have pwm API well
aligned with clk and regulator.

-- 
Regards,
Shawn
