From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Mar 2010 22:50:47 +0000
Subject: [PATCH] ARM: Realview/Versatile/Integrator: separate out
	common clock code
In-Reply-To: <000001cabc52$b2514090$16f3c1b0$@tuckley@arm.com>
References: <git-1267729916-2dbb324ef24e91a11ed84389718874ece7056fd7@rmk-PC>
	<git-1267729916-5eb24b69c868ed8197842aa7c1576cdd05d9d41e@rmk-PC>
	<000001cabc52$b2514090$16f3c1b0$@tuckley@arm.com>
Message-ID: <20100305225047.GB20095@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 10:57:49AM -0000, Colin Tuckley wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Russell King
> 
> > +	select PLAT_VERSATILE
> 
> This needs to be called something else if it's going to be used for
> mach-realview and mach-integrator. It's too confusing because of there being
> a mach-versatile. It needs to be a more generic name, something that isn't a
> mach. Perhaps "ARMDEV".

Well, the platform families are officially documented on the ARM 
documentation site as:

"Versatile Express"
"RealView Versatile baseboards" (eg, of which the Realview EB and
  Versatile PB926 are members)
"Integrator baseboards"

So the commonest naming theme is 'Versatile' - except for the old
Integrator platforms.  

I think it's reasonable to describe the common parts between all these
families as 'Vesatile' rather than making up another name which doesn't
really connect with any of them.
