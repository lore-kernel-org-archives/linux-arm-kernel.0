From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 14 May 2011 22:21:25 +0800
Subject: [PATCH 06/14] mfd: pxa-w1: MFD driver for PXA 1wire control +
	DS1WM chip
In-Reply-To: <20110426094836.GD2659@sortiz-mobl>
References: <1303135451-26362-7-git-send-email-haojian.zhuang@marvell.com>
	<20110426094836.GD2659@sortiz-mobl>
Message-ID: <BANLkTinpFBfOEOR6Ox1ufEHZo3qwRq8zhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2011 at 5:48 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Haojian,
>
> On Mon, Apr 18, 2011 at 10:04:03PM +0800, Haojian Zhuang wrote:
>> This driver provides registers and IRQ of PXA3xx chips to the ds1wm driver.
> I see why this is needed, but I really think the ds1wm driver should be
> converted to a regular platform device. The MFD driver below is just adding a
> useless middle layer between your platform code and the ds1wm one.
>
I'm OK to use the regulator platform device for ds1wm driver except
for one concern.
ds1wm driver is designed for mfd cell driver. I need to update it as
regulator platform
driver first. cell->enable() / cell->disable() is used to enable clock
for ds1wm driver.
So I need to change the API from cell->enable/disable to clk_enable()
/ clk_disable().

But the key issue is that there's no common structure for clkdev. Now
clkdev is only
designed for deeply machine depend.
