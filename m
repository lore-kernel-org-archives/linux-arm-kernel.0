From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Nov 2017 00:23:50 -0700
Subject: [PATCH v3 18/22] clk: add support for clocks provided by SCMI
In-Reply-To: <1506604306-20739-19-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-19-git-send-email-sudeep.holla@arm.com>
Message-ID: <20171102072350.GO30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28, Sudeep Holla wrote:
> On some ARM based systems, a separate Cortex-M based System Control
> Processor(SCP) provides the overall power, clock, reset and system
> control. System Control and Management Interface(SCMI) Message Protocol
> is defined for the communication between the Application Cores(AP)
> and the SCP.
> 
> This patch adds support for the clocks provided by SCP using SCMI
> protocol.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk at vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

>  MAINTAINERS            |   2 +-
>  drivers/clk/Kconfig    |  10 +++
>  drivers/clk/Makefile   |   1 +
>  drivers/clk/clk-scmi.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 222 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/clk-scmi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23ec3471f542..32c184391aee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12941,7 +12941,7 @@ M:	Sudeep Holla <sudeep.holla@arm.com>
>  L:	linux-arm-kernel at lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/arm,sc[mp]i.txt
> -F:	drivers/clk/clk-scpi.c
> +F:	drivers/clk/clk-sc[mp]i.c

Is there a lot of copy/paste going on from clk-scpi.c? Maybe it
could be consolidated?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
