From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 16:10:59 -0500
Subject: [PATCH RESEND] ARM: l2x0: add three special L210 aux control flags
In-Reply-To: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
References: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160318211059.GA31490@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 01:11:22PM +0100, Linus Walleij wrote:
> This adds support for setting the flag bits "wrap access disable",
> "write allocate override" and "exclusive abort disable" to the L210
> variant from the device tree.
> 
> The "write allocate override" bit was used on the Nomadik and
> necessary to properly make use of the L210 cache on that machine
> without sporadic crashes.
> 
> I took this oppportunity to add all three flags so we avoid excess
> patching for each one.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 10 ++++++++++
>  arch/arm/mm/cache-l2x0.c                         | 18 ++++++++++++++++++
>  2 files changed, 28 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
