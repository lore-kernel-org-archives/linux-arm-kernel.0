From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Apr 2014 22:47:09 +0100
Subject: [PATCH RFC 3/3] drm/exynos: use pending_components for
 components tracking
In-Reply-To: <1397734130-21019-4-git-send-email-a.hajda@samsung.com>
References: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
 <1397734130-21019-4-git-send-email-a.hajda@samsung.com>
Message-ID: <20140417214709.GY24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 01:28:50PM +0200, Andrzej Hajda wrote:
> +out:
> +	if (ret != -EPROBE_DEFER)
> +		exynos_drm_dev_ready(&pdev->dev);

So we end up with everyone needing a "ready" call in each sub-driver
back into the main driver... this makes it impossible to write a
generic subcomponent driver which is not tied in any way to the
main driver.

That is quite some restriction, and would prevent, for example, the
TDA998x driver being used both with Armada DRM, tilcdc and any other
driver.

So, while your solution may work for exynos, it's not suitable for
general use.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
