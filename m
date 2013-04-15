From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 15 Apr 2013 10:19:36 +0200
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <20130403184202.GB10155@atomide.com>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org> <20130403183803.GA10155@atomide.com>
 <20130403184202.GB10155@atomide.com>
Message-ID: <516BB818.3060603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/03/2013 08:42 PM, Tony Lindgren wrote:
> Oh it's already using pinctrl-single,bits option. Maybe there's a
> bug, adding Peter to cc.

I think all boils down to the fact that in pinctrl (single only?) _one_
register can be only associated with _one_ driver. Even through ,bit type
would allow us to only change parts of the same register, another device can
not take the same register with different mask.
I did noticed this after I have sent the bits-per-mux support.
Right now I don't have solution for this...

-- 
P?ter
