From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 05 Mar 2018 15:42:11 +0100
Subject: [PATCH] soc: rockchip: disable jtag switching for RK3128 SoCs
In-Reply-To: <7020f92d-cc0e-745e-713b-3aa847b7e939@rock-chips.com>
References: <20180302122031.17426-1-heiko@sntech.de>
 <7020f92d-cc0e-745e-713b-3aa847b7e939@rock-chips.com>
Message-ID: <1633972.b4bkohDpDd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Montag, 5. M?rz 2018, 15:39:04 CET schrieb Shawn Lin:
> On 2018/3/2 20:20, Heiko Stuebner wrote:
> > From: Xiao Yao <xiaoyao@rock-chips.com>
> > 
> > Disable IO function switching between sdmmc and jtag
> > for RK3128 SoCs.
> > 
> 
> I acked this on the vendor kernel tree, so FWIW:
> 
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Hope this is one of the final patches for that, as I would
> revive IO function switching between sdmmc and jtag for newer
> SoCs after addressing the problem from HW level.

the main problem we had with that was that the  mmc-subsystem
somehow definitly didn't like it when the controller pins where pulled
out from under it on card eject.

But of course, if you can get this solved by hw somehow, that
would be pretty cool :-)


Heiko
