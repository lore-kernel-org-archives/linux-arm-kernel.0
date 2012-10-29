From: mturquette@ti.com (Mike Turquette)
Date: Mon, 29 Oct 2012 11:32:33 -0700
Subject: [RFC PATCH] dt: describe base reset signal binding
In-Reply-To: <1351028756-22309-1-git-send-email-swarren@wwwdotorg.org>
References: <1351028756-22309-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121029183233.18780.11964@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2012-10-23 14:45:56)
> What do people think of this? Does it sound like a good idea to go ahead
> with a reset subsystem? Should we simply add a new API to the common clock
> subsystem instead (and assume that reset and clock domains match 1:1).
> Should this be implemented as part of the generic power management domains;
> see include/linux/pm_domain.h instead?
> 

Hi Stephen,

I'm not sure a "reset subsystem" is necessary, but I also do not like
using clocks as the keys for IP reset.  I think it is more common to map
IPs to struct device, no?

And of course for clocks shared by multiple users this will not scale.

Regards,
Mike
