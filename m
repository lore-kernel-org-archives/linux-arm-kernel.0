From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 14:46:20 +0100
Subject: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC
 as unstable
In-Reply-To: <20180830180205.18121-1-krzk@kernel.org>
References: <20180830180205.18121-1-krzk@kernel.org>
Message-ID: <CAOesGMgE6QaasvHi7E55Z4U1Pp0+8QYW2eRLMsExebZ999_UHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 7:02 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
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
> bindings, make development of new platforms easier and allow to make
> cleanup of the existing code and device tree files, lets mark some
> Samsung Exynos SoC platform bindings as unstable. This means that
> bindings can may change at any time and users should use the dtb file
> compiled from the same kernel source tree as the kernel image.

I have to admit that I don't really like this approach, and I missed
the patch when originally posted (I did notice it in the pull request
it came in with though).

The main concern for me is that with a blanket "everything is always
unstable" we discard the notion that we should strive for bindings to
be stable and backwards compatible.

Questions that come to mind are:

 - When do they stop being unstable?
 - Is there a way to note in the binding itself that it's still
unstable with an anticipation of when it will be settled in?
 - Is there a better way to version the bindings to avoid complete
backwards compatibility?

Pointing out a couple of cases where it has been painful to stay
backwards compatible could also be useful for understanding (even
though you run the risk of each case being explained away with
suggestions of how it can be handled).


-Olof
