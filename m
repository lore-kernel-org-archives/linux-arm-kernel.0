From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 11:51:45 +0530
Subject: [Query] Common Clock Framework: How to handle clks enabled by default
Message-ID: <4F8D0BF9.7080802@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

How are we handling clocks which are enabled by bootloaders and are
required to be enabled, like, pll, cpu, ahb?

Following is example clk hierarchy:
osc(root)->pll->cpu->ahb->dma

Issue1: Now, when we do clk_enable() for dma, all these already enabled clocks
are re-enabled.
Issue2: On clk_disable() all are disabled and system hangs :(

There is one option CLK_IGNORE_UNUSED, which is used only for disabling
unused clocks. So that is not helpful here.

One way i could think of is not to give clk_gate support for these clocks,
so that they can never be disabled. Is this the preferred way?

I can't guarantee, but these clocks might be required to be disabled
for standby/sleep cases.

-- 
viresh
