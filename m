From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 1 Feb 2012 22:32:32 +0100
Subject: [PATCH v2 1/2] PM / Domains: Add OF support
In-Reply-To: <041e01ccdfdc$9a4257a0$cec706e0$%kim@samsung.com>
References: <1325931055-14486-1-git-send-email-thomas.abraham@linaro.org>
 <201201172145.35407.rjw@sisk.pl>
 <041e01ccdfdc$9a4257a0$cec706e0$%kim@samsung.com>
Message-ID: <201202012232.32282.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 31, 2012, Kukjin Kim wrote:
> Rafael J. Wysocki wrote:
> > 
> > On Tuesday, January 17, 2012, Kukjin Kim wrote:
> > > Rafael J. Wysocki wrote:
> > > >
> > > > On Saturday, January 07, 2012, Thomas Abraham wrote:
> > > > > A device node pointer is added to generic pm domain structure to
> > > > associate
> > > > > the domain with a node in the device tree. The platform code parses the
> > > > > device tree to find available nodes representing the generic power
> > > > domain,
> > > > > instantiates the available domains and initializes them by calling
> > > > > pm_genpd_init().
> > > > >
> > > > > Nodes representing the devices include a phandle of the power domain to
> > > > > which it belongs. As these devices get instantiated, the driver code
> > > > > checkes for availability of a power domain phandle, converts the phandle
> > > > > to a device node and uses the new pm_genpd_of_add_device() api to
> > > > > associate the device with a power domain.
> > > > >
> > > > > pm_genpd_of_add_device() runs through its list of registered power
> > > > domains
> > > > > and matches the OF node of the domain with the one specified as the
> > > > > parameter. If a match is found, the device is associated with the
> > > > matched
> > > > > domain.
> > > > >
> > > > > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > > > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > > > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> > > >
> > > > I can take this patch for 3.4, but your [2/2] depends on it, so I'm not
> > > > sure how to handle that.  If you want me to take the other patch too,
> > > > it'll need ACKs from the Exynos maintaniers.
> > > >
> > > Hi Rafael,
> > >
> > > Basically, looks ok to me.
> > >
> > > But it would be good if [v3 2/2] patch of this series (this patch) could be
> > > applied in samsung tree to avoid conflicts as it modifies many files. I
> > > don't want to make a trouble when sending my tree to upstream. Of course, as
> > > you said, this have a dependency with [v2 1/2]. So if you're ok, let me
> > > create topic branch will have both(1/2 and 2/2) to merge in your tree.
> > >
> > > How do you think?
> > 
> > That would work for me too.
> > 
> Hi Rafael,
> 
> I created topic branch for you with your ack.
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v3.4-for-rafael
> 
> Please merge that in your tree and if any problems, please kindly let me know.

Merged into linux-pm/pm-domains and into linux-pm/linux-next and pushed back.

Thanks,
Rafael
