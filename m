From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 17:35:03 +0000
Subject: [PATCH 02/10] pm: domains: factor out code to get the generic PM
 domain from a struct device
In-Reply-To: <7hpp8crezu.fsf@deeprootsystems.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YWSMv-0006Fx-E6@rmk-PC.arm.linux.org.uk>
 <7hpp8crezu.fsf@deeprootsystems.com>
Message-ID: <20150313173503.GY8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 10:20:21AM -0700, Kevin Hilman wrote:
> Russell King <rmk+kernel@arm.linux.org.uk> writes:
> 
> > The PM domain code contains two methods to get the generic PM domain
> > for a struct device.  One is dev_to_genpd() which is only safe when
> > we know for certain that the device has a generic PM domain attached.
> > The other is coded into genpd_dev_pm_detach() which ensures that the
> > PM domain in the struct device is a generic PM domain (and so is safer).
> >
> > This commit factors out the safer version and documents it.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> On top of this, I assume you're thinking that the externally available
> dev_to_genpd() should probably be replaced by pm_genpd_lookup_dev(), and
> dev_to_genpd() should only be used internally to genpd?

I think that would be a sensible improvement over leaving the unsafe
dev_to_genpd() exposed.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
