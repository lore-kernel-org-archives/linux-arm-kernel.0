From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2012 17:44:26 +0000
Subject: OMAP* Latest build failures
In-Reply-To: <20121114171730.GS6801@atomide.com>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk>
 <50A3844B.8040208@ti.com> <20121114164801.GQ6801@atomide.com>
 <20121114165947.GR6801@atomide.com> <20121114171730.GS6801@atomide.com>
Message-ID: <20121114174426.GC3332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 09:17:31AM -0800, Tony Lindgren wrote:
> Looks like the way to do this not to use oldnoconfig but to do:
> 
> $ make KCONFIG_ALLCONFIG=../configs/rmk-omap4430-sdp-noconfig allnoconfig
> 
> It seems that oldnoconfig will pick the new options that have default y?

That is the correct way to tell Kconfig to use the seed configuration -
that forces the options in the ALLCONFIG file to the values in there in
the final configuration while setting the rest of the options as desired
by the all*config target.
