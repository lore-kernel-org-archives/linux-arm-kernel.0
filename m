From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 17 Jun 2013 12:16:35 +0200
Subject: [PATCH v7 0/9] Generic PHY Framework
In-Reply-To: <1371113039-5784-1-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
Message-ID: <51BEE203.6090103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/13/2013 10:43 AM, Kishon Vijay Abraham I wrote:
> Added a generic PHY framework that provides a set of APIs for the PHY drivers
> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
> the PHY with or without using phandle.
> 
> This framework will be of use only to devices that uses external PHY (PHY
> functionality is not embedded within the controller).
> 
> The intention of creating this framework is to bring the phy drivers spread
> all over the Linux kernel to drivers/phy to increase code re-use and to
> increase code maintainability.
> 
> Comments to make PHY as bus wasn't done because PHY devices can be part of
> other bus and making a same device attached to multiple bus leads to bad
> design.
> 
> If the PHY driver has to send notification on connect/disconnect, the PHY
> driver should make use of the extcon framework. Using this susbsystem 
> to use extcon framwork will have to be analysed.
> 
> Making omap-usb2 and twl4030 to use this framework is provided as a sample.
> 
> This patch series is developed on linux mainline tree.
> 
> Changes from v6
> * corrected few typos in Documentation
> * Changed PHY Subsystem to *bool* in Kconfig (to avoid compilation errors when
>   PHY Subsystem is kept as module and the dependent modules are built-in)
> * Added if pm_runtime_enabled check before runtime pm calls.

Looks good, feel free to add:

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com> for patches
1...3/9, 5...7/9

and Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com> for patch 1/9

Hopefully we can gather more Acks and merge it for 3.11.

I have already used this API for our MIPI CSI-2/DSIM DPHYs driver,
the RFC patch series can be found at [1].

Thanks,
Sylwester

[1] http://www.spinics.net/lists/arm-kernel/msg251666.html
