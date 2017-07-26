From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 26 Jul 2017 22:07:14 +0200
Subject: [PATCH 3/3] dt-bindings: clock: amlogic,gxbb-aoclkc: Update
 bindings
In-Reply-To: <20170726004830.GI2146@codeaurora.org>
References: <1499336663-23875-1-git-send-email-narmstrong@baylibre.com>
 <1499336663-23875-4-git-send-email-narmstrong@baylibre.com>
 <20170710035031.rdbi64ookkbq6zeo@rob-hp-laptop>
 <20170721204439.GJ19878@codeaurora.org>
 <1a971e80-1f91-c446-7e28-d193354b2859@baylibre.com>
 <1500897650.2401.1.camel@baylibre.com>
 <20170726004830.GI2146@codeaurora.org>
Message-ID: <1501099634.2401.37.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-07-25 at 17:48 -0700, Stephen Boyd wrote:
> > 
> > Maybe it is time to investigate having the regmap clock from qcom available
> > to
> > every other platform ?
> 
> I think we have regmap clk duplicated a couple times in the
> drivers/clk/ directory now.

Which is why we may start thinking of common and generic "regmap" compatible
solution in the CCF, at least for things like gates, dividers and muxes

The approach used in qcom with regmap clocks could be a candidate for this,
don't you think ?

> Not sure how this is related, except
> for that there looks to be a desire to use a syscon binding here
> and that forces regmap on drivers?

Syscon has been created exactly for this case where you want to create an mfd
just for sharing a register region between several, otherwise well separated,
devices, isn't it ?
