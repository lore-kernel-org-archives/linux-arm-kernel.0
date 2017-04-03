From: horms@verge.net.au (Simon Horman)
Date: Mon, 3 Apr 2017 06:28:31 -0400
Subject: [git pull] base: soc: Improvements for the SoC bus and
 soc_device_match()
In-Reply-To: <1490950460-8945-1-git-send-email-geert+renesas@glider.be>
References: <1490950460-8945-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170403102831.GF31988@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 10:54:20AM +0200, Geert Uytterhoeven wrote:
> 	Hi Greg,
> 	Hi Arnd, Kevin, Olof,
> 	Hi Magnus, Simon,
> 
> The following changes since commit c470abd4fde40ea6a0846a2beab642a578c0b8cd:
> 
>   Linux 4.10 (2017-02-19 14:34:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git tags/soc-device-match-tag2
> 
> for you to fetch changes up to 6e12db376b60b7158e4e6006af60566f8c68f7ab:
> 
>   base: soc: Allow early registration of a single SoC device (2017-03-29 21:43:26 +0200)

Hi Geert,

I have pulled this into the renesas tree.

Hi Greg,

I would be most grateful if you could pull the above tag too.

> ----------------------------------------------------------------
> base: soc: Improvements for the SoC bus and soc_device_match()
> 
> This is a dependency for handling different SoC revisions in the Renesas
> R-Car SYSC driver, which manages PM Domains and thus needs to be
> initialized from an early_initcall().
> 
> Hence this will serve as an immutable branch between the driver core,
> arm-soc, and renesas trees, to allow queueing the Renesas R-Car SYSC
> changes on top in the renesas tree.
> 
> All changes in this pull request have been Acked by Arnd.
> 
> Thanks for pulling!
> ----------------------------------------------------------------
> Geert Uytterhoeven (2):
>       base: soc: Let soc_device_match() return no match when called too early
>       base: soc: Allow early registration of a single SoC device
> 
>  drivers/base/soc.c | 52 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 34 insertions(+), 18 deletions(-)
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
