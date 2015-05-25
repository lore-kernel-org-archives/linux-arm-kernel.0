From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 May 2015 10:14:32 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: Enable shmobile r8a7778 (M1A)
In-Reply-To: <CAMuHMdW4=ZA5STuUm1zBypRtfuQtrD=2rBDW5GBGRS--zGMbzw@mail.gmail.com>
References: <1429196897-18822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <552FDD73.70805@cogentembedded.com>
 <CAMuHMdW4=ZA5STuUm1zBypRtfuQtrD=2rBDW5GBGRS--zGMbzw@mail.gmail.com>
Message-ID: <20150525011431.GG24690@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 06:08:08PM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 16, 2015 at 6:04 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > On 04/16/2015 06:08 PM, Ulrich Hecht wrote:
> >
> >> Also enables RTC (RX8581) and camera (ML86V7667) drivers as modules.
> 
> I think this is identical to
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327624.html?

I think so too. And I also now understand that it is appropriate for me
to take such patches. Accordingly I have queued up the patch at the link
above for v4.2.

> >> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >> ---
> >>   arch/arm/configs/multi_v7_defconfig | 3 +++
> >>   1 file changed, 3 insertions(+)
> >
> >
> >> diff --git a/arch/arm/configs/multi_v7_defconfig
> >> b/arch/arm/configs/multi_v7_defconfig
> >> index 06075b6..212199a 100644
> >> --- a/arch/arm/configs/multi_v7_defconfig
> >> +++ b/arch/arm/configs/multi_v7_defconfig
> >
> > [...]
> >>
> >> @@ -500,6 +502,7 @@ CONFIG_RTC_DRV_SUN6I=y
> >>   CONFIG_RTC_DRV_SUNXI=y
> >>   CONFIG_RTC_DRV_MV=y
> >>   CONFIG_RTC_DRV_TEGRA=y
> >> +CONFIG_RTC_DRV_RX8581=m
> >
> >    The other RTC drivers seem to be built-in.
> 
> The current trend is to make "non-core" functionalities modular, to
> reduce kernel size.
> 
> Yes, this means many of the existing options should be changed from
> y to m.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
