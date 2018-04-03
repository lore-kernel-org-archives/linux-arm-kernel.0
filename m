From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2018 09:15:03 +0200
Subject: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
Message-ID: <CAK8P3a20etAsuj_-b2UbtPcTdB0ry7CZbh660omTk=c_eY8N6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2018 at 4:26 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Hi,
>
> This serie is aimed at removing the dmaengine slave compat use, and transfer
> knowledge of the DMA requestors into architecture code.
>
> This was discussed/advised by Arnd a couple of years back, it's almost time.
>
> The serie is divided in 3 phasees :
>  - phase 1 : patch 1/15 and patch 2/15
>    => this is the preparation work
>  - phase 2 : patches 3/15 .. 10/15
>    => this is the switch of all the drivers
>    => this one will require either an Ack of the maintainers or be taken by them
>       once phase 1 is merged
>  - phase 3 : patches 11/15
>    => this is the last part, cleanup and removal of export of the DMA filter
>       function
>
> As this looks like a patch bomb, each maintainer expressing for his tree either
> an Ack or "I want to take through my tree" will be spared in the next iterations
> of this serie.
>
> Several of these changes have been tested on actual hardware, including :
>  - pxamci
>  - pxa_camera
>  - smc*
>  - ASoC and SSP
>
> Happy review.

This looks really great overall, thanks for cleaning this up!

The SSP part is still a bit weird, as I commented, but I'm sure we can
figure something out there.

    Arnd
