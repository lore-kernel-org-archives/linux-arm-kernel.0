From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 6 Aug 2012 16:16:57 +0200
Subject: [PATCH 0/6] ARM: dove: DT support for Marvell Dove
In-Reply-To: <201208061402.22815.arnd@arndb.de>
References: <1344255815-4457-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201208061402.22815.arnd@arndb.de>
Message-ID: <CABJ1b_S6jRW9P7ygs7LPztbx1zW-u=gD1kk0UYbgBrHdvsaOeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/6/12, Arnd Bergmann <arnd@arndb.de> wrote:
> This looks vert nice!
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

thanks for the ack!

> Has anyone tested it on cm-a510 and dove-db? Once we can reasonably
> assume that there are no regressions compared to using the board
> files, I think we can plan for removing the non-DT support in
> mach-dove. If it's been tested positively, that can well be at
> the same time as adding the DT support, otherwise I think we should
> wait a couple of releases while having both simultaneously.

Unfortunately, I has not (yet) been tested on cm-a510 nor dove-db but
from the status of the exisiting non-DT setup files I strongly doubt that
anyone is using current mainline kernel for mach-dove.

I suggest to keep non-DT support until we have pinctrl and gpiolib drivers
done. Thomas Petazzoni and I have been working on pinctrl that will be
posted in a few days and gpiolib driver needs some more cleanup but is
basically working. Until then I guess most of the other orion drivers have
DT support (eth and xor IIRC).

After that I am definitely fine with removing non-DT support although
there is neither DT support in u-boot installed on my CuBox nor
mach-dove support in mainline u-boot.

Sebastian
