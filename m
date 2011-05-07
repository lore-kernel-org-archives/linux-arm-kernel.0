From: greg@kroah.com (Greg KH)
Date: Sat, 7 May 2011 13:09:48 -0700
Subject: [PATCH 1/4] drivers: create a pinmux subsystem
In-Reply-To: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110507200948.GB19753@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2011 at 09:16:26PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This creates a subsystem for handling of pinmux devices. These are
> devices that enable and disable groups of pins on primarily PGA and
> BGA type of chip packages and common in embedded systems.
> 
> This is being done to depopulate the arch/arm/* directory of such
> custom drivers and try to abstract the infrastructure they all
> need. See the Documentation/pinmux.txt file that is part of this
> patch for more details.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/ABI/testing/sysfs-class-pinmux |   11 +
>  Documentation/pinmux.txt                     |  306 +++++++++++
>  MAINTAINERS                                  |    5 +
>  drivers/Kconfig                              |    4 +
>  drivers/Makefile                             |    2 +
>  drivers/pinmux/Kconfig                       |   26 +
>  drivers/pinmux/Makefile                      |    5 +
>  drivers/pinmux/core.c                        |  740 ++++++++++++++++++++++++++
>  include/linux/pinmux.h                       |  224 ++++++++
>  9 files changed, 1323 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-pinmux

As someone who constantly has to harp on adding documentation for sysfs
files that are added to the kernel tree, it's nice to see this done
correctly.

Good job,

greg k-h
