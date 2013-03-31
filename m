From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 31 Mar 2013 02:18:35 +0000 (UTC)
Subject: [PATCH 2/2] ARM: OMAP2+: am335x: Change the wdt1 func clk src
 to per_32k clk
In-Reply-To: <1364577017-22562-3-git-send-email-hvaibhav@ti.com>
References: <1364577017-22562-1-git-send-email-hvaibhav@ti.com>
 <1364577017-22562-3-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1303310218260.6436@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Mar 2013, Vaibhav Hiremath wrote:

> WDT1 module can take one of the below clocks as input functional
> clock -
>      - On-Chip 32K RC Osc [default/reset]
>      - 32K from PRCM
> 
> The On-Chip 32K RC Osc clock is not an accurate clock-source as per
> the design/spec, so as a result, for example, timer which supposed
> to get expired @60Sec, but will expire somewhere ~@40Sec, which is
> not expected by any use-case.
> 
> The solution here is to switch the input clock-source to PRCM
> generated 32K clock-source during boot-time itself.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <benoit.cousson@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, queued for 3.10.


- Paul
