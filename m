From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 02 Feb 2016 22:43:36 +0100
Subject: [RFC PATCH] ARM: dts: rockchip: increase the mclk_fs to 512 for
 kylin board
In-Reply-To: <1454057361-22923-1-git-send-email-zhengxing@rock-chips.com>
References: <1454057361-22923-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <5872159.rO8vOly5eX@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 29. Januar 2016, 16:49:21 schrieb Xing Zheng:
> If we playback the 8KHz FS audio with the 256 mclk_fs, we need the
> mclk = 256 * 8000 = 2.048MHz, the frac div is 594 / 2.048 = 290,
> the frac div value 0x00809015 set to the CRU_CLKSEL7_CON will cause
> to hang.
> 
> We increase the mclk_fs to 512, will get the mclk = 512 * 8000 =
> 4.096MHz, use 0x01009015 instead of 0x00809015 to work around this
> issue. We will keep tracking it.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

applied to my dts32 branch for 4.6


Thanks
Heiko
