From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Oct 2015 13:31:53 +0000
Subject: [PATCH 09/13] clk: versatile-icst: add device tree support
In-Reply-To: <CACRpkdZUzTsMcFrudF6RRU5_1Njr=8L_XRUEmAWqvEnoJQ96Cw@mail.gmail.com>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-10-git-send-email-linus.walleij@linaro.org>
 <20151015192626.GO4558@codeaurora.org>
 <CACRpkdZUzTsMcFrudF6RRU5_1Njr=8L_XRUEmAWqvEnoJQ96Cw@mail.gmail.com>
Message-ID: <20151026133153.GG8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 02:14:15PM +0100, Linus Walleij wrote:
> On Thu, Oct 15, 2015 at 9:26 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 10/15, Linus Walleij wrote:
> >> +
> >> +     if (of_device_is_compatible(np, "arm,syscon-icst525"))
> >> +             icst_desc.params = &icst525_params;
> >> +     else if (of_device_is_compatible(np, "arm,syscon-icst307"))
> >> +             icst_desc.params = &icst307_params;
> >
> > I guess if we add anymore here we should use an of_device_id
> > array instead.
> 
> As it happens those two are gonna be it.
> 
> ARM never created any more integrated ICST devices, and
> they stopped using them since. Those two are the required
> ones.

As ARM didn't create any ICST devices at all, that's hardly surprising.
These devices are created by Integrated Circuit Systems, Inc.  The 525
is a parallel-loaded clock generator, the 307 is a serial-loaded clock
generator.

However, they have no "standard" software interface - indeed, the 525
is marketed as a device that needs no processor or software to be used,
so it doesn't have a "software" interface as such.

ARM Ltd's hardware on these boards provides interfaces to these, however
the underlying ICST support I wrote was factored to separate out the
interface from the chip support - I haven't been tracking what's been
going on with these, but I hope that separation has been kept as it's
entirely logical, and describing these things in DT as an ARM Ltd device,
combining the ICST device itself with its interface would be wrong.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
