From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 27 Oct 2016 16:50:24 +0530
Subject: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
In-Reply-To: <20161024060226.4170-1-mugunthanvnm@ti.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
Message-ID: <ae3d5312-a328-f643-7e0a-cacc5bb95d28@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 October 2016 11:32 AM, Mugunthan V N wrote:
> Increase ADC reference clock from 3MHz to 24MHz so that the
> sampling rates goes up from 100K samples per second to 800K
> samples per second on AM335x and AM437x SoC.
> 
> Also increase opendelay for touchscreen configuration to
> equalize the increase in ADC reference clock frequency,
> which results in the same amount touch events reported via
> evtest on AM335x GP EVM.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Found issues with touchscreen usage with GUI on my AM335x GP EVM. Fixed
with change the "ti,charge-delay" DT property based on change in ADC
clocks. Will be sending v2 patch soon.

Regards
Mugunthan V N
