From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 15:13:41 -0800
Subject: [PATCH 0/3] Add DVFS support on CPU clock for Armada 37xx
In-Reply-To: <20171130134029.20751-1-gregory.clement@free-electrons.com>
References: <20171130134029.20751-1-gregory.clement@free-electrons.com>
Message-ID: <20171221231341.GC7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30, Gregory CLEMENT wrote:
> Hi,
> 
> This small series is needed to use DVFS on Armada 37xx. When DVFS is
> enabled the CPU clock setting is done using an other set of registers
> from the North Bridge Power Management block.
> 
> The series adds the possibility to modify the CPU frequency using the
> associate load level matching the target frequency. However
> configuring the frequencies for each load is done by the cpufreq
> driver submitted in a separate series.
> 
> Obviously having both series (cpufreq and clk) is needed to support
> DVFS on Armada 37xx, but there is no dependencies between the series
> (for building or at runtime).
> 

Are you relying on the clk API returning an error to detect if
DVFS is present or not? Just curious why that part of the code
was there.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
