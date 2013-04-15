From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Apr 2013 10:40:20 -0600
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <516BB818.3060603@ti.com>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org> <20130403183803.GA10155@atomide.com>
 <20130403184202.GB10155@atomide.com> <516BB818.3060603@ti.com>
Message-ID: <516C2D74.2090106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 02:19 AM, Peter Ujfalusi wrote:
> Hi,
> 
> On 04/03/2013 08:42 PM, Tony Lindgren wrote:
>> Oh it's already using pinctrl-single,bits option. Maybe there's a
>> bug, adding Peter to cc.
> 
> I think all boils down to the fact that in pinctrl (single only?) _one_
> register can be only associated with _one_ driver. Even through ,bit type
> would allow us to only change parts of the same register, another device can
> not take the same register with different mask.

pinctrl itself certainly imposes no such restriction that I'm aware of.
pinctrl is only concerned with the ownership of *pins* (or perhaps
groups). The mapping of pins to registers is something entirely internal
to individual pinctrl drivers.

So, the solution here is for pinctrl-single to create a separate
pin/group object for each separately controllable entity, and that may
be each bit in a register rather than each register, depending on HW.
