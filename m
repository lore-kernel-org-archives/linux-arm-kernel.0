From: mkl@blackshift.org (Marc Kleine-Budde)
Date: Mon, 18 Jun 2012 13:50:51 +0200
Subject: Dove clock support
In-Reply-To: <4FDEFC6A.7030300@googlemail.com>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch> <4FDEF7E9.4030504@googlemail.com>
 <4FDEFAE2.7000303@blackshift.org> <4FDEFC6A.7030300@googlemail.com>
Message-ID: <4FDF161B.1010801@blackshift.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 12:01 PM, Sebastian Hesselbarh wrote:
> On 06/18/2012 11:54 AM, Marc Kleine-Budde wrote:
>>> Also ge-phy has to be connected with ge-clk, too. But for dove this is
>>> a clk gate while kirkwood can shut it down somewhere else. I guess it
>>> can be handled like sata/pcie on kirkwood.
>>
>> The PHY is a clock gate so I'm handling it via:
>>> ge = dove_register_gate("ge0", CLOCK_GATING_GBE_BIT |
>>> CLOCK_GATING_GIGA_PHY_BIT);
>> So no gate_fn needed.

BTW: This code doesn't work, btw. It's bits, not masks.

> There is no fn needed for dove, but kirkwood will need one IIRC.
> Moreover, you could hook-up PHY-gate as a parent of corresponding
> clk-gate and they will be enabled/disabled simultaneously.

My solution doesn't wrk. We need either a custom fn or your proposed
parent-clock trick.

> But I'd prefer the driver to take care of clks _and_ PHYs.

You mean clk and PHY individually? I'm not that familiar with the new
clock framework. Is it possible without registering a dummy clock on the
systems with doesn't have individual clocks?

> One more: I suggest to clean the clk names of orion platforms,
> they are a mess ;) And IMHO clks should always have both strings
> set, e.g. kirkwood-i2s has an extclk input besides it on-chip clk.

I'm not (yet) deep into the different orion archs, can you elaborate more?

regards, Marc
Marc
