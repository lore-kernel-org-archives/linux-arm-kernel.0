From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2011 17:53:45 +0200
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH 2/2]
	GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller)
In-Reply-To: <CACRpkda6Bz_0odpLXokDdkPMyQKD6x5GnD52xnKZmDw1_sXW8A@mail.gmail.com>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<201108091515.47961.arnd@arndb.de>
	<CACRpkda6Bz_0odpLXokDdkPMyQKD6x5GnD52xnKZmDw1_sXW8A@mail.gmail.com>
Message-ID: <201109191753.46166.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 September 2011, Linus Walleij wrote:
> On Tuesday 09 August 2011, Barry Song wrote:
> 
> > Or do we want to delete the whole arch/arm/mach-xxx/include/mach directory?
> >
> > If not, it is probably that SoC can still hold some chip-specific APIs
> > in arch/arm/mach-xxx/include/mach/yyy.h.
> 
> I was actually proposing patches that moved GPIO headers from
> <mach/foo-gpio> to <linux/gpio/foo.h> but they were NAK:ed or
> frowned upon, so I guess we're keeping the <mach/*> include
> union namespace for machine/SoC-specific headers.
> 
> Now we just try to make files in this namespace have unqiue
> names.

That doesn't really sound like a long-term solution. I think the idea
for the single-zimage work is to eventually make the mach/ headers
local to the mach-* directory so they cannot be included from any
device drivers at all.

For any constants in those headers, they should be communicated
to the drivers using the platform data or (better) device tree
information.

The platform specific APIs that you mentioned are a bigger problem,
and I think the focus for those should be on avoiding them with
proper generic infrastructure and having only selected interfaces
exported through asm/*.h or linux/*.h where that is not an option.

	Arnd
