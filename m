From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Nov 2011 08:59:48 -0800
Subject: [PATCH] arm/tegra: Fix build error with tegra_assert_system_reset
In-Reply-To: <20111123095009.GG9581@n2100.arm.linux.org.uk>
References: <1322009631-711-1-git-send-email-swarren@nvidia.com>
 <20111123095009.GG9581@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C6CC@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Wednesday, November 23, 2011 2:50 AM:
> On Tue, Nov 22, 2011 at 05:53:51PM -0700, Stephen Warren wrote:
> > Build error:
> >
> > error: static declaration of 'tegra_assert_system_reset' follows non-static
> > declaration
> >
> > Fix:
> >
> > Remove the non-static declaration; the function should be local now.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> Thanks Stephen.  I'd prefer to fix this a different way, moving tegra to
> use the .restart method instead.  So, I'm about to merge this into the
> commit which created your error.
> ...

OK, I tested that and it works too.

Thanks!

-- 
nvpublic
