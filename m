From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 17:42:41 -0600
Subject: [PATCH v5 0/6] Generic PHY Framework
In-Reply-To: <1364993634-6378-1-git-send-email-kishon@ti.com>
References: <1364993634-6378-1-git-send-email-kishon@ti.com>
Message-ID: <515CBE71.9000401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 06:53 AM, Kishon Vijay Abraham I wrote:
> Added a generic PHY framework that provides a set of APIs for the PHY drivers
> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
> the PHY with or without using phandle. To obtain a reference to the PHY
> without using phandle, the platform specfic intialization code (say from board
> file) should have already called phy_bind with the binding information. The
> binding information consists of phy's device name, phy user device name and an
> index. The index is used when the same phy user binds to mulitple phys.
...
> Changes from v4:
> * removed of_phy_get_with_args/devm_of_phy_get_with_args. Now the *phy providers*
>   should use their custom implementation of of_xlate or use of_phy_xlate to get
>   *phy instance* from *phy providers*.
> * Added of_phy_xlate to be used by *phy providers* if it provides only one PHY.
> * changed phy_core from having subsys_initcall to module_init.

s/of_phy_xlate/of_phy_simple_xlate/ ? That would hightlight the fact
it's just /an/ implementation for the simple case, not /the/
implementation for all cases. It'd be consistent with e.g. drivers/gpio,
which has of_gpio_simple_xlate().
