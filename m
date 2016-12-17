From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 17 Dec 2016 09:01:06 +0530
Subject: [PATCH] Documentation: dt: Explicitly mark Samsung Exynos SoC
 bindings as unstable
In-Reply-To: <1481897676-13578-1-git-send-email-m.szyprowski@samsung.com>
References: <1481897676-13578-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAGcde9EAQk9H0Ske9DTyQZWTCUSG5d2nUooYwBJXJhYgWYMA4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 16 December 2016 at 19:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Samsung Exynos SoCs and boards related bindings evolved since the initial
> introduction, but initially the bindings were minimal and a bit incomplete
> (they never described all the hardware modules available in the SoCs).
> Since then some significant (not fully compatible) changes have been
> already committed a few times (like gpio replaced by pinctrl, display ddc,
> mfc reserved memory, some core clocks added to various hardware modules,
> added more required nodes).
>
> On the other side there are no boards which have device tree embedded in
> the bootloader. Device tree blob is always compiled from the kernel tree
> and updated together with the kernel image.
>
> Thus to avoid further adding a bunch of workarounds for old/missing
> bindings and allow to make cleanup of the existing code and device tree
> files, lets mark Samsung Exynos SoC platform bindings as unstable. This
> means that bindings can may change at any time and users should use the
> dtb file compiled from the same kernel source tree as the kernel image.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

I agree with you. This is very much required. It's not only about new
bindings, we are facing problems in adopting existing bindings as well
(e.g scu), to make exynos support completely DT based and simplify our
code base.

I expect and foresee requirements of many more such changes in very near future.

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey
