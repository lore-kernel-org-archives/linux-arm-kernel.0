From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Apr 2016 08:43:15 +0100
Subject: [PATCH RESEND] ARM: l2x0: add three special L210 aux control flags
In-Reply-To: <CACRpkdZeAKkU4Cr6TTQor_6zw2iVGgXmTdcsQuHuR07Q8yZHiQ@mail.gmail.com>
References: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZeAKkU4Cr6TTQor_6zw2iVGgXmTdcsQuHuR07Q8yZHiQ@mail.gmail.com>
Message-ID: <20160405074315.GX19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2016 at 06:22:44PM +0200, Linus Walleij wrote:
> On Tue, Mar 15, 2016 at 1:11 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > This adds support for setting the flag bits "wrap access disable",
> > "write allocate override" and "exclusive abort disable" to the L210
> > variant from the device tree.
> >
> > The "write allocate override" bit was used on the Nomadik and
> > necessary to properly make use of the L210 cache on that machine
> > without sporadic crashes.
> >
> > I took this oppportunity to add all three flags so we avoid excess
> > patching for each one.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Russell, this patch is in the patch tracker with Rob's ACK from
> the DT side, do you think you could apply it?
> 
> For Nomadik I actually only need the write-allocate-override
> flag to be selectable, so if you think it is increasing complexity
> too much I'd be happy to make a diet version which only
> adds this flag.

I haven't forgotten it, but I do wonder whether this endless shovelling
of more and more DT properties is really the way forward, or whether
some of this stuff should be handled by the boot loader/firmware.

That's the reason that you get the:

"L2C: DT/platform modifies aux control register: 0x%08x -> 0x%08x"

message at _warning_ level.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
