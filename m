From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jan 2014 21:33:27 +0000
Subject: [PATCH 5/5] clk: versatile: respect parent rate in ICST clock
In-Reply-To: <CACRpkdZ1F_SvGcerMDfmhSgnLVzLXBJnQ9iftSG6yW2mMhOOKQ@mail.gmail.com>
References: <1390251332-6411-1-git-send-email-linus.walleij@linaro.org>
 <20140120211207.GI15937@n2100.arm.linux.org.uk>
 <CACRpkdZ1F_SvGcerMDfmhSgnLVzLXBJnQ9iftSG6yW2mMhOOKQ@mail.gmail.com>
Message-ID: <20140120213327.GK15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 10:16:53PM +0100, Linus Walleij wrote:
> On Mon, Jan 20, 2014 at 10:12 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> >> -static const struct icst_params impd1_vco2_params = {
> >> +static struct icst_params impd1_vco2_params = {
> >>       .ref            = 24000000,     /* 24 MHz */
> >>       .vco_max        = ICST525_VCO_MAX_3V,
> >>       .vco_min        = ICST525_VCO_MIN,
> >
> > Right, so we end up writing directly into these _shared_ _statically_
> > _allocated_ structures.
> 
> Argh yeah that's right.
> 
> I'll think of something better, like allocating the params on-the-fly
> for DT instead.

That's actually why they're const - they're const because they are not
supposed to be written to...

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
