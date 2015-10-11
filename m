From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 11 Oct 2015 12:02 +0200
Subject: [PATCH] soc/rockchip: Restrict to ARCH_ROCKCHIP
In-Reply-To: <1444398378-24974-1-git-send-email-thierry.reding@gmail.com>
References: <1444398378-24974-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <11653010.7KoG7eRGs0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Am Freitag, 9. Oktober 2015, 15:46:18 schrieb Thierry Reding:
> From: Thierry Reding <treding@nvidia.com>
> 
> By definition this directory contains drivers that are specific to the
> Rockchip architecture. All Kconfig options should therefore depend on
> ARCH_ROCKCHIP to avoid exposing these symbols on other architectures.
> For example, this options currently shows up as new when doing an
> incremental build on PowerPC.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

thanks for catching this and I agree that Rockchip stuff should not leak into 
other arches :-) .

I've applied this after adding a "|| COMPILE_TEST" alternative to the 
condition.


Thanks
Heiko
