From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Mar 2015 21:42:14 +0800
Subject: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
In-Reply-To: <20150313082010.GA1033@breakpoint.cc>
References: <20150202225036.421.43421@quantum> <54D0F179.1040906@gmail.com>
 <54D2AA9B.7010800@codeaurora.org> <54D3900A.9060200@gmail.com>
 <54D423C3.9030105@codeaurora.org> <54E3BA20.3080205@codeaurora.org>
 <20150312172006.GA18418@breakpoint.cc>
 <5501EC6C.5010100@codeaurora.org> <20150313032931.GO20455@dragon>
 <20150313082010.GA1033@breakpoint.cc>
Message-ID: <20150313134211.GV20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 09:20:10AM +0100, Sebastian Andrzej Siewior wrote:
> Hi Shawn,
> 
> On Fri, Mar 13, 2015 at 11:29:32AM +0800, Shawn Guo wrote:
> 
> > We did not add a DT property for it, because there was already enough
> > info (clock configuration) in DT for kernel to figure it out.
> Correct. My understanding is whatever can be figured out without DT should
> be done that way.
> 
> Is there a way to get this clock-select bit set without
> enable_fec_anatop_clock() in u-boot? Because this one selects the clock and
> frequency and also sets the proper bit in gpr1. My question is simply why do
> we need to do this here as well.

I'm not sure I follow your question.  But we had been doing this setup
in kernel function imx6q_1588_init() for a while.  The problem we're
having now is that the clk core change broke it since v4.0-rc1.  And the
fix is already queued there [1].

Shawn

[1] https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/log/?h=clk-fixes
