From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 16:13:21 +0530
Subject: [PATCH v7 1/2] provide lock-less versions of clk_{enable|disable}
In-Reply-To: <5112fcf8-8a10-bfd3-3c37-c3a956eacd15@ti.com>
References: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
 <20161209185421.fybpk4bdq6b7yglf@pengutronix.de>
 <e548f7cf-a1d5-0bc2-1095-db8464a1bcc4@ti.com>
 <35adff3d-c6a6-7b65-fb61-6da447dd6c3f@baylibre.com>
 <e004a3f8-2dde-b21c-b09e-da5a65d768f6@lechnology.com>
 <5112fcf8-8a10-bfd3-3c37-c3a956eacd15@ti.com>
Message-ID: <e4f33e0e-093b-f473-3fa9-b6560a66c7da@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 December 2016 09:21 PM, Sekhar Nori wrote:
> ARM: davinci: Make __clk_{enable,disable} functions public
> 
> In some cases, there is a need to enable a clock as part of clock
> enable callback of a different clock. For example, USB 2.0 PHY clock
> enable requires USB 2.0 clock to be enabled. In this case, it is safe to
> instead call  __clk_enable() since the clock framework lock is already
> taken. calling clk_enable() causes recursive locking error.
> 
> A similar case arises in the clock disable path.
> 
> To enable such usage, make __clk_{enable,disable} functions publicly
> available outside of clock.c. Also, call them
> davinci_clk_{enable|disable} now to be consistent with how other
> davinci-specific clock functions are named.
> 
> Note that these functions are not exported to drivers. They are meant
> for usage in platform specific clock management code.

Applied to 'fixes' with above commit text.

Thanks,
Sekhar
