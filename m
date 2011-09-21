From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 21 Sep 2011 13:29:03 -0700
Subject: [PATCH 3/3] arm/tegra: Move "gpio-names.h" into
	<mach/gpio-tegra.h>
In-Reply-To: <CAOesGMhdkrtjvXWHhbLSj804s+CzTthn_hrGafp5K=Va5MTZ=w@mail.gmail.com>
References: <1316633620-13184-1-git-send-email-swarren@nvidia.com>
	<1316633620-13184-3-git-send-email-swarren@nvidia.com>
	<CAOesGMhdkrtjvXWHhbLSj804s+CzTthn_hrGafp5K=Va5MTZ=w@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173818019E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, September 21, 2011 2:15 PM:
> On Wed, Sep 21, 2011 at 12:33 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > This centralizes all SoC-level GPIO-related definitions into a single
> > header file.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> >
> > ?arch/arm/mach-tegra/gpio-names.h ? ? ? ? ? ? ?| ?247 -------------------------
> > ?arch/arm/mach-tegra/include/mach/gpio-tegra.h | ?225 ++++++++++++++++++++++
> > ?11 files changed, 226 insertions(+), 257 deletions(-)
> > ?delete mode 100644 arch/arm/mach-tegra/gpio-names.h
> 
> The main reason that gpio-names.h was only in the mach directory and
> not under include in the first place, is to discourage use outside of
> the base platform code and board definitions.
> 
> There should be no need for drivers and non-mach-tegra code to use the
> file, so doing a current-directory include of it should be OK. Or do
> you have other plans for it?

My primary motivation was to bring Tegra into line with what appears to
be common practice amongst other ARM sub-architectures; many of
mach-$x/include/mach/gpio-$x.h define the GPIO names there.

Still, your argument is valid; I don't foresee a need to anything other
than mach-tegra/*.c to need the GPIO names file.

So, feel free to take/drop this patch as you desire.

-- 
nvpublic
