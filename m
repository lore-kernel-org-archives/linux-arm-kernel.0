From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarh)
Date: Mon, 18 Jun 2012 12:01:14 +0200
Subject: Dove clock support
In-Reply-To: <4FDEFAE2.7000303@blackshift.org>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch> <4FDEF7E9.4030504@googlemail.com>
 <4FDEFAE2.7000303@blackshift.org>
Message-ID: <4FDEFC6A.7030300@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 11:54 AM, Marc Kleine-Budde wrote:
>> Also ge-phy has to be connected with ge-clk, too. But for dove this is
>> a clk gate while kirkwood can shut it down somewhere else. I guess it
>> can be handled like sata/pcie on kirkwood.
>
> The PHY is a clock gate so I'm handling it via:
>> ge = dove_register_gate("ge0", CLOCK_GATING_GBE_BIT | CLOCK_GATING_GIGA_PHY_BIT);
> So no gate_fn needed.

There is no fn needed for dove, but kirkwood will need one IIRC.
Moreover, you could hook-up PHY-gate as a parent of corresponding
clk-gate and they will be enabled/disabled simultaneously.

But I'd prefer the driver to take care of clks _and_ PHYs.

One more: I suggest to clean the clk names of orion platforms,
they are a mess ;) And IMHO clks should always have both strings
set, e.g. kirkwood-i2s has an extclk input besides it on-chip clk.

Sebastian
