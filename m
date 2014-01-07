From: horms@verge.net.au (Simon Horman)
Date: Tue, 7 Jan 2014 10:16:35 +0900
Subject: [PATCH 4/4] ARM: shmobile: lager: Make spi_flash_data const
In-Reply-To: <CAMuHMdUdJgxf9EckTNKCRF-x5c+w7NAtnYoGo696B5mgESSnmQ@mail.gmail.com>
References: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
 <1388764128-27686-4-git-send-email-geert@linux-m68k.org>
 <20140106023151.GF11231@verge.net.au>
 <CAMuHMdUdJgxf9EckTNKCRF-x5c+w7NAtnYoGo696B5mgESSnmQ@mail.gmail.com>
Message-ID: <20140107011635.GB2196@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 09:09:53AM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 6, 2014 at 3:31 AM, Simon Horman <horms@verge.net.au> wrote:
> >> -static struct flash_platform_data spi_flash_data = {
> >> +static const struct flash_platform_data spi_flash_data = {
> >>       .name           = "m25p80",
> >>       .parts          = spi_flash_part,
> >>       .nr_parts       = ARRAY_SIZE(spi_flash_part),
> >
> > Should spi_flash_part also be const?
> 
> No, .parts is a non-const pointer (but perhaps it can be made const, but that
> may be more invasive, and have side-effects).
> 
> > And should flash_platform_data and spi_flash_part be annotated
> > as __initconst?
> 
> AFAIU, those are not copied.

Thanks, I will queue up this patch as is.
