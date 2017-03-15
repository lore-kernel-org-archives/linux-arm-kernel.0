From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Mar 2017 17:34:21 +0100
Subject: [RFC PATCH 3/4] pinctrl: rockchip: split out verification of mux
 settings
In-Reply-To: <20170313183813.3582-4-john@metanate.com>
References: <20170313183813.3582-1-john@metanate.com>
 <20170313183813.3582-4-john@metanate.com>
Message-ID: <5070254.AaMND3ln5I@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 13. M?rz 2017, 18:38:12 CET schrieb John Keeping:
> We need to avoid calling regmap functions from irq handlers, so the next
> commit is going to move the call to rockchip_set_mux() into an
> irq_bus_sync_unlock handler.  But we can't return an error from there so
> we still need to check the settings from rockchip_irq_set_type() and we
> will use this new rockchip_verify_mux() function from there.
> 
> Signed-off-by: John Keeping <john@metanate.com>

straightforward separation of the verification code
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
