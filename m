From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 07 Jun 2016 16:33:49 +0200
Subject: [RESEND PATCH] ARM64: dts: rockchip: add thermal zone node for
 rk3399 SoCs
In-Reply-To: <1464161975-31299-1-git-send-email-wxt@rock-chips.com>
References: <1464161975-31299-1-git-send-email-wxt@rock-chips.com>
Message-ID: <2777347.d7vA3TK9Oa@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 25. Mai 2016, 15:39:35 schrieb Caesar Wang:
> This adds thermal zone node to rk3399 dtsi, rk3399 thermal data is
> including the cpu and gpu sensor zone node.
> 
> The thermal zone node is the node containing all the required info
> for describing a thermal zone, including its cooling device bindings.
> The thermal zone node must contain, apart from its own properties, one
> sub-node containing trip nodes and one sub-node containing all the zone
> cooling maps.
> 
> The following is the parameter is introduced:
> * polling-delay:
> The maximum number of milliseconds to wait between polls
> 
> * polling-delay-passive:
> The maximum number of milliseconds to wait between polls when performing
> passive cooling.
> 
> * trips:
> A sub-node which is a container of only trip point nodes required to
> describe the thermal zone.
> 
> * cooling-maps:
> A sub-node which is a container of only cooling device map nodes, used to
> describe the relation between trips and cooling devices.
> 
> * cooling-device:
> A phandle of a cooling device with its specifier, referring to which
> cooling device is used in this cooling specifier binding. In the cooling
> specifier, the first cell is the minimum cooling state and the second cell
> is the maximum cooling state used in this map.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts64 branch for 4.8.
I've dropped all the milliseconds etc comments though. They're part of the 
binding, so no need to document the unit in the dts all the time :-)


Thanks
Heiko
