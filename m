From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 25 Apr 2015 02:14:58 +0200
Subject: [PATCH] ARM: rockchip: disable dapswjdp during suspend
In-Reply-To: <1429077431-31326-1-git-send-email-zyw@rock-chips.com>
References: <1429077431-31326-1-git-send-email-zyw@rock-chips.com>
Message-ID: <2083913.tsdTRJp6Sn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. April 2015, 13:57:11 schrieb Chris Zhong:
> Reset dapswjdp is controlled by JTAG_TRSTN, if the iomux of this pin is
> not "jtag_trstn". the AP would think this pin is always high, so it can
> not reset before resume. When system resume, but the dapswjdp is not in
> a default state, it may Access some illegal address, it cause system
> crash during resume.
> Let's disable this jtag function by clear the dapdeviceen bit, it
> prohibit the dapswjdp to access memory and registers. This bit would
> be enable in MASKROM, so we need clear it in suspend everytime.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

applied to a fixes branch for 4.1


Thanks
Heiko
