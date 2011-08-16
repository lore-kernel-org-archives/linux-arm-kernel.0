From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Aug 2011 09:39:32 +0100
Subject: [PATCH] amba: consolidate PrimeCell magic
In-Reply-To: <CAJe_ZhfwnUhUfXtj==+Nv=XHWA+cE=sG4mkipm8zVv9+hBGACQ@mail.gmail.com>
References: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
	<CABb+yY3Bb2VnFLv8OmeqJH9FpWrpixCHPSgd0yVUnWRoFGA10Q@mail.gmail.com>
	<20110816083551.GA14312@n2100.arm.linux.org.uk>
	<CAJe_ZhfwnUhUfXtj==+Nv=XHWA+cE=sG4mkipm8zVv9+hBGACQ@mail.gmail.com>
Message-ID: <20110816083932.GB14312@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 02:08:18PM +0530, Jassi Brar wrote:
> On 16 August 2011 14:05, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Aug 16, 2011 at 01:57:08PM +0530, Jassi Brar wrote:
> >> On Mon, Aug 15, 2011 at 3:25 PM, Linus Walleij
> >> <linus.walleij@stericsson.com> wrote:
> >> > +static inline u32 amba_get_magic(void __iomem *base, u32 size, u8 offset)
> >> > +{
> >> > + ? ? ? u32 magic;
> >> > + ? ? ? int i;
> >> > +
> >> > + ? ? ? for (magic = 0, i = 0; i < 4; i++)
> >> > + ? ? ? ? ? ? ? magic |= (readl(base + size - offset + 4 * i) & 255)
> >> > + ? ? ? ? ? ? ? ? ? ? ? << (i * 8);
> >> 0xff looks much better than 255, esp when we play with bits.
> >> Also you might simply use readb and drop the sieve ?
> >
> > You're making the assumption that using byte reads are permitted. ?Given
> > that these are described as 32-bit registers, and some primecells require
> > reads of certain sizes, I believe the code to be the most correct solution.
> >
> If you notice the '?'
> I already doubt that, so I simply asked Linus to ponder the possibility.

Stop being an idiot.

If you notice, I'm giving you THE INFORMATION as to why its done that way.
I wrote the fucking code originally.  Don't you think I know what was
doing.
