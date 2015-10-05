From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Oct 2015 03:45:57 -0700
Subject: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default
 status for 32k counter
In-Reply-To: <1443559446-26969-12-git-send-email-balbi@ti.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-12-git-send-email-balbi@ti.com>
Message-ID: <20151005104556.GT23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150929 13:48]:
> All devices should have a default status. Ignoring
> the arguments if it should be 'okay' or 'disabled'
> by default, let's set them all the 'disabled' and
> have boards enable 32k counter.

We should not use "disabled" really at all. That means
no struct device is ever created while that hardawre is
there for the internal devices for sure.

Also, we should use the 32k counter as the default one
as that's always on for deeper idle states.

For cases where the 32k ocillator is not available,
it's better to just set the source clock rate to 0
in the board specific dts file and have the driver
bail out early if source clock rate is 0.

Regards,

Tony
