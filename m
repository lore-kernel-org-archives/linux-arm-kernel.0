From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 19 Sep 2012 17:58:40 -0500
Subject: [PATCH 3/3] ARM: OMAP2+: hwmod code: convert missing clockdomain
 warnings to debug messages
In-Reply-To: <alpine.DEB.2.00.1209192247250.8278@utopia.booyaka.com>
References: <20120918211146.16484.85893.stgit@dusk.lan>
 <20120918211251.16484.18401.stgit@dusk.lan> <5058ECAF.7010609@ti.com>
 <alpine.DEB.2.00.1209192247250.8278@utopia.booyaka.com>
Message-ID: <505A4E20.5040903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 9/19/2012 5:48 PM, Paul Walmsley wrote:
> Hi Beno?t,
>
> On Tue, 18 Sep 2012, Cousson, Benoit wrote:
>
>> On 9/18/2012 4:12 PM, Paul Walmsley wrote:
>>> The decision was made a few months ago to allow struct omap_hwmod
>>> records and struct clk records to omit clockdomain information if the
>>> clockdomain is not software-controllable.  See for example commit
>>> 868c157df9721675c19729eed2c96bac6c3f1d01 ("ARM: OMAP2+: hwmod: remove
>>> prm_clkdm, cm_clkdm; allow hwmods to have no clockdomain").
>>>
>>> So convert an existing pr_warning() to a pr_debug() (regarding missing
>>> clockdomains in clocks), and add a pr_debug() for missing hwmod
>>> clockdomains.
>>
>> At some point I sent you a small RFC to still keep the message if neither
>> oh->clkdm nor oh->_clk->clkdm was there. I've never had the time to test it,
>> but that should then cover OMAP2, 3 & 4 cases.
>
> OK let's plan to test and add something like that during the 3.8 time
> frame... probably it should also depend on the value of clkdm_control.
> It's not clear to me exactly what that conditional should look like...

OK, I was thinking of a more basic thing. If some more values have to be 
checked it might be a little bit more tricky.

Let's see that later.

Thanks,
Benoit
