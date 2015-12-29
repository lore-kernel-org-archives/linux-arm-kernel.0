From: robh@kernel.org (Rob Herring)
Date: Tue, 29 Dec 2015 14:30:34 -0600
Subject: [PATCH 2/3] drivers: net: cpsw: fix error messages when using
 phy-handle DT property
In-Reply-To: <1450830994-5450-3-git-send-email-drivshin.allworx@gmail.com>
References: <1450830994-5450-1-git-send-email-drivshin.allworx@gmail.com>
 <1450830994-5450-3-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <20151229203034.GA18528@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 07:36:33PM -0500, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
> 
> The phy-handle, phy_id, and fixed-link properties are mutually exclusive,
> and only one need be specified. However if phy-handle was specified, an
> error message would complain about the lack of phy_id or fixed-link.
> 
> Also, if phy-handle was specified and the subsequent of_phy_connect()
> failed, the error message still referenced slaved->data->phy_id, which
> would be empty. Instead, use the name of the device_node as a useful
> identifier.
> 
> Fixes: 9e42f715264f ("drivers: net: cpsw: add phy-handle parsing")
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
> This would require some adjustments to backport to 4.3-stable due to
> other changes in this area. Let me know if you want a version of this
> against v4.3.3.
> 
>  Documentation/devicetree/bindings/net/cpsw.txt |  4 ++--

For the binding:

Acked-by: Rob Herring <robh@kernel.org>
