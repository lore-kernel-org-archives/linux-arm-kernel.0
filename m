From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 24 Sep 2018 19:16:45 +0200
Subject: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC
 as unstable
In-Reply-To: <CAOesGMgE6QaasvHi7E55Z4U1Pp0+8QYW2eRLMsExebZ999_UHA@mail.gmail.com>
References: <20180830180205.18121-1-krzk@kernel.org>
 <CAOesGMgE6QaasvHi7E55Z4U1Pp0+8QYW2eRLMsExebZ999_UHA@mail.gmail.com>
Message-ID: <20180924171645.GA10910@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 23, 2018 at 02:46:20PM +0100, Olof Johansson wrote:
> On Thu, Aug 30, 2018 at 7:02 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Samsung Exynos SoCs and boards related bindings evolved since the initial
> > introduction, but initially the bindings were minimal and a bit incomplete
> > (they never described all the hardware modules available in the SoCs).
> > Since then some significant (not fully compatible) changes have been
> > already committed a few times (like gpio replaced by pinctrl, display ddc,
> > mfc reserved memory, some core clocks added to various hardware modules,
> > added more required nodes).
> >
> > On the other side there are no boards which have device tree embedded in
> > the bootloader. Device tree blob is always compiled from the kernel tree
> > and updated together with the kernel image.
> >
> > Thus to avoid further adding a bunch of workarounds for old/missing
> > bindings, make development of new platforms easier and allow to make
> > cleanup of the existing code and device tree files, lets mark some
> > Samsung Exynos SoC platform bindings as unstable. This means that
> > bindings can may change at any time and users should use the dtb file
> > compiled from the same kernel source tree as the kernel image.
> 
> I have to admit that I don't really like this approach, and I missed
> the patch when originally posted (I did notice it in the pull request
> it came in with though).
> 
> The main concern for me is that with a blanket "everything is always
> unstable" we discard the notion that we should strive for bindings to
> be stable and backwards compatible.

The original idea from Marek was to mark everything unstable. After
comments from Rob I made it weaker already by changing to specific group
of compatibles. Accepting their instability does not mean that we will
be doing this on whenever possible. It just opens the possibility of
finding some balance in cleanups and development. Sometimes things have
to be seriously changed (fixed) and implementing workarounds for
existing ABI might be huge work by itself.

IOW, we want stability but not with the costs of huge development
efforts... because no one else except us cares about the stability.

> 
> Questions that come to mind are:
> 
>  - When do they stop being unstable?

They became unstable in a subjective way so I assume that reverse is the
same, based on consensus and discussions.

I am not sure if a hard time limit is good. There is no timeline for the
Exynos development, no public roadmaps but rather community and
partially volountary effort.  Therefore whatever number we set, it might
be totally not matching reality.

>  - Is there a way to note in the binding itself that it's still
> unstable with an anticipation of when it will be settled in?

Hmm, I see that some existing bindings are being added with "Unstable"
warning:

	git grep -i unstable Documentation/devicetree/

so there should be no problem for putting there a timeframe.

>  - Is there a better way to version the bindings to avoid complete
> backwards compatibility?

Some architectures are using overlays for handling backward
compatibility. Anyway it might put additional effort on driver
development.

> Pointing out a couple of cases where it has been painful to stay
> backwards compatible could also be useful for understanding (even
> though you run the risk of each case being explained away with
> suggestions of how it can be handled).
> 


Best regards,
Krzysztof
