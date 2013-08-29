From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 12:56:29 -0700
Subject: [GIT PULL] arm: dts: SOCFPGA updates for v3.12
In-Reply-To: <1377729528-24305-1-git-send-email-dinguyen@altera.com>
References: <1377729528-24305-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130829195629.GL18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Wed, Aug 28, 2013 at 05:38:48PM -0500, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Hi Olof/Kevin,
> 
> This is my first pull request to you guys, so I apologize in advance if
> something is not correct.

A couple of comments:

> The following changes since commit fa8218def1b1a16f0a410e2c1c767b4738cc81fa:
> 
>   Merge tag 'regmap-v3.11-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap (2013-08-27 10:10:30 -0700)

We ask that you base your branches on a full -rc release from Linus, and it
doesn't have to be the very latest one at that -- we almost prefer one that's
already in our tree.

> are available in the git repository at:
> 
> 
>   git://git.rocketboards.org/linux-socfpga-next.git next-dt

Please push the tag to the server so it's part of the pull request. And please
write up a few sentences about what is in the branch/tag in the tag itself. See
how some of the other maintainers do it for an idea of what to have there: I'm
mostly looking for higher-level description of what is there.

> ----------------------------------------------------------------
> Dinh Nguyen (3):
>       of: add vendor prefix for Altera Corp.
>       dts: Deprecate ALTR as a vendor prefix
>       arm: dts: Change dw-apb-timer-osc and dw-apb-timer-sp to      just dw-apb-timer

The subject on this is too long and wrapped weirdly. I'd just name it
"dts: rename DW apb timers".

>  Documentation/devicetree/bindings/rtc/dw-apb.txt   |   34 +++++++-------------
>  .../devicetree/bindings/serial/altera_jtaguart.txt |    3 +-
>  .../devicetree/bindings/serial/altera_uart.txt     |    3 +-
>  .../devicetree/bindings/serio/altera_ps2.txt       |    3 +-
>  .../devicetree/bindings/spi/spi_altera.txt         |    3 +-
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  arch/arm/boot/dts/socfpga.dtsi                     |    8 ++---
>  drivers/input/serio/altera_ps2.c                   |    1 +
>  drivers/spi/spi-altera.c                           |    1 +
>  drivers/tty/serial/altera_jtaguart.c               |    1 +
>  drivers/tty/serial/altera_uart.c                   |    1 +

These changes are all DT-related, so in the future as you have more patches
this would go in a "dt" topic/category branch, and other updates might go in
other branches. That's something you'll learn as you go (and we'll help you :).


I'll take this branch and rebase/reapply the patches this time, but keep the
above in mind for next release. :)

-Olof
