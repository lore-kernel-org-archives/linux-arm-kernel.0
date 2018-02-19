From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 19 Feb 2018 16:21:49 +0530
Subject: [PATCH v2] ARM: da8xx: use platform data for CFGCHIP syscon regmap
In-Reply-To: <1518924144-5308-1-git-send-email-david@lechnology.com>
References: <1518924144-5308-1-git-send-email-david@lechnology.com>
Message-ID: <7f7ea722-6563-0c11-68f9-947f8ae7a26f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 February 2018 08:52 AM, David Lechner wrote:
> This converts from using a platform device for the CFGCHIP syscon
> regmap to using platform data to pass the regmap to consumers.
> 
> A lazy getter function is used so that the regmap will only be
> created if it is actually used. This function will also be used
> in the clock init when we convert to the common clock framework.
> 
> The USB PHY driver is currently the only consumer. This driver is
> updated to use platform data to get the CFGCHIP regmap instead of
> syscon_regmap_lookup_by_pdevname().
> 
> Signed-off-by: David Lechner <david@lechnology.com>>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> ---
> 
> v2 changes:
> - add #ifndef/#define to header file

Thanks. Picked this instead of the earlier version I had queued.

Regards,
Sekhar
