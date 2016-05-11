From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 11 May 2016 09:11 +0200
Subject: [PATCH v2] pinctrl: rockchip: fix pull setting error for rk3399
In-Reply-To: <1462937968-4952-1-git-send-email-wxt@rock-chips.com>
References: <1462937968-4952-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1493162.roERW60dFE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 11. Mai 2016, 11:39:28 schrieb Caesar Wang:
> From: David Wu <david.wu@rock-chips.com>
> 
> This patch fixes the pinctrl pull bias setting, since the pull up/down
> setting is the contrary for gpio0(just the gpio0a and gpio0b) and
> gpio2(just the gpio2c and gpio2d).
> 
> From the TRM said, the gpio0a pull polarity setting:
> gpio0a_p
> GPIO0A PE/PS programmation section, every
> GPIO bit corresponding to 2bits[PS:PE]
> 2'b00: Z(Normal operation);
> 2'b11: weak 1(pull-up);
> 2'b01: weak 0(pull-down);
> 2'b10: Z(Normal operation);

This could mention gpio2c and gpio2d as well, as the code now does.

Otherwise the patch looks good and I also compared with the TRM, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
