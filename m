From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 5 Oct 2018 11:35:52 +0200
Subject: [PATCH 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
In-Reply-To: <20181005090941eucas1p14031cd38d78e9d561975925bf977727d~aq0-OFZeE1866318663eucas1p1b@eucas1p1.samsung.com>
References: <20180919094802.GH30658@n2100.armlinux.org.uk>
 <CGME20180919095028epcas3p3e1a927bb7e88c6891d43abfdc51603e7@epcas3p3.samsung.com>
 <E1g2Z6e-0003es-CI@rmk-PC.armlinux.org.uk>
 <20181005090941eucas1p14031cd38d78e9d561975925bf977727d~aq0-OFZeE1866318663eucas1p1b@eucas1p1.samsung.com>
Message-ID: <CAJKOXPfgSJxLFQpYAEs4Hz6b_cZ13gjUy6h1dUf9hJWz_Tv62Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Oct 2018 at 11:09, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi All,
>
> On 2018-09-19 11:49, Russell King wrote:
> > In big.Little systems, some CPUs require the Spectre workarounds in
> > paths such as the context switch, but other CPUs do not.  In order
> > to handle these differences, we need per-CPU vtables.
> >
> > We are unable to use the kernel's per-CPU variables to support this
> > as per-CPU is not initialised at times when we need access to the
> > vtables, so we have to use an array indexed by logical CPU number.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> This patch causes lots of kernel 'BUG' messages on all Samsung Exynos
> boards.  It started to appear since it has been merged to linux-next
> on 20181002.  I wonder if this issue is Exynos specific or there are
> some patches missing in linux-next, which should fix those 'BUGS'.
> If this is Exynos specific, please let us know what should be changed
> in Exynos platform code to avoid this issue.

Thanks Marek for narrowing this down.

I confirm. All my Exynos boards experience this. Full logs:
https://krzk.eu/#/builders/1/builds/2811/steps/12/logs/serial0

Best regards,
Krzysztof
