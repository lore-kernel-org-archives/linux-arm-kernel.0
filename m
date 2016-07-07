From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 07 Jul 2016 23:35:38 +0200
Subject: [PATCH 0/3] ARM: dts: the dts support for rk3288 firefly reload
In-Reply-To: <1467829380-16242-1-git-send-email-ayaka@soulik.info>
References: <3015470.z4L7UQJKa9@phil>
 <1467829380-16242-1-git-send-email-ayaka@soulik.info>
Message-ID: <2686572.mni1Mn7R6t@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Am Donnerstag, 7. Juli 2016, 02:22:57 schrieb Randy Li:
> The rk3288 firefly reload  is a Rockchip RK3288 based board be found by
> core board and main board. The regulators are connected in a different
> way to the previous version of firefly boards, it is necessary to
> move some common code to uncommon place.
> 
> I only tested the ethernet and confirmed that works.
> The usb in this board won't caused by the bugs in the driver.
> 
> This version follow the suggests from Heiko Stuebner,
> except the duplicated supply name problem, I don't think
> it could be fixed in that way.

I've now had a chance to look at that reload board on the firefly site.
Firefly also is the company name, so a board named that way is not 
necessarily a "variant" :-) .

And looking at the "reload" board this definitly seems to be a very 
different product with it being a system-on-module+baseboard design with 
additional peripherals like that sata bridge, camera interfaces and probably 
more.

As you might've seen, most Rockchip boards are based on some reference-
design, so are similar in a big part of their core layout.
So, looking at the vastly different product the reload is, I'd really like 
to have a separate dts for the reload, to not run into more confusing 
differences later on.

Also, when adding a new board, please also add an entry to 
Documentation/devicetree/bindingd/arm/rockchip.txt


Thanks
Heiko
