From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Apr 2014 12:54:13 +0100
Subject: [PATCH v2 3/6] ARM: dts: Device tree for AXM55xx.
In-Reply-To: <CACRpkdaqPx3=qvUtsg44rBk+ZiscUg54HmNgETcei0LzfE9uOQ@mail.gmail.com>
References: <cover.1398335771.git.anders.berg@lsi.com>
 <2386bd1367aa44741979461358a72dec89608597.1398335771.git.anders.berg@lsi.com>
 <CACRpkdbU6UashxCuPMDjEB_nbB=mXicGpjJy=HGC6r3qfxCtVQ@mail.gmail.com>
 <20140424174741.GA23444@swsaberg01>
 <CACRpkdZ1CA4mqcd5MA5HFmXSeGp-wspA0M6wnPbAsgL_gX76Fw@mail.gmail.com>
 <20140425094343.GA3160@swsaberg01>
 <CACRpkdaqPx3=qvUtsg44rBk+ZiscUg54HmNgETcei0LzfE9uOQ@mail.gmail.com>
Message-ID: <20140425115413.GL26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 01:50:25PM +0200, Linus Walleij wrote:
> This means that you can only get a proper, working IRQ from the
> first line on gpio0 right? All other IRQs will be ignored.
> 
> I see no problem in augmenting the driver to handle this
> if #irqs == 8, the big change needs to happen in drivers/amba/bus.c
> that has no way to pass any more than two IRQs atm.
> 
> I guess the best is to augment struct amba_device with a field
> struct resource *resource and num_resources like platform_device
> instead of the hard-coded single resource for iomem and two
> hardcoded IRQ placeholders, so that an arbitrary amount of
> resources can be added to an amba_device as well. But that
> may be quite a lot of work. (Russell will know which direction to
> take here.)

I definitely don't want to go down that route - I believe that the
resource arrays are more pain than they're really worth - it requires
a great amount of support to make that stuff work (just look at the
amount of code there is to search the arrays, create them, etc.)

We already have support for up to 9 IRQs, so 8 for GPIOs is already
catered for.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
