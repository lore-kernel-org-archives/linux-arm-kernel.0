From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 21 Feb 2012 10:54:12 -0800
Subject: [PATCH 2/2] gpio: tegra: Delete tegra_gpio_enable/disable()
In-Reply-To: <CACRpkdYDVU9TAVAAw=uBp84puED0kGkdSW8goAJRG1Nc=6xCaQ@mail.gmail.com>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
 <1329719263-18971-2-git-send-email-swarren@nvidia.com>
 <CACRpkdYDVU9TAVAAw=uBp84puED0kGkdSW8goAJRG1Nc=6xCaQ@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC383@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Tuesday, February 21, 2012 3:45 AM:
> On Mon, Feb 20, 2012 at 7:27 AM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> > Recent pinctrl discussions concluded that gpio_request() and other gpiolib
> > APIs should in fact do whatever is required to mux a GPIO onto pins, by
> > calling pinctrl APIs if required. This change implements this for the
> > Tegra GPIO driver, and removes the old Tegra-specific APIs which did this.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > I don't believe this depends on other patches.
> >
> > There may be some slight context dependencies; this patch was generated
> > against next-20120217, with my recently posted "gpio: tegra: Fix build
> > issue due to irq_domain rework." applied on top.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Since it mainly touches mach-tegra stuff I think it's best to take
> this through the Tegra tree, Olof can you queue it?

That makes sense to me, but just to be clear for Olof, best to defer
applying this until the discussion for patch 1 in the series is resolved;
this patch might need rework depending on the decisions there.

-- 
nvpublic
