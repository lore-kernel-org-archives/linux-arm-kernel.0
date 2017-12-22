From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 16:34:10 -0800
Subject: [PATCH v6 2/3] clk: at91: pmc: Save SCSR during suspend
In-Reply-To: <20171211165535.5126-3-romain.izard.pro@gmail.com>
References: <20171211165535.5126-1-romain.izard.pro@gmail.com>
 <20171211165535.5126-3-romain.izard.pro@gmail.com>
Message-ID: <20171222003410.GW7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11, Romain Izard wrote:
> The contents of the System Clock Status Register (SCSR) needs to be
> restored into the System Clock Enable Register (SCER).
> 
> As the bootloader will restore some clocks by itself, the issue can be
> missed as only the USB controller, the LCD controller, the Image Sensor
> controller and the programmable clocks will be impacted.
> 
> Fix the obvious typo in the suspend/resume code, as the IMR register
> does not need to be saved twice.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
