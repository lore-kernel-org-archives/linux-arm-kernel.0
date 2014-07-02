From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 01 Jul 2014 21:20:57 -0700
Subject: [PATCH v4] clk: qcom: Add support for IPQ8064's global clock
 controller (GCC)
In-Reply-To: <6639D384-040E-498A-8C0B-B3FAF47692ED@codeaurora.org>
References: <1403034411-13781-1-git-send-email-galak@codeaurora.org>
 <6639D384-040E-498A-8C0B-B3FAF47692ED@codeaurora.org>
Message-ID: <20140702042057.23338.96243@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kumar Gala (2014-06-30 09:08:33)
> 
> On Jun 17, 2014, at 2:46 PM, Kumar Gala <galak@codeaurora.org> wrote:
> 
> > Add a driver for the global clock controller found on IPQ8064 based
> > platforms. This should allow most non-multimedia device drivers to probe
> > and control their clocks.
> > 
> > This is currently missing clocks for USB HSIC and networking devices.
> > 
> > Signed-off-by: Kumar Gala <galak@codeaurora.org>
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > v4:
> > * Fix usb utmi freq clk table
> > * Fix numbering issue in dt-bindings/clock/qcom,gcc-ipq806x.h
> > 
> > v3:
> > * Based on APQ8084 clk patches
> > * Added USB3 and SATA clks
> > * Minor clean ups (made hex numbers lowercase)
> > 
> > v2:
> > * dropped audio clock from commit message
> > * changed Kconfig symbol to IPQ_GCC_806X
> > * Fixed PXO/CXO clk freq to 25Mhz
> > 
> > .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
> > drivers/clk/qcom/Kconfig                           |    8 +
> > drivers/clk/qcom/Makefile                          |    1 +
> > drivers/clk/qcom/gcc-ipq806x.c                     | 2424 ++++++++++++++++++++
> > include/dt-bindings/clock/qcom,gcc-ipq806x.h       |  293 +++
> > include/dt-bindings/reset/qcom,gcc-ipq806x.h       |  132 ++
> > 6 files changed, 2859 insertions(+)
> > create mode 100644 drivers/clk/qcom/gcc-ipq806x.c
> > create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq806x.h
> > create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq806x.h
> 
> Mike,
> 
> Any update on pulling this in?

Looks good to me.

What's the story on getting a pull request for qcom clock stuff in the
future? For more mature clock drivers it is nice for a clock maintainer
(maybe Stephen in this case, based on patch count in drivers/clk/qcom?)
to batch up everything. It also helps lazy maintainers like me not have
to review every line of code for the non-controversial stuff.

Regards,
Mike

> 
> - k
> 
> -- 
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
