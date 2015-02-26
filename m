From: rjui@broadcom.com (Ray Jui)
Date: Wed, 25 Feb 2015 22:13:15 -0800
Subject: [PATCH v5 1/6] clk: add of_clk_get_parent_rate function
In-Reply-To: <20150226055406.GB28214@pengutronix.de>
References: <rjui@broadcom.com>
 <1423097705-22939-1-git-send-email-rjui@broadcom.com>
 <1423097705-22939-2-git-send-email-rjui@broadcom.com>
 <20150226055406.GB28214@pengutronix.de>
Message-ID: <54EEB97B.6080006@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 2/25/2015 9:54 PM, Sascha Hauer wrote:
> Hi Ray,
> 
> On Wed, Feb 04, 2015 at 04:55:00PM -0800, Ray Jui wrote:
>> Sometimes a clock needs to know the rate of its parent before itself is
>> registered to the framework. An example is that a PLL may need to
>> initialize itself to a specific VCO frequency, before registering to the
>> framework. The parent rate needs to be known, for PLL multipliers and
>> divisors to be configured properly.
>>
>> Introduce helper function of_clk_get_parent_rate, which can be used to
>> obtain the parent rate of a clock, given a device node and index.
> 
> I can't see how this patch helps you. First it's not guaranteed that
> the parent is already registered, what do you do in this case?

In the case when clock parent is not found, as you can see from the
code, it simply returns zero, just like other clk get rate APIs.

I thought the order of clock registration is based on order of the clock
nodes in device tree. It makes sense to me to declare the parent clock
before a child clock, so it's guaranteed that the parent is registered
before the child.

> Then the clock framework doesn't require that you initialize the PLL
> before registering. That can be done in the clk ops later.

Sure it's not mandatory. But what's wrong with me choosing to initialize
the PLL clock to a known frequency before registering it to the framework?

Ray
