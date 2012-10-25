From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2012 14:07:15 +0100
Subject: [PATCH 2/6] pinctrl: Update clock handling for the
 pinctrl-nomadik GPIO driver
In-Reply-To: <CACRpkda2NQok7kzh0pFmZPYd4nky1kUw=67DZAYAJAXGuc1yzQ@mail.gmail.com>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
 <1351089926-32161-3-git-send-email-lee.jones@linaro.org>
 <CACRpkda2NQok7kzh0pFmZPYd4nky1kUw=67DZAYAJAXGuc1yzQ@mail.gmail.com>
Message-ID: <20121025130715.GG4008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2012, Linus Walleij wrote:

> On Wed, Oct 24, 2012 at 4:45 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > The clock framework has changed somewhat and it's now better to
> > invoke clock_prepare_enable() and clk_disable_unprepare() rather
> > than the legacy clk_enable() and clk_disable() calls. This patch
> > converts the Nomadik Pin Control driver to the new framework.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I was convinced that this is a good change but no regression,
> so applied to the devel branch for 3.8.
> 
> I also removed the initial clk_prepare() so the reference count
> may actually go down to 0 for the GPIO block and the peripheral
> cluster eventually gets relaxed.

Nice. Thanks Linus.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
