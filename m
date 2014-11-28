From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Nov 2014 14:12:41 +0000
Subject: [PATCH] arm64: enable ARCH_HAS_BANDGAP config
In-Reply-To: <CAGOxZ52o-O+=PCsGRfKEGGc0NUg_M+z5_UmbrjBwvW8+x3c22w@mail.gmail.com>
References: <1415968254-5182-1-git-send-email-a.kesavan@samsung.com>
 <CAGOxZ52o-O+=PCsGRfKEGGc0NUg_M+z5_UmbrjBwvW8+x3c22w@mail.gmail.com>
Message-ID: <20141128141240.GA4249@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 23, 2014 at 08:05:05AM +0000, Alim Akhtar wrote:
> On Fri, Nov 14, 2014 at 6:00 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> > Some of the existing thermal drivers (ti and exynos) have a dependency on
> > ARCH_HAS_BANDGAP. Activate ARCH_HAS_BANDGAP config entry for ARM64 so that
> > these drivers may be re-used.
> >
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > ---
> HAS_BANDGAP was added to ARM to indicate that arch supports a bandgap
> device like a thermal management unit, so this looks good to me.

But it doesn't look good to me. ARCH_HAS_* kind of implies that the
architecture has some feature or the port provides some feature. But in
the current use, it simply allows the enabling of the menu config
entries for two drivers (EXYNOS_THERMAL and TI_SOC_THERMAL).

If you want to specify that the SoC has a device, just use DT and not
some random config option that only enables the menu entry for the
corresponding driver.

-- 
Catalin
