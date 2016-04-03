From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 3 Apr 2016 18:22:44 +0200
Subject: [PATCH RESEND] ARM: l2x0: add three special L210 aux control flags
In-Reply-To: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
References: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZeAKkU4Cr6TTQor_6zw2iVGgXmTdcsQuHuR07Q8yZHiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 1:11 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

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

Russell, this patch is in the patch tracker with Rob's ACK from
the DT side, do you think you could apply it?

For Nomadik I actually only need the write-allocate-override
flag to be selectable, so if you think it is increasing complexity
too much I'd be happy to make a diet version which only
adds this flag.

Yours,
Linus Walleij
