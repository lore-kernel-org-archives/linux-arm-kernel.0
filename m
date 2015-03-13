From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 13 Mar 2015 10:20:21 -0700
Subject: [PATCH 02/10] pm: domains: factor out code to get the generic PM
 domain from a struct device
In-Reply-To: <E1YWSMv-0006Fx-E6@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Fri, 13 Mar 2015 16:23:25 +0000")
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YWSMv-0006Fx-E6@rmk-PC.arm.linux.org.uk>
Message-ID: <7hpp8crezu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> The PM domain code contains two methods to get the generic PM domain
> for a struct device.  One is dev_to_genpd() which is only safe when
> we know for certain that the device has a generic PM domain attached.
> The other is coded into genpd_dev_pm_detach() which ensures that the
> PM domain in the struct device is a generic PM domain (and so is safer).
>
> This commit factors out the safer version and documents it.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kevin Hilman <khilman@linaro.org>

On top of this, I assume you're thinking that the externally available
dev_to_genpd() should probably be replaced by pm_genpd_lookup_dev(), and
dev_to_genpd() should only be used internally to genpd?

Kevin
