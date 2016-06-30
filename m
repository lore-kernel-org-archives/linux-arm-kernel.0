From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jun 2016 13:14:08 -0700
Subject: [PATCH/RFC v3 00/22] soc: renesas: Add R-Car RST driver for
 obtaining mode pin state
In-Reply-To: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160630201407.GA27880@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> Currently the R-Car Clock Pulse Generator (CPG) drivers obtains the
> state of the mode pins either by a call from the board code, or directly
> by using a hardcoded register access. This is a bit messy, and creates a
> dependency between driver and platform code.
> 
> This RFC patch series converts the various Renesas R-Car clock drivers
> and support code from reading the mode pin states using a hardcoded
> register access to using a new R-Car RST driver.

Dumb question, can we use the nvmem reading APIs instead of an
SoC specific function to read the modes?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
