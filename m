From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 16:36:51 +0100
Subject: [PATCH 0/7] Fix sti drivers whcih mix reg address spaces
In-Reply-To: <1416385632-5832-1-git-send-email-peter.griffin@linaro.org>
References: <1416385632-5832-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <8237128.RmunIxMfYX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014 08:27:05 Peter Griffin wrote:
> Hi,
> 
> Following on from Arnds comments about the picophy driver here
> https://lkml.org/lkml/2014/11/13/161, this series fixes the
> remaining upstreamed drivers for STI, which are mixing address spaces
> in the reg property. We do this in a way similar to the keystone
> and bcm7445 platforms, by having sysconfig phandle/ offset pair (
> where only one register is required). Or phandle / integer array
> where multiple offsets in the same bank are needed).
> 
> This series breaks DT compatability! But the platform support
> is WIP and only being used by the few developers who are upstreaming
> support for it. I've made each change to the driver / dt doc / dt
> file as a single atomic commit so the kernel will remain bisectable. 
> 
> This series then also enables the picophy driver, and adds back in
> the ehci/ohci dt nodes for stih410 which make use of the picophy.

This all looks very good to me, nice work!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I have one comment for patch 4, but I don't have a good solution for
that, hopefully someone on the devicetree-discuss list has some insight,
otherwise we just keep your version.

	Arnd
